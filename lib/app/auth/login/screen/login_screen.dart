import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/auth/login_controller.dart';

import '../platform/android/login_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(LoginController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const LoginScaffold(),
    );
  }
}
