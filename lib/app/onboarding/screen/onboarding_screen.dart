import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/others/onboarding_controller.dart';
import '../platform/android/onboarding_scaffold.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(OnboardingController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return const OnboardingScaffold();
  }
}
