import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:ambulance_app_ui/screens/common_widgets/doctor_card.dart';
import 'package:ambulance_app_ui/screens/doctors/widgets/doctor_body.dart';
import 'package:flutter/material.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 80),
      child: Column(
        children: [
          _findADoctor(context),
          const SizedBox(
            height: 30,
          ),
          _DoctorBody(context),
        ],
      ),
    );
  }

  Widget _findADoctor(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            TextConstants.hello,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            TextConstants.letsFindDoctor,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _DoctorBody(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return DoctorCard(
          withArrow: true,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DoctorBody()));
          },
          image: Image.asset(PathConstants.profile),
          doctorName: 'Dr.Mobisa $index',
        );
      },
    );
  }
}
