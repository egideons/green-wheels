import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/email_login_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

emailLoginForm(
    ColorScheme colorScheme, Size media, EmailLoginController controller) {
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
    ],
  );
}
