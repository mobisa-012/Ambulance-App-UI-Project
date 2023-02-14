import 'dart:async';

import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapController = MapController();
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        // shape: ContinuousRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        // ),
        child: Icon(
          Icons.navigation_rounded,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1.0,
        centerTitle: true,
        title: Text(TextConstants.orderAmbulance),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                onPositionChanged: (MapPosition position, bool hasGesture) {
                  timer?.cancel();
                  timer = Timer(Duration(seconds: 1), () {
                    print(position);
                  });
                },
                // onTap: () {},
                center: LatLng(45.37, 0.1785),
                zoom: 18,
                maxZoom: 15,
                minZoom: 0,
                bounds: LatLngBounds(
                  LatLng(-1.28333, 36.81667),
                  LatLng(51.25709, 0.34018),
                ),
                maxBounds: LatLngBounds(LatLng(-90, -180), LatLng(90, 180))),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
                // subdomains: ['a','b','c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    height: 80,
                    width: 80,
                    point: mapController.center, 
                    builder: (context) => Container(
                      child: Icon(Icons.location_on),
                    ),
                    )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
