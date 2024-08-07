import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/auth_controller.dart';
import '../platform/android/splash_screen_scaffold.dart';

class StartupSplashScreen extends StatelessWidget {
  const StartupSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(AuthController());

    if (Platform.isIOS) {
      return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          // return const SplashCupertinoScaffold();
          return Container();
        },
      );
    }
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return const StartupSplashAndroidScaffold();
      },
    );
  }
}
