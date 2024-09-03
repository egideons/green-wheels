import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../constants/consts.dart';

amountChargeSection(ColorScheme colorScheme, {int? amount}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          "Amount Charge",
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text.rich(
        TextSpan(
          text: "$nairaSign ",
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 20,
            fontFamily: "",
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: intFormattedText(amount ?? 0),
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
