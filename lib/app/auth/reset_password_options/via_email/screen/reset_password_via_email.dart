import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/auth/reset_password_via_email_controller.dart';
import '../platform/android/reset_password_via_email_scaffold.dart';

class ResetPasswordViaEmail extends StatelessWidget {
  const ResetPasswordViaEmail({super.key});
  @override
  Widget build(BuildContext context) {
    //Initialize signup controller
    Get.put(ResetPasswordViaEmailController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const ResetPasswordViaEmailCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const ResetPasswordViaEmailScaffold(),
    );
  }
}
