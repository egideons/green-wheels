import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

starsWidget(ColorScheme colorScheme, int star) {
  return Builder(
    builder: (context) {
      List<Widget> stars = [];
      for (var i = 0; i < 5; i++) {
        if (i < star) {
          stars.add(
            const Icon(
              Icons.star_rounded,
              color: kStarColor,
              size: 20,
            ),
          );
        } else {
          stars.add(
            const Icon(
              Icons.star_outline_rounded,
              color: kStarColor,
              size: 20,
            ),
          );
        }
      }
      return Row(children: stars);
    },
  );
}
