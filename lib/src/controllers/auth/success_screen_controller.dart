import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/auth/login/screen/login_screen.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

  gotToLoginScreen() {
    Get.offAll(
      () => const LoginScreen(),
      routeName: "/login",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }
}
