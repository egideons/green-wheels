import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/controllers/auth/phone_otp_controller.dart';
import '../platform/android/phone_otp_scaffold.dart';

class PhoneOTP extends StatelessWidget {
  final String? userPhoneNumber;
  final void Function()? loadData;

  const PhoneOTP({super.key, this.userPhoneNumber, this.loadData});

  @override
  Widget build(BuildContext context) {
    //Initialize otp controller
    Get.put(PhoneOTPController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const EmailOTPCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: PhoneOTPScaffold(
        userPhoneNumber: userPhoneNumber,
        loadData: loadData,
      ),
    );
  }
}
