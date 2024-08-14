import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/provide_name_controller.dart';
import '../platform/android/provide_name_scaffold.dart';

class ProvideNameScreen extends StatelessWidget {
  final bool? isEmailSignup;
  const ProvideNameScreen({super.key, this.isEmailSignup});

  @override
  Widget build(BuildContext context) {
    //Initialize controller
    Get.put(ProvideNameController());

    // if (Platform.isIOS) {
    //   return const OnboardingCupertinoScaffold();
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: ProvideNameScaffold(isEmailSignup: isEmailSignup),
    );
  }
}
