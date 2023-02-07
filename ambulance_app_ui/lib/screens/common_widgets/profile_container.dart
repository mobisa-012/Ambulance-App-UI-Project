import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final bool withArrow;
  final Widget child;
  final Function()? onTap;
  const ProfileContainer({super.key, this.withArrow= false, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.homeBackground,
          boxShadow: [
            BoxShadow(
              color: AppColors.textColor.withOpacity(0.12),
              blurRadius: 5.0,
              spreadRadius: 1.1
            )
          ]
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: child),
                  if(withArrow)
                  const Icon(Icons.arrow_forward_ios_outlined,
                  color: AppColors.onboardingColor,
                  size: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
