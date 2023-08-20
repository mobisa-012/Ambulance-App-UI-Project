import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}
