import 'dart:async';
import 'dart:convert';

import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/dit.dart';
import 'package:ambulance_app_ui/core/const/heights.dart';
import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/core/data/ambulance.dart';
import 'package:ambulance_app_ui/core/data/service_order.dart';
import 'package:ambulance_app_ui/screens/map_screen/widget/first_panle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mpesadaraja/mpesadaraja.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart'  as loc;
import 'package:http/http.dart' as http;


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
  loc.LocationData? currentLocation;
  Set<Polyline> polylines ={};
  final preferredLocationController = TextEditingController();
  String eta ='';
  String distance = '';
  String calculatedTotalCost ='';
  bool isCustomLocation = false;
  String googleApiKey ="AIzaSyB4QwU_ICnLEmJsvmVYz0KtzX-cDFtDSeQ";
  final packageController = TextEditingController();
  Timer? debounceTimer;

  @override
  void initState() {
    super.initState();
    loadAmbulances();
  }

  void onSetLocationButtonClicked() async {
  String preferredLocationQuery = preferredLocationController.text;
  List<Location> locations = await locationFromAddress(preferredLocationQuery);
  if (locations.isNotEmpty) {
    // Convert LatLng to loc.LocationData and update currentLocation.
    loc.LocationData newLocationData = loc.LocationData.fromMap({
      'latitude': locations.first.latitude,
      'longitude': locations.first.longitude,
    });
    setState(() {
      currentLocation = newLocationData;
    });

    // Optionally, update the map to show the new current location.
    GoogleMapController googleMapController = controller;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(newLocationData.latitude!, newLocationData.longitude!),
          zoom: 11,
        ),
      ),
    );
    addRoutePolyline();
    getDirections();
  } else {
    // Handle case when no location is found for the entered query.
    print('Location not found for the given search query.');
  }
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

  void getCurrentLocation() async {
  loc.Location location = loc.Location();
  location.getLocation().then((location) async {
    currentLocation = location;
    String currentAddress = await getAddressFromCoordinates(
      location.latitude!, location.longitude!);
    preferredLocationController.text = currentAddress;
  });
  GoogleMapController googleMapController = controller;
  location.onLocationChanged.listen((newLocation) {
    currentLocation = newLocation;
    // Update the map with the new location.
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 11,
          target: LatLng(
            newLocation.latitude!, 
            newLocation.longitude!,
            ))));
            setState(() {
              
            });
  });
}

String formattedPhoneNumber(String phoneNumber) {
  if (phoneNumber.startsWith('+')) {
    return phoneNumber.substring(1);
  }
  return phoneNumber;
}

Future<void> initiatePayment() async {
  final stk = MpesaDaraja(
    consumerKey: 'PDGOKqUZnxrrOj903SVafCQmarS7QHwJ',
    consumerSecret: 'Z7JnnQfVCw51Tuqn',
    passKey: 'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919',
  );

  int amount = int.parse(calculatedTotalCost.replaceAll(RegExp(r'[^\d]'), ''));

  final User? user = FirebaseAuth.instance.currentUser;
  String userPhoneNumber = '';

  if (user != null) {
    userPhoneNumber = user.phoneNumber ?? '';
    userPhoneNumber = formattedPhoneNumber(userPhoneNumber);
  } else {
    return;
  }

  await stk.lipaNaMpesaStk(
    "174379",
    amount,
    userPhoneNumber,
    "174379",
    userPhoneNumber,
    "https://a7ad-41-80-115-29.ngrok-free.app",
    "FIKISHA RIDERS",
    "transactionDesc",
  );
}

Future<void> showDisclosureDialog(BuildContext context) async {
  return showDialog<void> (
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          'This app collects location data to enable efficient delivery services even when the app is closed or not in use.' 
          'This data is used solely for the'
          'purpose of providing accurate delivery tracking and optimizing routes.'
        ),
        title: const Text('Location Permissions'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: const Text('Cancel')
            ),
            ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              getCurrentLocation();
            }, 
            child: const Text('Continue')
            ),
        ],
      );
    }
  );
}

  void addRoutePolyline() async {
    if (currentLocation != null) {
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        googleApiKey, // Replace with your actual Google Maps API key
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(destination!.latitude, destination!.longitude),
      );
      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        setState(() {
          polylines.clear();
          polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              points: polylineCoordinates,
              color: Colors.red,
              width: 6,
            ),
          );
        });
      }
    }
  }

Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    final apiKey = googleApiKey;
    final apiUrl = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if(response.statusCode == 200){
        Map<String, dynamic> data = json.decode(response.body);
        if(data['status'] == 'OK'){
          return data['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

void getDirections() async {
  if (currentLocation == null || destination == null) {
    return;
  }
  String apiUrl =
      'https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation!.latitude},${currentLocation!.longitude}&destination=${destination!.latitude},${destination!.longitude}&key=$googleApiKey';
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final durationText = data['routes'][0]['legs'][0]['duration']['text'] as String;
    final distanceText = data['routes'][0]['legs'][0]['distance']['text'] as String;
    setState(() {
      eta = durationText;
      distance = distanceText;
    });
  } else {
    print('Failed to fetch directions.');
  }
}

void onSearchLocation(String location) async {
  String query = locationController.text;
  List<Location> locations = await locationFromAddress(query);
  if (locations.isNotEmpty) {
    // Show the disclosure dialog before proceeding with the search
    if (!isCustomLocation) {
      await showDisclosureDialog(context);
      setState(() {
        isCustomLocation = true;
      });
    }

    setState(() {
      destination = LatLng(locations.first.latitude, locations.first.longitude);
    });
    controller.animateCamera(CameraUpdate.newLatLng(destination!));
    addRoutePolyline();
    getDirections();
    // scheduleTrip(context);
    if (currentLocation != null && destination != null) {
      double distanceInKm = (Geolocator.distanceBetween(
        currentLocation!.latitude!,
        currentLocation!.longitude!,
        destination!.latitude,
        destination!.longitude,
      ) / 1000); // Convert distance to kilometers
      final firestore = FirebaseFirestore.instance;
      DocumentSnapshot documentSnapshot = await firestore.collection('fikisha_base_price').doc('base_price').get();
      int price5PerKm = (documentSnapshot.data() as Map<String, dynamic>)['cost'];
      int pricePerExtraKm = (documentSnapshot.data() as Map<String, dynamic>)['extra_km_price'];
      int calculatedPriceValue = 0;
      if (distanceInKm <= 5) {
        calculatedPriceValue = price5PerKm;
      } else {
        calculatedPriceValue = (price5PerKm + (distanceInKm - 5) * pricePerExtraKm).toInt();
      }
      calculatedTotalCost = 'sh. ${calculatedPriceValue.toStringAsFixed(0)}';
      setState(() {});
      confrimService(context);
    } else {
      print('Error: Unable to calculate distance or destination is null.');
    }
  } else {
    // Handle case when no location is found for the search query.
    print('Location not found for the given search query.');
  }
}

confrimService(BuildContext context) async {
  DateTime currentDate = DateTime.now();
  String formattedDate = DateFormat('yyy-MM-dd').format(currentDate);
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (context) {
      return Container(
      padding: const EdgeInsets.only(top: 7),
      height: context.screenHeight() / 1.4,
      width: context.screenWidth(),
      decoration: const BoxDecoration(
        color: AppColors.primarywhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          // sheetHeader(),
          const YMargin(15),
          const Text(
            "Delivery details",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: AppColors.primarydark,
            ),
          ),
          const Text(
            "Please enter the package details",
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: AppColors.offBlack,
            ),
          ),
          const YMargin(14),
          const DotWidget(
            dashColor: AppColors.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(14),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "DELIVERY COST",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryblack,
                      ),
                    ),
                    const YMargin(10),
                    Row(
                      children: [                  
                        const XMargin(35),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                calculatedTotalCost,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primarydark,
                                ),
                              ),
                              // const Text(
                              //   "Final Cost",
                              //   style: TextStyle(
                              //     fontSize: 10.0,
                              //     fontWeight: FontWeight.w500,
                              //     color: AppColors.primarydark,
                              //   ),
                              // ),
                            ])
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const YMargin(14),
          const DotWidget(
            dashColor: AppColors.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery Details",
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryblack,
                  ),
                ),
                const YMargin(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(PathConstants.side),
                    const XMargin(10),
                     Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Current Location",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryblack,
                          ),
                        ),
                        const YMargin(5),
                        Text(
                          preferredLocationController.text,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF818181),
                          ),
                        ),
                        const YMargin(30),
                        const Text(
                          "Destination",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryblack,
                          ),
                        ),
                        const YMargin(5),
                         Text(
                          locationController.text,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            color: AppColors.offBlack,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const YMargin(14),
          const DotWidget(
            dashColor: AppColors.primaryfield,
            dashHeight: 1.0,
            dashWidth: 2.0,
          ),
          const YMargin(14),
          const YMargin(10),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
          controller: packageController,
          decoration: InputDecoration(
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15)),
             labelText: 'Enter the package name as wrapped',                        
            ),
          validator: (value) {
            if (value!.isEmpty) {
          return 'Please enter name package';
            }
            return null;
          },
            ),
          ), 
          const YMargin(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButton(
             onPressed: () async{
                  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  final User? user = firebaseAuth.currentUser;
                  if(user!=null ) {
                    final String uid = user.uid;
                    ServicesAppointment servicesAppointment = ServicesAppointment(
                    date: formattedDate, 
                    addressDestination: locationController.text,
                    sourceAddress: preferredLocationController.text,
                    amount: calculatedTotalCost,
                    packageType: packageController.text
                    );
                    await FirebaseFirestore.instance.collection(
                      'fikisha_delivery_history'
                    ).doc(uid).collection('deliveries_ordered').add(servicesAppointment.toJson());
                      initiatePayment();                   
                      Navigator.pop(context);
                  } else {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text(
                            'Log in first to make a delivery order'
                          ),
                        );
                      }
                      );
                  }     
                },  
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarygreen,
                minimumSize: Size(MediaQuery.of(context).size.width , 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                 ),
              ),
            child: const Text(
              'Confirm delivery',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
            ),
          ),
          const YMargin(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Container(
              height: 40,
              width: context.screenWidth(),
              decoration: BoxDecoration(
                color: AppColors.primaryred,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cancel Delivery",
                      style: TextStyle(
                        color: AppColors.primarywhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
        );
});
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
              top: 20,
              child: Column(
                children: [
                  TextField(
                    controller: preferredLocationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: 'Where it\' coming from...',
                        suffixIcon: IconButton(
                          onPressed: onSetLocationButtonClicked,
                          icon: const Icon(Icons.location_pin,
                          color: Colors.black,
                          size: 25,),
                        ),
                        ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: locationController,
                    onChanged: (newText) {
                     if (debounceTimer != null && debounceTimer!.isActive) {
                        debounceTimer!.cancel();
                      }
                    debounceTimer = Timer(const Duration(seconds: 2), () {
                    onSearchLocation(newText);
                  });
                    },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Where it\'s going to..',
                    ),
                    ) ,                                
                ],
              )
              )
        ],
      ),
    );
  }
}
