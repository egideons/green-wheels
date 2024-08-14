import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/email_otp_controller.dart';
import '../../../../theme/colors.dart';

emailOTPResendCode(ColorScheme colorScheme, EmailOTPController otpController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Didn't receive code?",
        style: defaultTextStyle(
          fontSize: 15.0,
          color: colorScheme.inversePrimary,
        ),
      ),
      kHalfWidthSizedBox,
      Obx(
        () => InkWell(
          onTap: otpController.timerComplete.isTrue
              ? otpController.requestOTP
              : null,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            style: defaultTextStyle(
              fontSize: 15.0,
              color: otpController.timerComplete.isTrue
                  ? colorScheme.primary
                  : kErrorColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            child: const Text("Resend code"),
          ),
        ),
      ),
      kHalfWidthSizedBox,
    ],
  );
}
