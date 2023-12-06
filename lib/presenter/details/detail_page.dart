import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'details_controller.dart';
import 'widgets/doing_list.dart';
import 'widgets/tasks_form.dart';
import 'widgets/todo_steper.dart';

class DetailPage extends GetView<DetailsController> {
  final String taskName;
  final String id;
  DetailPage({Key? key, required this.taskName, required this.id})
      : super(key: key);
  static const routeName = '/detail-pages';

  final String taskId = Get.arguments['id'] ?? '';

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments ?? {};
    final String taskName = arguments['taskName'] ?? '';

    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GetBuilder<DetailsController>(
            builder: (control) {
              return IconButton(
                onPressed: () {
                  control.backButton(taskId);
                },
                icon: const Icon(Icons.chevron_left),
              );
            },
          ),
          title: Text(taskName),
        ),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                GetBuilder<DetailsController>(
                  builder: (control) {
                    var totalTodos =
                        control.tasksList.length + control.doneTasksList.length;
                    return TodoSteper(
                      title: '$totalTodos Entradas',
                      totalSteps: totalTodos > 0 ? totalTodos : 1,
                      currentStep: control.completedTasksCount,
                    );
                  },
                ),
                const SizedBox(height: 10),
                TasksForm(),
                const SizedBox(height: 10),
                Expanded(
                  child: DoingList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
