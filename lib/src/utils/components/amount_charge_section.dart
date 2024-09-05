import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../constants/consts.dart';

amountChargeSection(
  ColorScheme colorScheme, {
  int? amount,
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
          fontSize: fontSize ?? 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      isSpaceBetween == true ? const SizedBox() : kHalfWidthSizedBox,
      Expanded(
        child: Text.rich(
          textAlign: isSpaceBetween == true ? TextAlign.end : TextAlign.start,
          TextSpan(
            text: "$nairaSign ",
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: fontSize ?? 20,
              fontFamily: "",
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: intFormattedText(amount ?? 0),
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: fontSize ?? 20,
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
