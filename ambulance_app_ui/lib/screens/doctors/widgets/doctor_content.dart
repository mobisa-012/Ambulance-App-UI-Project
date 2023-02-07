import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/data/doctor_data.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DoctorContent extends StatefulWidget {
  final DoctorData data;

  const DoctorContent({super.key, required this.data});

  @override
  State<DoctorContent> createState() => _DoctorContentState();
}

class _DoctorContentState extends State<DoctorContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.homeBackground,
      child: _createSlidingUpPanel(context),
    );
  }

  Widget _createSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      // panel: DoctorDataDetails(doctorData: data),
      // body: DoctorBody(doctorData: data),
      minHeight: MediaQuery.of(context).size.height * 0.65,
      maxHeight: MediaQuery.of(context).size.height * 0.87,
      isDraggable: true,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50), topLeft: Radius.circular(50)),
    );
  }
}
