import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/email_signup_controller.dart';
import '../platform/android/email_signup_scaffold.dart';

class EmailSignupScreen extends StatelessWidget {
  const EmailSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(EmailSignupController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const EmailSignupScaffold(),
    );
  }
}
