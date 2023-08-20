import 'package:ambulance_app_ui/core/data/ambulance.dart';
import 'package:ambulance_app_ui/screens/map_screen/widget/first_panle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LatLng center = LatLng(-1.286389, 36.817223);
  final locationController = TextEditingController();
  late GoogleMapController controller;
  final PanelController panelController = PanelController();
  List<Marker> markers = [];
  LatLng? destination;

  @override
  void initState() {
    super.initState();
    loadAmbulances();
  }

  void loadAmbulances() async {
    final ambulancesDocs =
        await FirebaseFirestore.instance.collection('Ambulances').get();
    final ambulances = ambulancesDocs.docs.map((doc) {
      final data = doc.data();
      final location = data['location'] as GeoPoint;
      return Ambulance(
        plateNo: data['plateNo'],
        ambType: data['ambType'],
        image: data['image'],
        location: LatLng(location.latitude, location.longitude),
        cost: data['cost'],
      );
    }).toList();
    setState(() {
      markers = ambulances.map((ambulance) {
        return Marker(
            markerId: MarkerId(ambulance.plateNo),
            position: ambulance.location,
            infoWindow: InfoWindow(
                title: ambulance.ambType,
                snippet: '${ambulance.plateNo} - ${ambulance.cost}'));
      }).toList();
    });
  }

  // void onCameraIdle() async {
  //   if (destination == null) {
  //     return;
  //   }
  //   final LatLngBounds bounds = await controller.getVisibleRegion();
  //   if (bounds.contains(destination!)) {
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StreamBuilder(
  //           stream:
  //               FirebaseFirestore.instance.collection('Ambulances').snapshots(),
  //           builder: (context, snapshot) {
  //             if (!snapshot.hasData) {
  //               return CircularProgressIndicator();
  //             }
  //             return Expanded(
  //               child: ListView.builder(
  //                   itemCount: snapshot.data!.docs.length,
  //                   itemBuilder: (context, index) {
  //                     DocumentSnapshot ambulance = snapshot.data!.docs[index];
  //                     return ListTile(
  //                       onTap: () {},
  //                       trailing: Text(ambulance['plateNo']),
  //                       leading: CircleAvatar(
  //                         backgroundImage: NetworkImage(ambulance['image']),
  //                       ),
  //                       subtitle: Text(ambulance['cost']),
  //                       title: Text(ambulance['ambType']),
  //                     );
  //                   }),
  //             );
  //           },
  //         );
  //       },
  //     );
  //   }
  // }

  void onMapCreated(GoogleMapController mapController) {
    controller = mapController;
  }

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
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Ambulance'),
        backgroundColor: Color.fromARGB(255, 134, 97, 236),
        centerTitle: true,
        elevation: 2,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SlidingUpPanel(            
            panelBuilder: (controller) => FirstPanel(
              controller: controller,
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              minHeight: panelHeightClosed,
             maxHeight: panelHeightOpened,
            controller: panelController,
            isDraggable: true,
            body: GoogleMap(
              initialCameraPosition: CameraPosition(target: center, zoom: 15),
              onMapCreated: onMapCreated,
              markers: markers.toSet(),
            ),
          ),
          Positioned(
              left: 16,
              right: 16,
              top: 18,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Enter destination',
                    suffixIcon: IconButton(
                      onPressed: searchLocations,
                      icon: Icon(
                        Icons.search,
                        color: Colors.deepPurpleAccent,
                        size: 30,
                      ),
                    )),
              )),
        ],
      ),
    );
  }
}
