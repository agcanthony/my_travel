import 'package:get/get.dart';

import '../home/home_controller.dart';
import '../task_detail/task_detail_controller.dart';
import 'details_controller.dart';

class DetailsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => TaskDetailController(), fenix: true);
  }
}
