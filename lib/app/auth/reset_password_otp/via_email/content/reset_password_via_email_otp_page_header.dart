import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/constants/consts.dart';

resetPasswordViaEmailOTPPageHeader({
  Size? media,
  String? title,
  String? subtitle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        child: Text(
          title ?? "",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: defaultTextStyle(
            fontSize: 31.0,
            color: kTextBlackColor,
          ),
        ),
      ),
      kSizedBox,
      SizedBox(
        width: media!.width - 50,
        child: Text(
          subtitle ?? "",
          textAlign: TextAlign.center,
          maxLines: 10,
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
