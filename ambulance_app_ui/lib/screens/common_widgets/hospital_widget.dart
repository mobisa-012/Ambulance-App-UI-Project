import 'package:flutter/material.dart';

class HospitalWidget extends StatelessWidget {
  final Function()?onTap;
  final bool withInfo;
  final Widget child;

  const HospitalWidget(
      {super.key,     
      this.withInfo=true,
      required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 4.0,
              spreadRadius: 1.0
            )
          ]
        ), 
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: child,),
                  if(withInfo)
                  const Icon(Icons.info_outline_rounded,
                  color: Colors.deepPurpleAccent,
                  size: 25,)
                ],
              ),
            ),
          ),
        ),       
      ),
    );
  }
}
