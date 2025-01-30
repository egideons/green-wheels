import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/phone_otp_controller.dart';
import '../platform/android/email_otp_scaffold.dart';

class EmailOTP extends StatelessWidget {
  final String? userEmail;
  final void Function()? loadData;

  const EmailOTP({super.key, this.userEmail, this.loadData});

  @override
  Widget build(BuildContext context) {
    //Initialize otp controller
    Get.put(PhoneOTPController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const EmailOTPCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: EmailOTPScaffold(
        userEmail: userEmail,
        loadData: loadData,
      ),
    );
  }
}
