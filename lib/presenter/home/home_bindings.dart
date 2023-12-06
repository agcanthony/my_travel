import 'package:get/get.dart';

import '../auth/auth_controller.dart';
import '../details/details_controller.dart';
import '../report/report_controller.dart';
import '../task_detail/task_detail_controller.dart';
import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => DetailsController(), fenix: true);
    Get.lazyPut(() => ReportController(), fenix: true);
    Get.lazyPut(() => TaskDetailController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
