import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final bool isEnabled;
  final String hospitalName;
  final Function() onTap;
  
  const CallButton({super.key,  this.isEnabled = true, required this.hospitalName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.onboardingColor:AppColors.grayColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onTap,
          child: Center(
            child: Text(TextConstants.call,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}
