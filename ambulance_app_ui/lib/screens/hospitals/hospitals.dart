import 'package:ambulance_app_ui/screens/common_widgets/hospital_card.dart';
import 'package:flutter/material.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListView(
          scrollDirection: Axis.vertical,
          children: [
            HospitalCard(
              withInfo: true, 
              name: Text('KNH $index',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),), 
              onTap: () {},
              )
          ],
        );
      },
    );
  }
}
