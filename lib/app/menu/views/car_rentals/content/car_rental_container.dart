import 'package:flutter/material.dart';

import '../../../../../theme/colors.dart';

carRentalContainer(ColorScheme colorScheme, {Widget? child}) {
  return Container(
    padding: const EdgeInsets.only(
      top: 10,
      right: 10,
      left: 10,
      bottom: 20,
    ),
    decoration: ShapeDecoration(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          width: 1,
          color: kDarkBlackColor,
        ),
      ),
      shadows: [
        BoxShadow(
          color: colorScheme.primary.withValues(),
          blurRadius: 4,
          spreadRadius: 0,
          offset: const Offset(0, 2),
        )
      ],
    ),
    child: child ?? Container(),
  );
}
