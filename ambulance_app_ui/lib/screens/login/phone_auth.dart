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
      appBar: AppBar(
        title: const Text('Phone authentication'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
                'https://guideposts.org/wp-content/uploads/2022/12/prayer_devotion_marquee-768x432.jpg.optimal.jpg'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'The Co-operative University of Kenya',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(
                decoration: const InputDecoration(
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.all(12),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
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
