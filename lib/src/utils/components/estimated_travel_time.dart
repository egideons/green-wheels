import 'package:flutter/material.dart';

import '../../constants/consts.dart';

estimatedTravelTime(ColorScheme colorScheme, {String? estimatedTime}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Estimated Travel time",
        style: defaultTextStyle(
          color: colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      Expanded(
        child: Text(
          "~${estimatedTime ?? ""}",
          textAlign: TextAlign.end,
          style: defaultTextStyle(
            color: colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
