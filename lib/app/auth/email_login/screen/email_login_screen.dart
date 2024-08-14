import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/email_login_controller.dart';
import '../platform/android/email_login_scaffold.dart';

class EmailLoginScreen extends StatelessWidget {
  const EmailLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(EmailLoginController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const EmailLoginScaffold(),
    );
  }
}
