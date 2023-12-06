import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/primary_text.dart';

class CustomSnackbar {
  CustomSnackbar._();

  static const _defaultDuration = Duration(seconds: 5);
  static const _defaultMargin = EdgeInsets.fromLTRB(50, 20, 20, 0);
  static const _defaultBorderRadius = 12.0;
  static const _defaultSnackPosition = SnackPosition.TOP;
  static const _defaultDismissDirection = DismissDirection.horizontal;
  static final _defaultBoxShadows = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];

  static void showSuccess(String message) {
    Get.rawSnackbar(
      message: message,
      messageText: PrimaryText(
        message,
        textAlign: TextAlign.center,
      ),
      maxWidth: double.infinity,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      margin: _defaultMargin,
      borderRadius: _defaultBorderRadius,
      snackPosition: _defaultSnackPosition,
      dismissDirection: _defaultDismissDirection,
      boxShadows: _defaultBoxShadows,
    );
  }

  static void showWarning(String title, String message, {Widget? mainButton}) {
    if (Get.isSnackbarOpen == true) return;
    Get.rawSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      duration: _defaultDuration,
      margin: _defaultMargin,
      borderRadius: _defaultBorderRadius,
      snackPosition: _defaultSnackPosition,
      dismissDirection: _defaultDismissDirection,
      boxShadows: _defaultBoxShadows,
      mainButton: mainButton,
    );
  }

  static void showError(String message, {Widget? mainButton}) {
    Get.rawSnackbar(
      forwardAnimationCurve: Curves.bounceInOut,
      reverseAnimationCurve: Curves.bounceInOut,
      message: message,
      messageText: PrimaryText(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
      mainButton: mainButton,
      duration: _defaultDuration,
      margin: _defaultMargin,
      borderRadius: _defaultBorderRadius,
      snackPosition: _defaultSnackPosition,
      dismissDirection: _defaultDismissDirection,
      boxShadows: _defaultBoxShadows,
    );
  }
}

Color getErrorSeverity(int statusCode) {
  switch (statusCode) {
    case 400:
      return Colors.red;
    case 401:
      return Colors.orange;
    case 403:
      return Colors.red;
    case 404:
      return Colors.orange;
    case 500:
      return Colors.red;
    default:
      return Colors.red;
  }
}
