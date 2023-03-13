import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FirstPanel extends StatefulWidget {
  FirstPanel({super.key});

  @override
  State<FirstPanel> createState() => _FirstPanelState();
}

class _FirstPanelState extends State<FirstPanel> {
  final PanelController panelController1 = PanelController();
  final PanelController panelController2 = PanelController();
  late GoogleMapController controller;
  final TextEditingController locationController = TextEditingController();

  void submitOrder() {}
  void navToSecondPanel() {
    panelController1.close();
    panelController2.open();
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            'Enter your location',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: locationController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on,
                    color: Color.fromARGB(200, 115, 64, 255)),
                hintText: 'e.g harambee Avenue Nairobi',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
          ),
          const SizedBox(
            height: 6,
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(200, 115, 64, 255),
                  minimumSize: Size(100, 50)),
              onPressed: submitOrder,
              child: Text(
                'Search',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(200, 115, 64, 255),
                  minimumSize: Size(200, 50)),
              onPressed: navToSecondPanel,
              child: Text(
                'Order',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
