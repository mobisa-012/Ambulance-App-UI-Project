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
          backgroundColor: Color.fromARGB(224, 138, 118, 230),
          centerTitle: true,
          titleSpacing: 2.0,
        ),
        extendBodyBehindAppBar: true,
        body: Center(
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
    // TextEditingController controller;
    // int phoneNumber;
    return TextField(
      maxLength: 10,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        filled: true,
        prefixIcon: Icon(
          Icons.phone_iphone,
          color: AppColors.onboardingColor,
        ),
        hintStyle: TextStyle(
          color: AppColors.textColor
        ),
        hintText: TextConstants.enterPhone,
        fillColor: AppColors.homeBackground,
      ),
      onChanged: (value) {},
    );
  }

  Widget _createVerifyTextButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(TextConstants.verify),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5.0,
            backgroundColor: AppColors.onboardingColor),
      ),
    );
  }

  // Future _createOTPBox(BuildContext context) {
  //   return showDialog(
  //     barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(TextConstants.otp),
  //           content: Padding(padding: const EdgeInsets.all(9),
  //           child: TextFormField(
  //             decoration: InputDecoration(
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(20))
  //               )
  //             ),
  //             onChanged: (value) {},
  //           ),),
  //           contentPadding: EdgeInsets.all(10),
  //           actions: <Widget>[
  //             ElevatedButton(
  //             onPressed: () {}, 
  //             child: Text('Send'),
  //             )
  //           ],
  //         );
  //       });
  // }
}
