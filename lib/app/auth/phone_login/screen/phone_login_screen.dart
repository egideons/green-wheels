import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/phone_login_controller.dart';
import '../platform/android/phone_login_scaffold.dart';

class PhoneLoginScreen extends StatelessWidget {
  const PhoneLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(PhoneLoginController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const PhoneLoginScaffold(),
    );
  }
}
