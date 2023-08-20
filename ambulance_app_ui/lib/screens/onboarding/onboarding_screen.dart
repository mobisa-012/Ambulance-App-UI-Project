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
              height: 55,
            ),
            _createName(),
            const SizedBox(
              height: 85,
            ),
            _createJoinFamilyButton(context),
            const SizedBox(
              height: 150,
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
      children:  [
        Text(
          'Hosy',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              color: Color.fromARGB(200, 115, 64, 255)),
        ),
        SizedBox(
          height: 20,
        ),
       
      ],
    );
  }

  Widget _createJoinFamilyButton(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromARGB(200, 115, 64, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const MobileAuth()));
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
      children:  [
        Icon(
          Icons.copyright_outlined,
          size: 20,
          color: Color.fromARGB(200, 115, 64, 255),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '2023|Yvonne M',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromARGB(200, 115, 64, 255)),
        )
      ],
    );
  }
}
