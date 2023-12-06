import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_travels/core/app_colors.dart';

class CustomRichText extends StatelessWidget {
  final String discription;
  final String text;
  final Function() onTap;
  const CustomRichText(
      {Key? key,
      required this.discription,
      required this.text,
      required this.onTap})
      : super(key: key);
// "Don't already Have an account? "
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: discription,
        style: const TextStyle(color: lilyWhite, fontSize: 16),
        children: [
          TextSpan(
              text: text,
              style: const TextStyle(
                color: defaultIconColor,
                fontSize: 16,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
