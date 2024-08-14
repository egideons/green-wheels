import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/others/url_launcher_controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/email_signup_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

emailSignupForm(
    ColorScheme colorScheme, Size media, EmailSignupController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      formFieldContainer(
        colorScheme,
        media,
        containerHeight: media.height * .08,
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: kFrameBackgroundColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(6),
                ),
              ),
              child: const Icon(
                Iconsax.sms,
                color: kBlackColor,
              ),
            ),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                readOnly: controller.isLoading.value,
                controller: controller.emailEC,
                focusNode: controller.emailFN,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter Email Address",
                onFieldSubmitted: controller.onSubmitted,
                validator: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      kSizedBox,
      Row(
        children: [
          Obx(() {
            return Checkbox(
              value: controller.isChecked.value,
              shape: const CircleBorder(),
              onChanged: controller.toggleCheck,
            );
          }),
          Expanded(
            child: RichText(
              maxLines: 10,
              text: TextSpan(
                text: "By Signing up you agree to the ",
                style: defaultTextStyle(
                  color: colorScheme.inversePrimary,
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0,
                ),
                children: [
                  TextSpan(
                    text: "Terms of Service ",
                    mouseCursor: SystemMouseCursors.click,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        UrlLaunchController.launchWeb(
                          "https://google.com",
                          LaunchMode.externalApplication,
                        );
                      },
                    style: defaultTextStyle(
                      color: colorScheme.primary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "and ",
                    mouseCursor: SystemMouseCursors.click,
                    style: defaultTextStyle(
                      color: colorScheme.inversePrimary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "Privacy policy.",
                    mouseCursor: SystemMouseCursors.click,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        UrlLaunchController.launchWeb(
                          "https://google.com",
                          LaunchMode.externalApplication,
                        );
                      },
                    style: defaultTextStyle(
                      color: colorScheme.primary,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      kSizedBox,
    ],
  );
}
