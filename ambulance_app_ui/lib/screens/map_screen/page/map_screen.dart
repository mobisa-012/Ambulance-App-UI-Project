import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Set<Marker> createMarker() {
  //   return Marker(
  //     markerId: MarkerId('marker1'),
  //     position: center,
  //     infoWindow: InfoWindow(
  //       title: 'Me',
  //     )
  //     );
  // }

  final LatLng center = LatLng(-1.286389,36.817223);
  late GoogleMapController controller;
  void onMapCreated(GoogleMapController mapController) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Order Ambulance',
        ),
        titleTextStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        elevation: 2,
      ),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        trafficEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(target: center, zoom: 11),
        // markers: createMarker,
      ),
    );
  }
}
