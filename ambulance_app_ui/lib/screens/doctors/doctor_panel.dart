import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Doctoranel extends StatefulWidget {
  const Doctoranel({super.key});

  @override
  State<Doctoranel> createState() => _DoctoranelState();
}

class _DoctoranelState extends State<Doctoranel> {
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
      panel: ,
      body: ,
      minHeight: MediaQuery.of(context).size.height*0.65,
      maxHeight: MediaQuery.of(context).size.height*0.87,
      isDraggable: true,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(50),
        topLeft: Radius.circular(50)
      ),
    );
  }
}
