// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/core/const/heights.dart';
import 'package:ambulance_app_ui/screens/map_screen/page/homescreen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';

class MobileAuth extends StatefulWidget {
  const MobileAuth({Key? key}) : super(key: key);

  @override
  _MobileAuthState createState() => _MobileAuthState();
}

class _MobileAuthState extends State<MobileAuth> {
  TextEditingController phoneNumberController = TextEditingController();
  final firebaseAuth = FirebaseAuth.instance;
  String verificationId ='';
  bool otpVisible= false;
  User? user;
  final TextEditingController pinPutController = TextEditingController();
  final formKey = GlobalKey<FormState>();
    final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 4, 7, 10)),
      borderRadius: BorderRadius.circular(20),
    ),
  );


  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    pinPutController.dispose();
  }

 void loginWithPhone() async {
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebaseAuth.signInWithCredential(credential).then((value) {
          print('Log in successful');
        });
      }, 
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      }, 
      codeSent: (String verificationId, int? resendToken) {
        otpVisible  =true;
        this.verificationId = verificationId;
        setState(() {});
      }, 
      codeAutoRetrievalTimeout: (String verificationId) {},
      );
  }

void verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, 
      smsCode: pinPutController.text,
      );
      await firebaseAuth.signInWithCredential(credential).then((value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      }).whenComplete(() {
        if(user != null) {
          Fluttertoast.showToast(
            msg: 'You are logged in successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16
          );
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
        } else {
          Fluttertoast.showToast(
            msg: 'Your login failed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 16
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      body: SingleChildScrollView(
        child: FadeInDown(
          duration: const Duration(
            milliseconds: 2000,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const YMargin(100),
                // authHeader(context),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let’s know you",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primarydark,
                        fontSize: 23,
                      ),
                    ),
                    YMargin(10),
                    Text("Please enter your Mobile Number",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: AppColors.primarydark,
                          fontSize: 14,
                        )),
                    YMargin(3.0),
                    Text("An OTP will be sent you for verification?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primarydark,
                          fontSize: 9.0,
                        )),
                  ],
                ),
                const YMargin(25),
                TextFormField(
                  key: formKey,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    filled: false,
                    hintText: 'Start with +254',
                    prefixIcon: Icon(Icons.phone_iphone)),
                maxLength: 13,
                keyboardType: TextInputType.phone,
                controller: phoneNumberController,
              ),              
                const YMargin(30),
                 Padding(
              padding: const EdgeInsets.all(30),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: pinPutController,
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration?.copyWith(
                    color: const Color.fromARGB(255, 222, 228, 233),
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
              ),
            ),
            const YMargin(30),
                ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondarygrey,
    minimumSize: const Size(250, 50)
  ),                   
  onPressed: () {
    final phoneNumber = phoneNumberController.text;

    // Validate the phone number
    // if (validatePhoneNumber(phoneNumber)) {
      if (otpVisible) {
        verifyOtp();
      } else {
        loginWithPhone();
      }
    // }
  },
  child: Text(
    otpVisible ? 'Verify' : 'Login',
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: AppColors.primarywhite,
      fontWeight: FontWeight.w500,
    ),
  ),
), 
  
              ],
            ),
          ),
        ),
      ),
    );
  }
bool validatePhoneNumber(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return const AlertDialog(
          title: Text(
            'Enter a valid phone number'
          ),
        );
      });    
  }
  final cleanedValue = phoneNumber.replaceAll(RegExp(r'\D'), '');

  if (cleanedValue.startsWith('0')) {
    final formattedValue = '+254${cleanedValue.substring(1)}';
    phoneNumberController.text = formattedValue;
    return true;
  }
  return false;
}
}