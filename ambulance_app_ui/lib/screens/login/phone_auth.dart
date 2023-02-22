import 'package:ambulance_app_ui/core/const/path_constants.dart';
import 'package:ambulance_app_ui/screens/login/otp.dart';
import 'package:flutter/material.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(margin: const EdgeInsets.only(top: 80),
              child: Image.asset(PathConstants.onboarding)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Hosy',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                    hintText: 'Enter phone number...',
                    prefix: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text('+254'),
                    )),
                maxLength: 10,
                keyboardType: TextInputType.phone,
                controller: textEditingController,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              height: 55,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: const Text(
                  'login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          OTPScreen(textEditingController.text)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
