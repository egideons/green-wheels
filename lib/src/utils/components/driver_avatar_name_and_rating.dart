import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/utils/components/circle_avatar_image.dart';
import '../../../src/utils/components/stars_widget.dart';
import '../../../theme/colors.dart';

driverAvatarNameRating(
  ColorScheme colorScheme, {
  String? driverImage,
  String? driverName,
  int? numOfStars,
}) {
  return Row(
    children: [
      driverImage == null || driverImage.isEmpty
          ? SizedBox()
          : circleAvatarImage(
              colorScheme,
              height: 64,
              foregroundImage: NetworkImage(driverImage),
            ),
      driverImage == null || driverImage.isEmpty
          ? SizedBox()
          : kSmallWidthSizedBox,
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
          starsWidget(colorScheme, numOfStars ?? 0),
        ],
      ),
    ],
  );
}
