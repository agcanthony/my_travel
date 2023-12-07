// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travels/presenter/home/home_controller.dart';

import '../../infra/models/tasks_model.dart';
import '../auth/auth_controller.dart';

class DetailsController extends GetxController {
  static DetailsController get to => Get.find();
  final String taskId = Get.arguments['id'] ?? '';
  var isLoading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  List<TasksModel> tasksList = [];
  List<TasksModel> doneTasksList = [];
  List<String> imagesList = [];
  RxInt resultFromDetailsPage = RxInt(0);
  final db = FirebaseFirestore.instance;

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTasksData(taskId);
    });
    super.onReady();
  }

  @override
  void onClose() {
    taskController.dispose();
    super.onClose();
  }

  Future<void> addTasksInTravel(TasksModel tasksModel) async {
    try {
      String userId = AuthController.to.firebaseAuth.currentUser!.uid;

      Map<String, dynamic> taskData = {
        'userId': userId,
        'task': tasksModel.task,
        'isDone': tasksModel.isDone,
        if (tasksModel.description != null &&
            tasksModel.description!.isNotEmpty)
          'description': tasksModel.description,
        // if (tasksModel.dateTime != null) 'dateTime': tasksModel.dateTime,
        if (tasksModel.dateTime != null)
          'dateTime': Timestamp.fromDate(tasksModel.dateTime!),
      };

      // Remove campos vazios ou nulos do mapa
      taskData.removeWhere((key, value) => value == null || value == '');

      await db
          .collection(
              'travels/${tasksModel.id != '' ? tasksModel.id : null}/tasks')
          .doc(tasksModel.task)
          .set(taskData)
          .then((value) async {
        if (kDebugMode) {
          print('task ${tasksModel.task}');
        }
        await getTasksData(tasksModel.id);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTasksData(String id) async {
    try {
      String userId = AuthController.to.firebaseAuth.currentUser!.uid;
      QuerySnapshot taskSnap = await db
          .collection('travels/${id != '' ? id : null}/tasks')
          .where('userId', isEqualTo: userId)
          .orderBy('task')
          .get();

      tasksList.clear();

      for (var item in taskSnap.docs) {
        tasksList.add(
          TasksModel(
            id,
            item['isDone'],
            item['task'],
            description: 'description',
          ),
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> saveTask() async {
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text;
      String descriptionText = descriptionController.text;
      String dateText = dateController.text;
      String timeText = timeController.text;

      DateTime? dateTime;

      if (dateText.isNotEmpty && timeText.isNotEmpty) {
        dateTime = DateFormat('dd/MM/yyyy HH:mm').parse('$dateText $timeText');
      } else if (dateText.isNotEmpty) {
        dateTime = DateFormat('dd/MM/yyyy HH:mm').parse('$dateText $timeText');
      }

      TasksModel tasksModel = TasksModel(
        taskId,
        false,
        taskText,
        description: descriptionText.isNotEmpty ? descriptionText : null,
        dateTime: dateTime,
      );

      await addTasksInTravel(tasksModel);

      update();

      taskController.clear();
      descriptionController.clear();
      dateController.clear();
      timeController.clear();
    }
  }

  Future<void> checkButton(String id) async {
    if (formKey.currentState!.validate()) {
      String taskText = taskController.text;
      print('Travel ID: $id');

      if (taskText.isNotEmpty) {
        TasksModel tasksModel = TasksModel(
          id,
          false,
          taskText,
        );

        addTasksInTravel(tasksModel);
        tasksList.add(tasksModel);
        taskController.clear();
      }
    }
  }

  Future<void> taskDone(TasksModel taskModel) async {
    try {
      await db
          .collection(
              'travels/${taskModel.id != '' ? taskModel.id : null}/tasks')
          .doc(taskModel.task)
          .update({'isDone': !taskModel.isDone}).then((value) async {
        print('Task ${taskModel.task} marked as done: ${!taskModel.isDone}');
        await getTasksData(taskModel.id);
        update();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  int get completedTasksCount {
    return tasksList.where((task) => task.isDone).length;
  }

  void backButton(String id) {
    checkButton(id);
    update();
    HomeController.to.getData();
    Get.back();
  }

  void moveTaskToDoneList(TasksModel taskModel) {
    tasksList.remove(taskModel);

    taskModel.isDone = true;
    doneTasksList.add(taskModel);

    update();
  }

  void moveTaskToDoingList(TasksModel taskModel) {
    doneTasksList.remove(taskModel);

    taskModel.isDone = false;

    tasksList.add(taskModel);

    update();
  }

  Future<void> deleteTask(TasksModel task) async {
    bool confirmDelete = await Get.defaultDialog(
      title: 'Confirmar Exclusão',
      middleText: 'Você tem certeza que quer deletar essa tarefa?',
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: true);
            EasyLoading.showToast('Tarefa deletada com sucesso!');
          },
          child: const Text('Sim'),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text('Não'),
        ),
      ],
    );
    if (confirmDelete == true) {
      try {
        await db
            .collection('travels/${task.id != '' ? task.id : null}/tasks')
            .doc(task.task)
            .delete();

        doneTasksList.remove(task);
        await getTasksData(task.id);
        update();
      } catch (e) {
        print('Error deleting task: $e');
      }
    }
  }

  RxBool isExpanded = true.obs;

  void collapseExpansionTile() {
    isExpanded.value = false;
  }
}
