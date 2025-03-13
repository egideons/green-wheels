import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/home/views/book_shared_ride_form_view.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';

bookSharedRideTabbarView(
  Size media,
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      bookSharedRideFormView(media, colorScheme, controller),
      kSizedBox,
      Obx(() {
        if (controller.destinationSharedLocation.value.isNotEmpty) {
          return AndroidElevatedButton(
            title: "Continue",
            onPressed: controller.createSharedRide,
            isLoading: controller.initiatingSharedRide.value,
          );
        } else {
          {
            return SizedBox();
          }
        }
      }),
      kSizedBox,
      TextButton(
        onPressed: controller.goBackToSelectInstantBookOption,
        child: Text(
          "Go Back",
          textAlign: TextAlign.center,
          style: defaultTextStyle(
            color: kPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      // Obx(() {
      //   if (controller.instantRideAmount.value.isGreaterThan(0)) {
      //     return bookRideSearchForDriverSection(
      //       colorScheme,
      //       controller,
      //     );
      //   } else {
      //     return TextButton(
      //       onPressed: controller.goBackToSelectInstantBookOption,
      //       child: Text(
      //         "Go Back",
      //         textAlign: TextAlign.center,
      //         style: defaultTextStyle(
      //           color: kPrimaryColor,
      //           fontSize: 14,
      //           fontWeight: FontWeight.w800,
      //         ),
      //       ),
      //     );
      //   }
      // }),
      // Obx(() {
      //   return Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: () {
      //       if (controller.instantRideAmount.value.isGreaterThan(0)) {
      //         return <Widget>[
      //           bookRideSearchForDriverSection(
      //             colorScheme,
      //             controller,
      //           ),
      //         ];
      //       }
      //       return <Widget>[
      //         kSizedBox,
      //         TextButton(
      //           onPressed: controller.goBackToSelectInstantBookOption,
      //           child: Text(
      //             "Go Back",
      //             textAlign: TextAlign.center,
      //             style: defaultTextStyle(
      //               color: kPrimaryColor,
      //               fontSize: 14,
      //               fontWeight: FontWeight.w800,
      //             ),
      //           ),
      //         ),
      //       ];
      //     }(),
      //   );
      // }),
    ],
  );
}
