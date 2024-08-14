import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/provide_phone_controller.dart';
import '../platform/android/provide_phone_scaffold.dart';

class ProvidePhone extends StatelessWidget {
  const ProvidePhone({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(ProvidePhoneController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const ProvidePhoneScaffold(),
    );
  }
}
