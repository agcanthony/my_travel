import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travels/presenter/auth/login_page.dart';

import '../presenter/auth/auth_bindings.dart';
import '../presenter/auth/signup_page.dart';
import '../presenter/home/home_bindings.dart';
import '../presenter/home/home_page.dart';
import '../presenter/splash/splash_bindings.dart';
import '../presenter/splash/splash_page.dart';

class AppPages {
  const AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: HomeBindings(),
      curve: Curves.bounceIn,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: SplashPage.routeName,
      page: () => const SplashPage(),
      binding: SplashBindings(),
      curve: Curves.bounceIn,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: LoginPage.routeName,
      page: () => const LoginPage(),
      binding: AuthBindings(),
      curve: Curves.bounceIn,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: SignupPage.routeName,
      page: () => const SignupPage(),
      binding: AuthBindings(),
      curve: Curves.bounceIn,
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
    ),
  ];
}
