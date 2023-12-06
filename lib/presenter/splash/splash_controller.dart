import 'package:get/get.dart';

import '../auth/login_page.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  loading() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(LoginPage.routeName);
    //AuthController.to.initialize();
  }

  @override
  void onReady() {
    loading();
    super.onReady();
  }
}
