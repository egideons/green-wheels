import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/auth/phone_signup_controller.dart';

import '../platform/android/phone_signup_scaffold.dart';

class PhoneSignupScreen extends StatelessWidget {
  const PhoneSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(PhoneSignupController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const PhoneSignupScaffold(),
    );
  }
}
