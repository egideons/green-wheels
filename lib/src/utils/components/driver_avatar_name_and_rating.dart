import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/utils/components/circle_avatar_image.dart';
import '../../../src/utils/components/stars_widget.dart';
import '../../../theme/colors.dart';

driverAvatarNameRating(
  ColorScheme colorScheme, {
  String? driverName,
  int? numOfStars,
  bool? isUserVerified,
}) {
  return Row(
    children: [
      circleAvatarImage(colorScheme, height: 64),
      kSmallWidthSizedBox,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            driverName ?? "",
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          kSmallSizedBox,
          starsWidget(colorScheme, numOfStars ?? 0, isUserVerified ?? false),
        ],
      ),
    ],
  );
}
