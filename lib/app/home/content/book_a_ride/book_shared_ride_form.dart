import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';

bookSharedRideForm(
  HomeScreenController controller,
  ColorScheme colorScheme,
  Size media,
) {
  return Obx(() {
    final userPosition = controller.userPosition.value;
    return Form(
      key: controller.bookSharedRideFormKey,
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
                    : controller.setSharedPickupGoogleMapsLocation,
                controller: controller.pickupSharedLocationEC,
                textInputAction: TextInputAction.next,
                focusNode: controller.pickupSharedLocationFN,
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
                    onTap:
                        //  userPosition == null
                        //     ?
                        () {
                      ApiProcessorController.normalSnack("Cannot edit");
                    },
                    // :
                    // controller.setSharedDestinationGoogleMapsLocation,
                    controller: controller.sharedDestinationEC,
                    focusNode: controller.sharedDestinationFN,
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
