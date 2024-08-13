import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/auth/signup/screen/signup_screen.dart';
import '../../../app/onboarding/content/onboard_content.dart';
import '../../../main.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance {
    return Get.find<OnboardingController>();
  }

  var scrollController = ScrollController().obs;

  var pageController = PageController().obs;
  var onboardContent = OnboardContent();
  var currentPage = 0.obs;
  var isLastPage = false.obs;

  @override
  void onInit() {
    pageController.value.addListener(pageListener);

    super.onInit();
  }

  pageListener() {
    currentPage.value = pageController.value.page!.round();
  }

  setIsLastPage(index) {
    isLastPage.value = onboardContent.items.length - 1 == index;
  }

  toLogin() async {
    //Save state that the user has been onboarded
    prefs.setBool("isOnboarded", true);

    await Get.offAll(
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
