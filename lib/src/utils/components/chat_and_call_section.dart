import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/consts.dart';

chatAndCallSection(
  ColorScheme colorScheme, {
  void Function()? chatFunc,
  void Function()? callFunc,
  String? chatToolTip,
  String? callToolTip,
}) {
  return Row(
    children: [
      IconButton(
        onPressed: chatFunc ?? () {},
        tooltip: chatToolTip,
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.secondary,
        ),
        icon: Icon(
          Iconsax.message,
          color: colorScheme.secondary,
          size: 20,
        ),
      ),
      kSmallWidthSizedBox,
      IconButton(
        onPressed: callFunc ?? () {},
        tooltip: callToolTip,
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.secondary,
        ),
        icon: Icon(
          Iconsax.call,
          color: colorScheme.secondary,
          size: 20,
        ),
      ),
    ],
  );
}
