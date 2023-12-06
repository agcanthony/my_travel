import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_travels/core/responsive.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/primary_text.dart';
import './splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryText(
                'Diário de Viagens',
                size: 25.0.tx,
                fontWeight: FontWeight.w500,
                color: defaultIconColor,
              ),
              SizedBox(
                height: 2.0.hp,
              ),
              Lottie.asset(splash),
            ],
          ),
        ),
      ),
    );
  }
}
