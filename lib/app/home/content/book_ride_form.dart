import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/containers/text_form_field_container.dart';
import '../../../src/utils/textformfields/android/android_textformfield.dart';

bookRideForm(
  HomeScreenController controller,
  ColorScheme colorScheme,
  Size media,
) {
  return Obx(
    () {
      return Form(
        key: controller.formKey,
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
                        hintText: "Add Stop",
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
              child: AndroidTextFormField(
                controller: controller.destinationEC,
                textInputAction: TextInputAction.done,
                focusNode: controller.destinationFN,
                textCapitalization: TextCapitalization.words,
                hintText: "Enter destination",
                validator: (value) {
                  return null;
                },
                onFieldSubmitted: controller.onFieldSubmitted,
              ),
            ),
          ],
        ),
      );
    },
  );
}
