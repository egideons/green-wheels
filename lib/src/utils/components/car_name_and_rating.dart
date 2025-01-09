import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../theme/colors.dart';

carNameRating(
  ColorScheme colorScheme, {
  String? vehicleImage,
  String? vehicleName,
  String? vehiclePlateNumber,
  bool? isUserVerified,
  int? numOfStars,
}) {
  return Row(
    children: [
      Image.asset(vehicleImage ?? "", height: 50),
      kHalfWidthSizedBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicleName ?? "",
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            kSmallSizedBox,
            // starsWidget(colorScheme, numOfStars ?? 0, isUserVerified ?? false),
            Row(
              children: [
                Text(
                  "Plate number",
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kHalfWidthSizedBox,
                Expanded(
                  child: Text(
                    vehiclePlateNumber ?? "",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
