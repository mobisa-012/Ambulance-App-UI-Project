import 'package:ambulance_app_ui/screens/bottom_tab_bar/tab_bar.dart';
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
        elevation: 0,
        title: Text('Verify'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createTextField(context),
          const SizedBox(
            height: 10,
          ),
          createButton(context),
        ],
      ),
    );
  }

  Widget _createTextField(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,

    );
  }

  Widget createButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
        onPressed: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => TabBarPage()));
        },
        child: Text('Order'));
  }
}
