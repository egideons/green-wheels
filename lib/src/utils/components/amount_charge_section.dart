import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../constants/consts.dart';

amountChargeSection(
  ColorScheme colorScheme, {
  double? amount,
  double? fontSize,
  bool? isSpaceBetween,
}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: isSpaceBetween ?? false
        ? MainAxisAlignment.start
        : MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Amount Charge",
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      // isSpaceBetween == true ? const SizedBox() : kHalfWidthSizedBox,
      Expanded(
        child: Text.rich(
          textAlign: TextAlign.end,
          TextSpan(
            text: "$nairaSign ",
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: fontSize ?? 14,
              fontFamily: "",
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: doubleFormattedTextWithDecimal(amount ?? 0.0),
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: fontSize ?? 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
