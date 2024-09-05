import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';

menuTotalInfoContainer(
  ColorScheme colorScheme, {
  IconData? icon,
  int? number,
  String? label,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: .8,
            color: colorScheme.primary,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon),
                Text(
                  intFormattedText(number ?? 0),
                  textAlign: TextAlign.start,
                  style: defaultTextStyle(
                    color: colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total",
                textAlign: TextAlign.start,
                style: defaultTextStyle(
                  color: colorScheme.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                label ?? "",
                textAlign: TextAlign.start,
                style: defaultTextStyle(
                  color: colorScheme.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
