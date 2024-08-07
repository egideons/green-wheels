import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import '../buttons/android/android_elevated_button.dart';
import 'circle_avatar_image.dart';

passengerRequestCard(
  Size media,
  ColorScheme colorScheme, {
  String? title,
  String? buttonTitle,
  void Function()? onPressed,
}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colorScheme.primary)),
    child: Row(
      children: [
        circleAvatarImage(colorScheme, height: 60),
        kSmallWidthSizedBox,
        Expanded(
          child: Text(
            title ?? "",
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: defaultTextStyle(
              color: kDarkBlackColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: media.width - 250,
          child: AndroidElevatedButton(
            onPressed: onPressed ?? () {},
            title: buttonTitle ?? "View",
          ),
        ),
      ],
    ),
  );
}
