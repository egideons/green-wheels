import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

timeAndDateSection(
  ColorScheme colorScheme, {
  DateTime? date,
  DateTime? time,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Iconsax.calendar_2,
            color: colorScheme.primary,
            size: 26,
          ),
          kHalfSizedBox,
          Icon(
            Iconsax.clock,
            color: colorScheme.primary,
            size: 26,
          ),
        ],
      ),
      kHalfWidthSizedBox,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formatDate(date ?? DateTime.now()),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: defaultTextStyle(
                color: kBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            kHalfSizedBox,
            Text(
              format12HrTime(time ?? DateTime.now()),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: defaultTextStyle(
                color: kBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
