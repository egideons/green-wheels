import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/signup/screen/signup_screen.dart';

import '../../../app/home/screen/home_screen.dart';
import '../../../app/onboarding/screen/onboarding_screen.dart';
import '../../../main.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  var isLoading = false.obs;

  var responseStatus = 0.obs;

  var responseMessage = "".obs;
  Future<void> loadApp() async {
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      // User is logged in, navigate to the home screen

      await Get.offAll(
        () => const HomeScreen(),
        routeName: "/home",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    } else if (isOnboarded) {
      // User is onboarded but not logged in, navigate to the sign up screen
      await Get.offAll(
        () => const SignupScreen(),
        routeName: "/signup",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    } else {
      // User is not onboarded, navigate to the onboarding screen
      await Get.offAll(
        () => const OnboardingScreen(),
        routeName: "/onboarding",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    }
  }

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () {
      loadApp();
    });
    super.onInit();
  }
}
