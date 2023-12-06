import 'package:flutter/material.dart';
import 'package:my_travels/core/responsive.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/app_colors.dart';
import '../../../core/primary_text.dart';

class ProgressTask extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final String title;

  const ProgressTask({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return UnconstrainedBox(
      child: SizedBox(
        width: 70.0.wp,
        height: 70.0.wp,
        child: CircularStepProgressIndicator(
          totalSteps: totalSteps,
          currentStep: currentStep,
          stepSize: 20,
          selectedColor: grenn,
          unselectedColor: grey,
          width: 150,
          height: 150,
          selectedStepSize: 22,
          roundedCap: (_, __) => true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryText(
                title,
                size: 25.0.tx,
                fontWeight: FontWeight.w500,
                color: changeTheme ? lilyWhite : black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
