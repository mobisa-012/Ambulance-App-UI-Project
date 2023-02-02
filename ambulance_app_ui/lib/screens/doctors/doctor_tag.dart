import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:flutter/material.dart';

class DoctorTag extends StatelessWidget {
  // final String content;
  final String icon;
  
  const DoctorTag({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.onboardingColor),
      child: Row(
        children: [
          Image.asset(icon, height: 16, width: 16,
          fit: BoxFit.fill,),
          const SizedBox(width: 7,),
          // Text(
          //   content,
          //   style: TextStyle(
          //     color: AppColors.onboardingColor,
          //     fontSize: 14,
          //     fontWeight: FontWeight.w400
          //   ),
          // )
        ],
      ),
    );
  }
}
