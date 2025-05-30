import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/app/school_commute_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';

schoolCommuteRouteForm(
  SchoolCommuteController controller,
  ColorScheme colorScheme,
  Size media,
) {
  return Obx(
    () {
      return Form(
        key: controller.scheduleTripRouteFormKey,
        child: Column(
          children: [
            formFieldContainer(
              colorScheme,
              media,
              borderSide: BorderSide(
                width: 1,
                color: colorScheme.primary,
              ),
              child: Center(
                child: AndroidTextFormField(
                  controller: controller.pickupLocationEC,
                  textInputAction: TextInputAction.next,
                  focusNode: controller.pickupLocationFN,
                  textCapitalization: TextCapitalization.words,
                  onChanged: controller.pickupLocationOnChanged,
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
            kHalfSizedBox,
            controller.isStopLocationVisible.value
                ? formFieldContainer(
                    colorScheme,
                    media,
                    borderSide: BorderSide(
                      width: 1,
                      color: colorScheme.primary,
                    ),
                    child: Center(
                      child: AndroidTextFormField(
                        controller: controller.stop1LocationEC,
                        focusNode: controller.stop1LocationFN,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        onChanged: controller.stopLocationOnChanged,
                        hintText: "Add a Stop",
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  )
                : const SizedBox(),
            controller.isStopLocationVisible.value
                ? kHalfSizedBox
                : const SizedBox(),
            formFieldContainer(
              colorScheme,
              media,
              borderSide: BorderSide(
                width: 1,
                color: colorScheme.primary,
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.search_normal,
                    color: colorScheme.inversePrimary,
                  ),
                  kSmallWidthSizedBox,
                  Expanded(
                    child: AndroidTextFormField(
                      controller: controller.destinationEC,
                      focusNode: controller.destinationFN,
                      textInputAction: TextInputAction.done,
                      onTap: controller.destinationOnTap,
                      textCapitalization: TextCapitalization.words,
                      hintText: "Enter destination",
                      onChanged: controller.destinationOnChanged,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
