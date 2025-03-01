import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';

bookRideForm(
  HomeScreenController controller,
  ColorScheme colorScheme,
  Size media,
) {
  return Obx(() {
    final userPosition = controller.userPosition.value;
    return Form(
      key: controller.bookRideFormKey,
      child: Column(
        children: [
          formFieldContainer(
            colorScheme,
            media,
            containerHeight: media.height * .1,
            borderSide: BorderSide(
              width: 1,
              color: colorScheme.primary,
            ),
            child: Center(
              child: AndroidTextFormField(
                readOnly: true,
                onTap: userPosition == null
                    ? null
                    : controller.setPickupGoogleMapsLocation,
                controller: controller.pickupLocationEC,
                textInputAction: TextInputAction.next,
                focusNode: controller.pickupLocationFN,
                hintText: userPosition == null
                    ? "Retrieving your location"
                    : "Enter pickup location",
                textCapitalization: TextCapitalization.words,
                minLines: 1,
                maxLines: 10,
                validator: (value) {
                  return null;
                },
              ),
            ),
          ),

          kHalfSizedBox,
          // controller.isStopLocationVisible.value
          //     ? formFieldContainer(
          //         colorScheme,
          //         media,
          //         borderSide: BorderSide(
          //           width: 1,
          //           color: colorScheme.primary,
          //         ),
          //         child: Center(
          //           child: AndroidTextFormField(
          //             controller: controller.stop1LocationEC,
          //             focusNode: controller.stop1LocationFN,
          //             textInputAction: TextInputAction.next,
          //             textCapitalization: TextCapitalization.words,
          //             onChanged: controller.stopLocationOnChanged,
          //             hintText: "Add a Stop",
          //             validator: (value) {
          //               return null;
          //             },
          //           ),
          //         ),
          //       )
          //     : const SizedBox(),
          // controller.isStopLocationVisible.value
          //     ? kHalfSizedBox
          //     : const SizedBox(),
          formFieldContainer(
            colorScheme,
            media,
            containerHeight: media.height * .1,
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
                    readOnly: true,
                    onTap: userPosition == null
                        ? null
                        : controller.setDestinationGoogleMapsLocation,
                    controller: controller.destinationEC,
                    focusNode: controller.destinationFN,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    hintText: "Enter destination",
                    minLines: 1,
                    maxLines: 10,
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
  });
}
