import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/provide_name_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

provideNameForm(
  ColorScheme colorScheme,
  Size media,
  ProvideNameController controller,
) {
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
                Iconsax.user,
                color: kBlackColor,
              ),
            ),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                readOnly: controller.isLoading.value,
                controller: controller.userNameEC,
                focusNode: controller.userNameFN,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                hintText: "Enter full name",
                onChanged: controller.userNameOnChanged,
                onFieldSubmitted: controller.onSubmitted,
                validator: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
