import 'package:ambulance_app_ui/screens/common_widgets/hospital_widget.dart';
import 'package:flutter/material.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: hInfo.length.toDouble() ~/ 2,
      itemBuilder: (_, i) {
        int a = 2 * i;
        int b = 2 * i + 1;
        return HospitalWidget(
          onTap: () {},
          //should open the hospitals page
          child: Row(
            children: [
              Image(image: AssetImage(hInfo[a]['image'])),
              const SizedBox(
                height: 30,
              ),
              Text(
                hInfo[b]['name'],
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
              )
            ],
          ),
        );
      },
    ));
  }
}
