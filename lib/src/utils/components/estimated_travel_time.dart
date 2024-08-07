import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

estimatedTravelTime({String? estimatedTime}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Estimated Travel time",
        style: defaultTextStyle(
          color: kDarkBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      kHalfWidthSizedBox,
      Expanded(
        child: Text(
          "~${estimatedTime ?? ""}",
          textAlign: TextAlign.end,
          style: defaultTextStyle(
            color: kDarkBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
