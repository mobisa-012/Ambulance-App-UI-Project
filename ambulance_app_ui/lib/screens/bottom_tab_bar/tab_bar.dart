import 'package:ambulance_app_ui/screens/doctors/page/doctors.dart';
import 'package:ambulance_app_ui/screens/hospitals/hospitals_page.dart';
import 'package:ambulance_app_ui/screens/map_screen/map_screen.dart';
import 'package:flutter/material.dart';

import '../profile/profile_screen.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> pages = [
    MapScreen(),
    DoctorsScreen(),
    HospitalPage(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,        
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), 
          label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), 
              label: 'Doctor'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital),
          label: 'Hospital'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_sharp),
          label: 'Me')
        ],
        onTap: onTap,
      ),
      body: pages[currentIndex],
    );
  }
}
