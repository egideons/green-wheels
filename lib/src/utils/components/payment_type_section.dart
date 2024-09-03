import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../constants/consts.dart';

paymentTypeSection() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          "Payment Type",
          style: defaultTextStyle(
            color: kTextBlackColor,
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
            color: kTextBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
