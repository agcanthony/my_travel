import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travels/core/responsive.dart';

import '../../core/app_colors.dart';
import '../../core/primary_text.dart';
import 'report_controller.dart';
import 'widgets/build_status.dart';
import 'widgets/progress_task.dart';
import 'widgets/sepator_tasks.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  static const routeName = '/report-pages';

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ReportController>(
          builder: (control) {
            var createdTasks = control.getTotalTask();
            var completedTasks = control.getTotalDoneTask();
            var liveTasks = createdTasks - completedTasks;
            var percentageTasks =
                (createdTasks == 0 ? 0 : completedTasks / createdTasks * 100)
                    .toStringAsFixed(0);

            return Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryText(
                          'Status Tarefas',
                          size: 22.0.tx,
                          color: changeTheme ? lilyWhite : black,
                        ),
                        GetBuilder<ReportController>(
                          builder: (control) {
                            return IconButton(
                              onPressed: () {
                                control.getData();
                              },
                              icon: const Icon(Icons.autorenew),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.0.hp),
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: PrimaryText(
                      DateFormat.yMMMd().format(DateTime.now()),
                      size: 15.0.tx,
                      color: changeTheme ? lilyWhite : black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                    child: Divider(
                      thickness: 2,
                      color: changeTheme ? lilyWhite : black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BuildStatus(
                          color: orangeDark,
                          number: liveTasks,
                          title: 'Abertas',
                        ),
                      ),
                      const SepatorTasks(),
                      Flexible(
                        child: BuildStatus(
                          color: grenn,
                          number: completedTasks,
                          title: 'Completas',
                        ),
                      ),
                      const SepatorTasks(),
                      Expanded(
                        child: BuildStatus(
                          color: primaryLight,
                          number: createdTasks,
                          title: 'Criadas ',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0.hp),
                  ProgressTask(
                    totalSteps: createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    title: '${createdTasks == 0 ? 0 : percentageTasks}%',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
