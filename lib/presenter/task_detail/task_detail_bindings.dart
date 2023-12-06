import 'package:get/get.dart';

import '../details/details_controller.dart';
import './task_detail_controller.dart';

class TaskDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TaskDetailController());
    Get.lazyPut(() => DetailsController(), fenix: true);
  }
}
