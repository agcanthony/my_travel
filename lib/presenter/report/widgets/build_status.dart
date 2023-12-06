import 'package:flutter/material.dart';
import 'package:my_travels/core/responsive.dart';

import '../../../core/app_colors.dart';
import '../../../core/primary_text.dart';

class BuildStatus extends StatelessWidget {
  final Color color;
  final int number;
  final String title;
  const BuildStatus({
    Key? key,
    required this.color,
    required this.number,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        SizedBox(
          height: 3.0.wp,
          width: 3.0.wp,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 2.0.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryText(
              '$number',
              color: changeTheme ? lilyWhite : black,
            ),
            PrimaryText(
              title,
              size: 12.0.tx,
              color: changeTheme ? lilyWhite : black,
            ),
          ],
        ),
      ],
    );
  }
}
