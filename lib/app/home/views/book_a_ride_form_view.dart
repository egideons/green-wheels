import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../theme/colors.dart';
import '../content/book_a_ride/book_ride_form.dart';
import '../content/book_a_ride/book_ride_ride_icons_section.dart';

bookARideFormView(
    Size media, ColorScheme colorScheme, HomeScreenController controller) {
  return Container(
    width: media.width,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: ShapeDecoration(
      color: kFrameBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Where to?",
          style: defaultTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: colorScheme.primary,
          ),
        ),
        kHalfSizedBox,
        Row(
          children: [
            rideIconsSection(colorScheme, controller),
            kHalfWidthSizedBox,
            Expanded(
              child: bookRideForm(controller, colorScheme, media),
            ),
          ],
        ),
      ],
    ),
  );
}
