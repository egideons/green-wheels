import 'package:flutter/material.dart';

import '../../constants/consts.dart';

profileOption(
  ColorScheme colorScheme, {
  void Function()? nav,
  String? icon,
  String? title,
}) {
  return InkWell(
    onTap: nav ?? () {},
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: ShapeDecoration(
        color: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: defaultTextStyle(
                  color: colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: colorScheme.secondary,
          ),
        ],
      ),
    ),
  );
}
