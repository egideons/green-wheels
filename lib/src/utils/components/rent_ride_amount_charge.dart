import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

rentRideAmountCharge({int? rideAmount}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Amount Charge\n(per minute)",
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      Expanded(
        child: Text.rich(
          textAlign: TextAlign.end,
          TextSpan(
            text: '$nairaSign ',
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 16,
              fontFamily: "",
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: intFormattedText(rideAmount ?? 0),
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
