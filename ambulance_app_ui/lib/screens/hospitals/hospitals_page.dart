// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:ambulance_app_ui/screens/common_widgets/hospital_widget.dart';
import 'package:ambulance_app_ui/screens/map_screen/page/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  List hInfo = [];
  _initData() async{
    await DefaultAssetBundle.of(context).loadString("json/hosy.json").then((value) {
      hInfo = json.decode(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(200, 115, 64, 255),
        title: Text(
          'Let us find you a hospital',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => MapScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  // should open to allown client book an appointmetn
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 150,
                    width: 180,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(200, 115, 64, 255),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 4.0,
                              spreadRadius: 1.1)
                        ]),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.local_hospital_rounded,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Text(
                          'Book an appointment',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  //should open to allow client book an appointment home
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 145,
                    width: 180,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5.0,
                              spreadRadius: 1.1)
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: const Color.fromARGB(255, 254, 254, 255)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: Colors.deepPurple.withOpacity(0.1),
                          size: 45,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Home Visit',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Call the doc home',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    itemCount: hInfo.length,
                    itemBuilder: (context, a) {
                      return HospitalWidget(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              hInfo[a]['name'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        onTap: () async {
                          String url = hInfo[a]['link'];
                          openBrowserURL(url: url, inApp: true);
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future openBrowserURL({required String url, bool inApp = false}) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true, forceWebView: true, enableJavaScript: true);
    }
  }
}
