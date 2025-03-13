import 'package:flutter/material.dart';

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
  return Column(
    children: [
      formFieldContainer(
        colorScheme,
        media,
        containerHeight: media.height * .1,
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.primary,
        ),
        child: AndroidTextFormField(
          onTap: controller.setPickupGoogleMapsLocation,
          readOnly: true,
          controller: controller.pickupLocationEC,
          textInputAction: TextInputAction.next,
          focusNode: controller.pickupLocationFN,
          textCapitalization: TextCapitalization.none,
          hintText: "Enter pickup location",
          minLines: 2,
          maxLines: 10,
          validator: (value) {
            return null;
          },
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
        containerHeight: media.height * .1,
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.primary,
        ),
        child: AndroidTextFormField(
          readOnly: true,
          onTap: controller.setDestinationGoogleMapsLocation,
          controller: controller.destinationEC,
          focusNode: controller.destinationFN,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.none,
          hintText: "Enter destination",
          minLines: 2,
          maxLines: 10,
          validator: (value) {
            return null;
          },
        ),
      ),
    ],
  );
}
//   );
// }
