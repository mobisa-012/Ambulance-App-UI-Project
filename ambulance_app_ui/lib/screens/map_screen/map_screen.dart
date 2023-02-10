import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:flutter/material.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 1.0,
        centerTitle: true,
        title: Text(TextConstants.orderAmbulance),
        automaticallyImplyLeading: false,        
      ),
      body: Stack(

      ),
    );
  }
}