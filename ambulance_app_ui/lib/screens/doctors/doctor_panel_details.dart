import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/core/data/doctor_data.dart';
import 'package:ambulance_app_ui/screens/doctors/doctor_tag.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final DoctorData doctorData;

  const MyWidget({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return _createPanelData();
  }

  Widget _createPanelData() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        _createRectangle(),
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createHeader(),
            const SizedBox(
              height: 19,
            ),
            _createDoctorData(),
            const SizedBox(
              height: 19,
            ),
            _createDoctorList()
          ],
        ))
      ],
    );
  }

  Widget _createRectangle() {
    return const Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        '${doctorData.name}',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _createDoctorData() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(child: 
        Row(
          children: [
            DoctorTag(
              content: '${doctorData}', 
              icon: PathConstants.profile)
          ],
        ))
      ],
    );
  }
}
