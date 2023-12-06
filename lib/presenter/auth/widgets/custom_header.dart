import 'package:flutter/material.dart';
import 'package:my_travels/core/app_colors.dart';
import 'package:my_travels/core/primary_text.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const CustomHeader({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: changeTheme ? lilyWhite : black,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          PrimaryText(
            text,
            color: changeTheme ? lilyWhite : black,
          )
        ],
      ),
    );
  }
}
