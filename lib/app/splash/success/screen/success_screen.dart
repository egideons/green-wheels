import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/success_screen_controller.dart';
import '../platform/android/success_scaffold.dart';

class SuccessScreen extends StatelessWidget {
  final Function()? loadScreen;
  final String? subtitle;
  const SuccessScreen({super.key, this.loadScreen, this.subtitle});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(SuccessScreenController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: SuccessScreenScaffold(loadScreen: loadScreen, subtitle: subtitle),
    );
  }
}
