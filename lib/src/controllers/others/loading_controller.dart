import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../app/auth/email_login/screen/email_login_screen.dart';
import '../../../app/home/screen/home_screen.dart';

class LoadingController extends GetxController {
  static LoadingController get instance {
    return Get.find<LoadingController>();
  }

//============= Variables =============\\
  var isLoading = false.obs;

//============= Load BottomNavView =============\\
  loadHomeScreen() async {
    isLoading.value = true;
    update();

    await Future.delayed(const Duration(seconds: 3));

    await Get.offAll(
      () => const HomeScreen(),
      routeName: "/home",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );

    isLoading.value = true;
    update();
  }

//============= Logout =============\\
  logout() async {
    isLoading.value = true;
    update();

    await Future.delayed(const Duration(seconds: 2));

    await Get.offAll(
      () => const EmailLoginScreen(),
      routeName: "/email-login",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );

    isLoading.value = true;
    update();
  }

//============= Load  =============\\
}
