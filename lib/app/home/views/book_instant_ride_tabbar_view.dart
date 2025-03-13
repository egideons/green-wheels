import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../content/book_a_ride/book_ride_search_for_driver_section.dart';
import 'book_a_ride_form_view.dart';

bookInstantRideTabBarView(
  Size media,
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      bookARideFormView(media, colorScheme, controller),
      kSizedBox,
      Obx(() {
        if (controller.instantRideAmount.value.isGreaterThan(0)) {
          return bookRideSearchForDriverSection(
            colorScheme,
            controller,
          );
        } else {
          return TextButton(
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
          );
        }
      }),
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
