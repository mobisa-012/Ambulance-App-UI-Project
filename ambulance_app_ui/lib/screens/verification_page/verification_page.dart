import 'package:ambulance_app_ui/core/colors.dart';
import 'package:ambulance_app_ui/core/text_constants.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(TextConstants.orderAmbulance),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.onboardingColor,
          centerTitle: true,
          titleSpacing: 2.0,
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _createText(context),
              const SizedBox(
                height: 15,
              ),
              _createTextController(context),
              const SizedBox(
                height: 35,
              ),
              _createVerifyTextButton(context),
              const SizedBox(
                height: 15,
              ),
              _createOTPBox(context),
            ],
          ),
        ));
  }

  Widget _createText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(TextConstants.phoneNumber)],
    );
  }

  Widget _createTextController(BuildContext context) {
    TextEditingController controller;
    return TextField();
  }

  Widget _createVerifyTextButton(BuildContext context) {
    return Row();
  }

  Widget _createOTPBox(BuildContext context) {
    return Row();
  }
}
