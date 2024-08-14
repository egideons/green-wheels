import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/phone_login_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

loginForm(
    ColorScheme colorScheme, Size media, PhoneLoginController controller) {
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
                textInputAction: TextInputAction.done,
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
      kSizedBox,
    ],
  );
}
