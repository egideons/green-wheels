import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/auth/phone_signup/screen/phone_signup_screen.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

  gotToPhoneSignupScreen() {
    Get.offAll(
      () => const PhoneSignupScreen(),
      routeName: "/phone-signup",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }

  goToGreenWalletScreen() {
    Get.close(0);
  }
}
