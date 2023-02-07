import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final Widget image;
  final Function() onTap;
  final String doctorName;
  final bool withArrow;

  const DoctorCard(
      {super.key,
      required this.image,
      required this.onTap,
      required this.doctorName, required this.withArrow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(color: AppColors.homeBackground, boxShadow: [
          BoxShadow(
            color: AppColors.textColor.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          )
        ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: image),
                  if(withArrow)
                  const Icon(Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: AppColors.onboardingColor,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
