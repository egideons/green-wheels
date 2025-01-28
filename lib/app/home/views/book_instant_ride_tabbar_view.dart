import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bookARideFormView(media, colorScheme, controller),
      kSizedBox,
      Obx(() {
        return Column(
          children: () {
            if (controller.instantRideAmount.value.isGreaterThan(0)) {
              return <Widget>[
                bookRideSearchForDriverSection(
                  colorScheme,
                  controller,
                ),
              ];
            }
            return <Widget>[
              SizedBox(height: media.height * .6),
            ];
          }(),
        );
      }),
    ],
  );
}
