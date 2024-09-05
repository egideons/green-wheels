import 'package:flutter/material.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../theme/colors.dart';

rideHistoryDetail(
  ColorScheme colorScheme, {
  String? driverName,
  String? vehicleName,
  bool? isCompleted,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: kFrameBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: .8,
          color: colorScheme.primary,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              driverName ?? "",
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              vehicleName ?? "",
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          isCompleted ?? true ? "Done" : "Cancelled",
          style: defaultTextStyle(
            color: isCompleted ?? true ? kSuccessColor : kErrorColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
