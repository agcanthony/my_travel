import 'package:get/get.dart';

import '../home/home_controller.dart';
import 'report_controller.dart';

class ReportBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.put(ReportController());
  }
}
