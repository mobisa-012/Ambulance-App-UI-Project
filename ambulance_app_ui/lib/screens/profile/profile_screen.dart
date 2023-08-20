import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/core/const/text_constants.dart';
import 'package:ambulance_app_ui/screens/common_widgets/profile_container.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage(PathConstants.profile),
                      radius: 60,
                    ),
                  ),
                  TextButton(
                  onPressed: () {}, 
                  style: TextButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: AppColors.onboardingColor.withOpacity(0.15)
                  ),
                  child: const Icon(Icons.edit,
                  color: AppColors.onboardingColor,),
                  )
                ],
              ),
              const SizedBox(height: 15,),
              Text(TextConstants.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),),
              const SizedBox(height: 15,),
              ProfileContainer(
                withArrow: true,
                onTap: () {},
                child: Text('Payment',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),),
              ),
              ProfileContainer(
                withArrow: true,
                onTap: () {},
                child: Text('Invite Friends',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),),
              ),
              ProfileContainer(
                withArrow: true,
                onTap: () {},
                child: Text('Rate us now',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
                ),),
              ),
              // ProfileContainer(
              //   withArrow: true,
              //   onTap: () {},
              //   child: Text('Notifications',
              //   style: TextStyle(
              //     fontSize: 17,
              //     fontWeight: FontWeight.w500
              //   ),),
              // ),
              const SizedBox(height: 15,),
              Text('Join our community',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600
              ),),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {}, 
                    child: Image.asset(PathConstants.invite),
                    ),
                    TextButton(
                    onPressed: () {}, 
                    child: Image.asset(PathConstants.invite),
                    ),
                    TextButton(
                    onPressed: () {}, 
                    child: Image.asset(PathConstants.invite),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
