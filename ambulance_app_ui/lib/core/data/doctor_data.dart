import 'package:flutter/material.dart';

class DoctorData {
  final String name;
  final String image;
  final String specialty;
  final Widget call;
  final int years;

  DoctorData(
      {required this.call,
      required this.image,
      required this.name,
      required this.specialty,
      required this.years});
  @override
  String toString() {
    return 'DoctorData(call: $call, image: $image, name: $name,specialty: $specialty, years: $years)';
  }
}
