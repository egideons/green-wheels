import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import 'circle_avatar_image.dart';

passengerNameAndAvatar(
  ColorScheme colorScheme, {
  double? avatarHeight,
  String? avatar,
  String? passengerName,
}) {
  return Row(
    children: [
      circleAvatarImage(colorScheme, height: avatarHeight ?? 66),
      kHalfWidthSizedBox,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            passengerName ?? "",
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          kSmallSizedBox,
          Text(
            "Passenger",
            style: defaultTextStyle(
              color: kDarkBlackColor,
              fontSize: 12.4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      )
    ],
  );
}
