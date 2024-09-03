import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/utils/components/stars_widget.dart';
import '../../../theme/colors.dart';

carNameRating(
  ColorScheme colorScheme, {
  String? vehicleImage,
  String? vehicleName,
  int? numOfStars,
  bool? isUserVerified,
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
            starsWidget(colorScheme, numOfStars ?? 0, isUserVerified ?? false),
          ],
        ),
      ),
    ],
  );
}
