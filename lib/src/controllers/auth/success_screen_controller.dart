import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/auth/signup/screen/signup_screen.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

  gotToSignupScreen() {
    Get.offAll(
      () => const SignupScreen(),
      routeName: "/signup",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }
}
