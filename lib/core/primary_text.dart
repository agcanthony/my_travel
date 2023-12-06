import 'package:flutter/material.dart';

import 'app_colors.dart';

class PrimaryText extends StatelessWidget {
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final double height;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const PrimaryText(
    this.text, {
    Key? key,
    this.fontWeight = FontWeight.w400,
    this.color = lilyWhite,
    this.size = 20,
    this.height = 1.3,
    this.textAlign,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: color,
        height: height,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
