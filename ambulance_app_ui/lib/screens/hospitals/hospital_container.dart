// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalContainer extends StatelessWidget {
  final String name;
  final String link;

  Future openBroserUrl({required String url, bool inApp = false}) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri
      );
    }
  }

  const HospitalContainer({super.key, required this.name, required this.link});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String url = link;
        openBroserUrl(url: url, inApp: true);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Color.fromARGB(200, 115, 64, 255),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const Icon(
              Icons.info,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
