// ignore_for_file: avoid_print

import 'package:ambulance_app_ui/screens/bottom_tab_bar/tab_bar.dart';
import 'package:ambulance_app_ui/screens/map_screen/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen(this.phoneNumber, {super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  String? verificationCode;
  final TextEditingController pinPutController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  void initState() {
    verifyPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'OTP Verification',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Center(
              child: Text(
                'Verify +254 - ${widget.phoneNumber}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              controller: pinPutController,
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration?.copyWith(
                  color: const Color.fromRGBO(234, 239, 243, 1),
                ),
              ),
              focusedPinTheme: defaultPinTheme.copyDecorationWith(
                border:
                    Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
                borderRadius: BorderRadius.circular(8),
              ),
              pinAnimationType: PinAnimationType.fade,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsRetrieverApi,
              onCompleted: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: verificationCode!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MapScreen()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TabBarPage()));
            },
            child: Text('Skip',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 25,
              fontStyle: FontStyle.italic
            ),),
          )
        ],
      ),
    );
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: '+254${widget.phoneNumber}',
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) async {
          if (value.user != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
                (route) => false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String? verificationId, int? resendToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
    );
  }
}
