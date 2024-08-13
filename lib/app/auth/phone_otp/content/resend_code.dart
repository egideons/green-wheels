import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/email_otp_controller.dart';
import '../../../../theme/colors.dart';

resendCode(ColorScheme colorScheme, EmailOTPController otpController) {
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
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            child: const Text("Resend code"),
          ),
        ),
      ),
      kHalfWidthSizedBox,
      // Obx(
      //   () => otpController.timerComplete.isTrue
      //       ? const SizedBox()
      //       : Text(
      //           "in ${otpController.formatTime(otpController.secondsRemaining.value)}s",
      //           textAlign: TextAlign.center,
      //           style: defaultTextStyle(
      //             fontSize: 15.0,
      //             color: colorScheme.primary,
      //             fontWeight: FontWeight.w400,
      //           ),
      //         ),
      // ),
    ],
  );
}
