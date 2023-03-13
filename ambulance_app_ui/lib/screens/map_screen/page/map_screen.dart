import 'package:ambulance_app_ui/core/data/ambulance.dart';
import 'package:ambulance_app_ui/core/data/hospitals.dart';
import 'package:ambulance_app_ui/screens/map_screen/widget/first_panle.dart';
import 'package:ambulance_app_ui/screens/map_screen/widget/orderwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PanelController panelController = PanelController();
 
  final TextEditingController locationController = TextEditingController();
  // final TextEditingController destinationController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? ambulancesCollection;
  CollectionReference? hospitalsCollection;
  List<Ambulance> ambulances = [];
  late loc.Location location;
  bool isSecondPanelOpen = false;

   void navToSecondPanel() {
    
  }

  void initState() {
    super.initState();
    ambulancesCollection = FirebaseFirestore.instance.collection('ambulance');

    getAmbulances().listen((querySnapshot) {
      final List<Ambulance> updatedAmbulances = [];
      for (final documentSnapshot in querySnapshot.docs) {
        final ambulance = Ambulance.fromSnapshot(documentSnapshot);
        updatedAmbulances.add(ambulance);
      }
      setState(() {
        ambulances = updatedAmbulances;
      });
    });
    requestLocationPermission();
  }

  void requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      setState(() {
        ambulancesCollection = null;
      });
    }
  }

  Stream<QuerySnapshot> getAmbulances() {
    return ambulancesCollection?.snapshots() ?? Stream.empty();
  }

  Stream<QuerySnapshot> getHospitals() {
    return hospitalsCollection!.snapshots();
  }

  final LatLng center = LatLng(-1.286389, 36.817223);
  late GoogleMapController controller;
  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

  void submitOrder() {}

  

  void searchLocations() async {
    final query = locationController.text;
    if (query.isEmpty) {
      return;
    }
    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) {
        return;
      }
      final lng = LatLng(locations.first.latitude, locations.first.longitude);
      controller.animateCamera(CameraUpdate.newLatLngZoom(lng, 15));
      setState(() {
        Marker(
            markerId: MarkerId('search locations'),
            position: lng,
            infoWindow: InfoWindow(title: 'Selected Location'));
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (ambulancesCollection == null) {
      //if location denied
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(200, 115, 64, 255),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Order Ambulance',
          ),
          titleTextStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          elevation: 2,
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: center, zoom: 11),
          onMapCreated: onMapCreated,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(200, 115, 64, 255),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Order Ambulance',
        ),
        titleTextStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        elevation: 2,
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            // panelBuilder: (scrollController) =>
            //     isSecondPanelOpen ? OrderWidget() : FirstPanel(),
            // onPanelClosed: () {
            //   setState(() {
            //     isSecondPanelOpen = false;
            //   });
            // },
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            controller: panelController,
            minHeight: 50,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            panel: FirstPanel(),
            body: GoogleMap(
              onMapCreated: onMapCreated,
              trafficEnabled: true,
              initialCameraPosition: CameraPosition(target: center, zoom: 11),
              markers: Set<Marker>.of(ambulances.map((ambulance) => Marker(
                  markerId: MarkerId(ambulance.id),
                  position: LatLng(ambulance.lat, ambulance.lng),
                  icon: controller != null
                      ? BitmapDescriptor.fromBytes(ambulance.image)
                      : BitmapDescriptor.defaultMarker,
                  infoWindow: InfoWindow(title: ambulance.ambType)))),
            )),
            
            ],
      ),
    );
  }
 }
