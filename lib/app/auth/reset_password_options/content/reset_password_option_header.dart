import 'package:flutter/material.dart';

import '../../../../src/constants/consts.dart';

resetPasswordOptionHeader(
  ColorScheme colorScheme,
  forgotPasswordViaController, {
  registeredOption,
  resetOption,
  resetVia,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Forgot Password?",
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: defaultTextStyle(
          fontSize: 31.0,
          color: colorScheme.primary,
        ),
      ),
      kSizedBox,
      // Text.rich(
      //   maxLines: 4,
      //   textAlign: TextAlign.center,
      //   TextSpan(
      //     text: "Enter your registered $registeredOption to receive an otp.\n",
      //     style: defaultTextStyle(
      //       color: colorScheme.primary,
      //       fontWeight: FontWeight.w400,
      //       fontSize: 14.0,
      //     ),
      //     children: [
      //       TextSpan(
      //         text: "Reset via $resetOption",
      //         mouseCursor: SystemMouseCursors.click,
      //         recognizer: TapGestureRecognizer()..onTap = resetVia ?? () {},
      //         style: defaultTextStyle(
      //           color: colorScheme.primary,
      //           fontWeight: FontWeight.w700,
      //           decoration: TextDecoration.underline,
      //           fontSize: 14.0,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}
