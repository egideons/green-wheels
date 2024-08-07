import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/auth/reset_password_via_email_otp_controller.dart';
import '../platform/android/reset_password_via_email_otp_scaffold.dart';

class RestPasswordViaEmailOTP extends StatelessWidget {
  const RestPasswordViaEmailOTP({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize signup controller
    Get.put(ResetPasswordViaEmailOTPController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const ResetPasswordViaEmailOTPCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const ResetPasswordViaEmailOTPScaffold(),
    );
  }
}
