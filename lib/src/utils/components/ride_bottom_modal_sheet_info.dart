import 'package:flutter/material.dart';

import '../../../../src/constants/consts.dart';
import '../../../../theme/colors.dart';

rideBottomModalSheetInfo(
  ColorScheme colorScheme,
  bool? rideInProgress, {
  bool? rideComplete,
}) {
  return AnimatedContainer(
    padding: const EdgeInsets.all(10),
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: () {
        if (rideComplete == true) {
          return [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: kSuccessColor,
              size: 32,
            ),
            kSmallWidthSizedBox,
            Flexible(
              child: Text(
                "Ride Complete!",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ];
        }
        if (rideInProgress == true) {
          return [
            const Icon(
              Icons.info_outline_rounded,
              color: kStarColor,
              size: 32,
            ),
            kSmallWidthSizedBox,
            Flexible(
              child: Text(
                "Ride in Progress",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.surface,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
          ];
        }
        return [
          const Icon(
            Icons.info_outlined,
            color: kStarColor,
            size: 32,
          ),
          kSmallWidthSizedBox,
          Flexible(
            child: Text(
              "Ride started!",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorScheme.surface,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          )
        ];
      }(),
    ),
  );
}
