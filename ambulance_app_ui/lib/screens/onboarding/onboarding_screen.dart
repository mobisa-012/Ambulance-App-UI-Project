import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/screens/login/phone_auth.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding:
            const EdgeInsets.only(top: 150, left: 12, right: 12, bottom: 10),
        decoration: const BoxDecoration(color: AppColors.homeBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _createChurchLogo(),
            const SizedBox(
              height: 60,
            ),
            _createName(),
            const SizedBox(
              height: 90,
            ),
            _createJoinFamilyButton(context),
            const SizedBox(
              height: 120,
            ),
            _createDevsName(),
          ],
        ),
      ),
    );
  }

  Widget _createChurchLogo() {
    return Center(
      child: Image.asset(PathConstants.onboarding),
    );
  }

  Widget _createName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          'Hosy',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              color: AppColors.homeBackground),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Hosy',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: AppColors.homeBackground),
        ),
      ],
    );
  }

  Widget _createJoinFamilyButton(BuildContext context) {
    return Container(
      height: 70,
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.homeBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const PhoneAuthPage()));
          },
          child: const Text(
            'Order Ambulance',
            style: TextStyle(
                color: AppColors.textColor,
                fontSize: 28,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _createDevsName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.copyright_outlined,
          size: 20,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'Yvonne M',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
        )
      ],
    );
  }
}
