import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travels/presenter/details/details_controller.dart';
import 'package:my_travels/presenter/task_detail/task_detail_page.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_colors.dart';
import '../../../core/primary_text.dart';
import '../../../infra/models/tasks_model.dart';

class DoingList extends StatelessWidget {
  DoingList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return GetBuilder<DetailsController>(
      builder: (control) {
        final tasksList = control.tasksList;
        if (tasksList.isEmpty) {
          return Lottie.asset(done);
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            TasksModel taskModel = tasksList[index];
            return ListTile(
              onTap: () async {
                await Get.to(() => TaskDetail(), arguments: {
                  'id': taskModel.id,
                  'taskName': taskModel.task,
                  'travelId': control.taskId
                });
                print(taskModel.id);
              },
              onLongPress: () async {
                control.deleteTask(taskModel);
              },
              leading: SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  fillColor: taskModel.isDone
                      ? MaterialStateProperty.resolveWith(
                          (states) => changeTheme ? grenn : green)
                      : MaterialStateProperty.resolveWith((states) => grey),
                  value: taskModel.isDone,
                  onChanged: (value) {
                    control.taskDone(taskModel);
                  },
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PrimaryText(
                  taskModel.task,
                  color: changeTheme ? lilyWhite : black,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  await Get.to(() => TaskDetail(), arguments: {
                    'id': taskModel.id,
                    'taskName': taskModel.task,
                    'travelId': control.taskId
                  });
                  print(taskModel.id);
                },
                icon: Icon(Icons.chevron_right_rounded),
              ),
            );
          },
        );
      },
    );
  }
}
