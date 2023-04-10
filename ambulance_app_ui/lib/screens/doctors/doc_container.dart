import 'package:flutter/material.dart';

class DoctorContainer extends StatelessWidget {
  final String name;
  final String title;
  final Widget child;
  const DoctorContainer(
      {super.key,
      required this.name,
      required this.title,
      required this.child,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
        
        ),
      ),
    );
  }
}
