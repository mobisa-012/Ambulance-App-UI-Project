import 'package:ambulance_app_ui/core/const/colors.dart';
import 'package:ambulance_app_ui/screens/onboarding/onboarding_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hosy',
      theme: ThemeData(
          textTheme:
              const TextTheme(bodyLarge: TextStyle(color: AppColors.textColor)),
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: AppColors.homeBackground),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: OnboardingPage(),
    );
  }
}
