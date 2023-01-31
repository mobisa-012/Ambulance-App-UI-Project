import 'package:flutter/material.dart';

class OnboardingTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title, imagePath, mainText;

  const OnboardingTile({Key? key, this.title, this.imagePath, this.mainText}) :super(key:key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 34,),
          Expanded(child: Image.asset(imagePath)),
          const SizedBox(height: 65,),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24
            ),
          ),
          const SizedBox(height: 15,),
          Padding(padding: EdgeInsets.symmetric(horizontal: screenWidth/100),
          child: Text(
            mainText,
            style: const TextStyle(
              fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),)
          ],
      ),
    );
  }
}
