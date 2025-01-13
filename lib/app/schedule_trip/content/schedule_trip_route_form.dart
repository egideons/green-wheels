import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';

scheduleTripRouteForm(
  ScheduleTripController controller,
  ColorScheme colorScheme,
  Size media,
) {
  // return Obx(
  //   () {
  return Form(
    key: controller.scheduleTripRouteFormKey,
    child: Column(
      children: [
        formFieldContainer(
          colorScheme,
          media,
          containerHeight: controller.pickupLocationEC.text.isNotEmpty
              ? media.height * .09
              : null,
          borderSide: BorderSide(
            width: 1,
            color: colorScheme.primary,
          ),
          child: Center(
            child: AndroidTextFormField(
              controller: controller.pickupLocationEC,
              textInputAction: TextInputAction.next,
              focusNode: controller.pickupLocationFN,
              textCapitalization: TextCapitalization.none,
              hintText: "Enter pickup location",
              minLines: 2,
              maxLines: 10,
              onChanged: controller.pickupLocationOnChanged,
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
        // : const SizedBox(),
        formFieldContainer(
          colorScheme,
          media,
          containerHeight: controller.destinationEC.text.isNotEmpty
              ? media.height * .09
              : null,
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
                  textCapitalization: TextCapitalization.none,
                  hintText: "Enter destination",
                  minLines: 2,
                  maxLines: 10,
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
}
//   );
// }
