import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/constants/consts.dart';

emailOTPPageHeader({
  ColorScheme? colorScheme,
  Size? media,
  String? title,
  String? subtitle,
  String? email,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title ?? "",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: defaultTextStyle(
          fontSize: 60,
          color: kTextBlackColor,
        ),
      ),
      kSizedBox,
      RichText(
        textAlign: TextAlign.center,
        maxLines: 10,
        text: TextSpan(
          text: subtitle,
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
          ),
          children: const [
            // TextSpan(
            //   text: email,
            //   style: defaultTextStyle(
            //     color: k,
            //     fontSize: 14.0,
            //     fontWeight: FontWeight.w600,
            //   ),
            // )
          ],
        ),
      ),
    ],
  );
}
