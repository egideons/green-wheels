import 'package:flutter/material.dart';
import 'package:green_wheels/app/home/content/book_a_ride/book_shared_ride_form.dart';
import 'package:green_wheels/src/utils/components/trip_icons_section.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../theme/colors.dart';

bookSharedRideFormView(
  Size media,
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
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
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: colorScheme.primary,
          ),
        ),
        kHalfSizedBox,
        Row(
          children: [
            tripIconsSection(
              colorScheme,
              controller,
            ),
            kHalfWidthSizedBox,
            Expanded(
              child: bookSharedRideForm(controller, colorScheme, media),
            ),
          ],
        ),
      ],
    ),
  );
}
