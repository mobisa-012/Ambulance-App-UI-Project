import 'package:ambulance_app_ui/core/colors.dart';
import 'package:ambulance_app_ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(     
        fontFamily: 'Roboto', 
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue).copyWith(background: AppColors.homeBackground),
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home:  OnboardingPage(),
    );
  }
}