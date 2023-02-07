import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final bool withInfo;
  final Widget name;
  final Function() onTap;
  
  const HospitalCard({super.key, required this.withInfo, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColors.homeBackground,
            boxShadow: [
              BoxShadow(
                  color: AppColors.textColor.withOpacity(0.12),
                  blurRadius: 5.0,
                  spreadRadius: 1.1)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: name,
                  ),
                  if(withInfo)
                  const Icon(Icons.info_outline_rounded,
                  size: 22,
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
