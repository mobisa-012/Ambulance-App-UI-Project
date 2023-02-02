import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:flutter/material.dart';


class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(TextConstants.needAnAmbulance),
        automaticallyImplyLeading: false,        
      ),
      body: SingleChildScrollView(

      ),
    );
  }
}