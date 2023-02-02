import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
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
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: AppColors.textColor
          )
        ),
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: AppColors.homeBackground),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: OnboardingPage(),
    );
  }
}
