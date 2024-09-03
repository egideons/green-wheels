import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

timeAndDateSection(
  ColorScheme colorScheme, {
  String? date,
  String? time,
  String? dropOffTime,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            Iconsax.calendar_2,
            color: colorScheme.primary,
            size: 26,
          ),
          kHalfWidthSizedBox,
          Text(
            date ?? formatDate(DateTime.now()),
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
      kHalfSizedBox,
      Row(
        children: [
          Icon(
            Iconsax.clock,
            color: colorScheme.primary,
            size: 26,
          ),
          kHalfWidthSizedBox,
          Column(
            children: [
              Text(
                time ?? format12HrTime(DateTime.now()),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              dropOffTime != null
                  ? Text(
                      dropOffTime,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: defaultTextStyle(
                        color: kBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
    ],
  );
}
