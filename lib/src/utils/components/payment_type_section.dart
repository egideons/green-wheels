import 'package:flutter/material.dart';

import '../../constants/consts.dart';

paymentTypeSection(ColorScheme colorScheme) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          "Payment Type",
          style: defaultTextStyle(
            color: colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Expanded(
        child: Text(
          "Green Wallet",
          textAlign: TextAlign.end,
          style: defaultTextStyle(
            color: colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
