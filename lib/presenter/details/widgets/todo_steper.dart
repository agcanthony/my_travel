import 'package:flutter/material.dart';
import 'package:my_travels/core/app_colors.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/primary_text.dart';

class TodoSteper extends StatelessWidget {
  final String title;
  final int totalSteps;
  final int currentStep;

  const TodoSteper({
    Key? key,
    required this.title,
    required this.totalSteps,
    required this.currentStep,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          PrimaryText(
            title,
            color: changeTheme ? lilyWhite : black,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StepProgressIndicator(
              totalSteps: totalSteps,
              currentStep: currentStep,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  grenn,
                  grenn.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
