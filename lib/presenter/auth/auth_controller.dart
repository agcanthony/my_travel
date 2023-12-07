import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_travels/core/app_colors.dart';
import 'package:my_travels/presenter/auth/login_page.dart';
import 'package:my_travels/presenter/auth/signup_page.dart';
import 'package:my_travels/presenter/home/home_page.dart';

import '../home/home_controller.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  late Rx<User?> firebaseUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final nameControlller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get userName => nameControlller.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  set password(String value) => passwordController.text = value;

  @override
  void onReady() {
    initialize();
    super.onReady();
  }

  void initialize() async {
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  void navigateSignup() async {
    if (firebaseAuth.currentUser == null) {
      Get.to(() => const SignupPage());
    }
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  void register(String email, password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => const HomePage());
      Get.snackbar(
        'Sucesso',
        'Bem Vindo',
        backgroundColor: grenn,
        colorText: lilyWhite,
      );
    } catch (firebaseAuthException) {
      Get.snackbar(
        'Erro',
        'Erro ao criar usuario',
        backgroundColor: red,
        colorText: lilyWhite,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => const HomePage());

      await HomeController.to.getData();
      Get.snackbar(
        'Sucesso',
        'Bem Vindo de Volta',
        backgroundColor: grenn,
        colorText: darkTheme,
      );
    } catch (firebaseAuthException) {
      Get.snackbar(
        'Erro',
        'Você não possui cadastro',
        backgroundColor: buttonTheme,
        colorText: lilyWhite,
      );
    }
  }

  void logout() async {
    await firebaseAuth.signOut();
    HomeController.to.travelsList.clear();
    update();
    Get.snackbar(
      'Bye',
      'Até a próxima',
      backgroundColor: orangeDark,
      colorText: darkTheme,
    );
  }

  Future<bool> authenticateWithPassword() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error authenticating with password: $e');
      }
      return false;
    }
  }
}
