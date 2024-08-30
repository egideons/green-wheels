import 'package:flutter/material.dart';

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
            color: colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text.rich(
        TextSpan(
          text: "$nairaSign ",
          style: defaultTextStyle(
            color: colorScheme.primary,
            fontSize: 16,
            fontFamily: "",
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
              text: intFormattedText(amount ?? 0),
              style: defaultTextStyle(
                color: colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
