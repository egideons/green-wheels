import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/email_otp_controller.dart';
import '../platform/android/email_otp_scaffold.dart';

class EmailOTP extends StatelessWidget {
  const EmailOTP({super.key, this.userEmail});

  final String? userEmail;

  @override
  Widget build(BuildContext context) {
    //Initialize otp controller
    Get.put(EmailOTPController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const EmailOTPCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: EmailOTPScaffold(
        userEmail: userEmail,
      ),
    );
  }
}
