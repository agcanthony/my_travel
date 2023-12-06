import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'core/app_constants.dart';
import 'core/app_theme.dart';
import 'core/theme_controller.dart';
import 'presenter/home/home_bindings.dart';
import 'presenter/splash/splash_page.dart';
import 'routes/app_pages.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: HomeBindings(),
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeController().theme,
      title: appName,
      initialRoute: SplashPage.routeName,
      builder: EasyLoading.init(),
    );
  }
}
