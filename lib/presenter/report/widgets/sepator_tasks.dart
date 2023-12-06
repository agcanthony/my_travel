import 'package:flutter/material.dart';
import 'package:my_travels/core/responsive.dart';

import '../../../core/app_colors.dart';

class SepatorTasks extends StatelessWidget {
  const SepatorTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0.wp),
      child: const SizedBox(
        height: 10,
        width: 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: redDark,
          ),
        ),
      ),
    );
  }
}
