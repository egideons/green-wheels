import 'package:flutter/material.dart';

import '../../../src/constants/assets.dart';
import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/menu_screen_controller.dart';
import '../../../src/utils/components/circle_avatar_image.dart';
import '../../../theme/colors.dart';

profileInfo(
  ColorScheme colorScheme,
  Size media,
  MenuScreenController controller,
) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: circleAvatarImage(
          colorScheme,
          height: media.height * .16,
          foregroundImage: const AssetImage(Assets.avatarImagePng),
        ),
      ),
      kWidthSizedBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stella Ogaziechi",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                child: Text(
                  "Edit profile",
                  textAlign: TextAlign.start,
                  style: defaultTextStyle(
                    color: colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
