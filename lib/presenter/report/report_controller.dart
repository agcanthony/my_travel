import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../infra/models/tasks_model.dart';
import '../../infra/models/travels_model.dart';
import '../auth/auth_controller.dart';

class ReportController extends GetxController {
  var isLoading = false;
  final db = FirebaseFirestore.instance;
  List<TasksModel> tasksList = [];
  List<TasksModel> doneTasksList = [];
  List<TravelsModel> travelsList = [];

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  Future<void> getData() async {
    try {
      isLoading = true;
      String userId = AuthController.to.firebaseAuth.currentUser?.uid ?? '';
      QuerySnapshot _taskSnap = await db
          .collection('travels')
          .where('userId', isEqualTo: userId)
          .orderBy('travel')
          .get();

      travelsList.clear();

      for (var item in _taskSnap.docs) {
        TravelsModel travelsModel = TravelsModel(
          item.id,
          item['travel'],
          item['color'],
          (item['startAt'] as Timestamp).toDate(),
          (item['endAt'] as Timestamp).toDate(),
        );
        QuerySnapshot taskSnapshot =
            await db.collection('travels/${item.id}/tasks').get();

        travelsModel.numberOfTasks = taskSnapshot.docs.length;
        travelsModel.completedTasks = 0;

        for (var taskItem in taskSnapshot.docs) {
          bool isTaskDone = taskItem['isDone'];

          if (isTaskDone) {
            travelsModel.completedTasks += 1;
          }
        }

        travelsList.add(travelsModel);
      }
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  int getTotalTask() {
    int res = 0;
    for (int i = 0; i < travelsList.length; i++) {
      res += travelsList[i].numberOfTasks;
    }
    return res;
  }

  int getTotalDoneTask() {
    int res = 0;
    for (int i = 0; i < travelsList.length; i++) {
      res += travelsList[i].completedTasks;
    }
    return res;
  }
}
