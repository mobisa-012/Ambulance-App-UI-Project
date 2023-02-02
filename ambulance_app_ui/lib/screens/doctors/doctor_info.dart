import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:flutter/material.dart';

class DoctorInfo extends StatefulWidget {
  const DoctorInfo({super.key});

  @override
  State<DoctorInfo> createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.homeBackground,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createImage() {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: AssetImage(PathConstants.profile),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    return Positioned(
      left: 20,
      top: 15,
      child: SafeArea(
        child: GestureDetector(
          child: SizedBox(
            width: 30,
            height: 30,
            child: Icon(Icons.arrow_back_ios_outlined),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
