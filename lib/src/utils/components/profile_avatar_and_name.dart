import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import 'circle_avatar_image.dart';

profileAvatarAndName(ColorScheme colorScheme) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      circleAvatarImage(colorScheme, height: 100),
      kWidthSizedBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "John",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "Kennedy",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            kSmallSizedBox,
          ],
        ),
      )
    ],
  );
}
