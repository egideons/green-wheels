import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../constants/consts.dart';

paymentTypeSection({required String paymentType}) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          "Payment Type",
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Expanded(
        child: Text(
          paymentType.toUpperCase(),
          textAlign: TextAlign.end,
          style: defaultTextStyle(
            color: kPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
