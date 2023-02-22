import 'dart:async';
import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:ambulance_app_ui/screens/map_screen/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final panelController = PanelController();
  late LatLng userLocation = LatLng(0, 0);
  late MapController mapController = MapController();
  Timer? timer;
  var state = 0;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  void getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void dispose() {
    mapController.dispose();
    super.dispose();
  }

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
          Icons.location_searching,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.onboardingColor,
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
                center: userLocation,
                zoom: 18,
                maxZoom: 15,
                minZoom: 0,
                bounds: LatLngBounds(
                  LatLng(-1.28333, 36.81667),
                  LatLng(-1.28333, 36.81667),
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
                    point: userLocation,
                    builder: (context) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 45,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          SlidingUpPanel(
            padding: const EdgeInsets.all(12),
            isDraggable: true,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            minHeight: MediaQuery.of(context).size.height * 0.65,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            panel: OrderScreenDetails(
              panelController: panelController,
            ),
          )
        ],
      ),
    );
  }
}
