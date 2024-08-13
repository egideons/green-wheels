import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/signup_controller.dart';
import '../../../../src/controllers/others/url_launcher_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

signupForm(ColorScheme colorScheme, Size media, SignupController controller) {
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
                color: kGreenLightColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(6),
                ),
              ),
              child: const Icon(
                Iconsax.call,
                color: kBlackColor,
              ),
            ),
            kHalfWidthSizedBox,
            Text(
              "+234",
              textAlign: TextAlign.start,
              style: defaultTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextBlackColor,
              ),
            ),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                readOnly: controller.isLoading.value,
                controller: controller.phoneNumberEC,
                focusNode: controller.phoneNumberFN,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.phone,
                hintText: "Mobile Number",
                onFieldSubmitted: controller.onSubmitted,
                validator: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      kBigSizedBox,
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
                  color: kDisabledTextColor,
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
                      color: kPrimaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "and ",
                    mouseCursor: SystemMouseCursors.click,
                    style: defaultTextStyle(
                      color: kDisabledTextColor,
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
                      color: kPrimaryColor,
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
