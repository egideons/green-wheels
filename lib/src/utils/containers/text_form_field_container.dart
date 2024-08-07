import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

Widget formFieldContainer(
  ColorScheme colorScheme,
  Size media, {
  Widget? child,
  double? containerHeight,
  double? containerWidth,
  EdgeInsetsGeometry? padding,
  Color? color,
  borderSide,
}) {
  return Container(
    width: containerWidth ?? media.width,
    height: containerHeight ?? media.height * 0.06,
    padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
    decoration: ShapeDecoration(
      color: color ?? kTransparentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.inversePrimary, width: 0.5),
      ),

      // shadows: [
      //   BoxShadow(
      //     color: const Color(0x0C000000),
      //     blurRadius: 10,
      //     offset: const Offset(0, 4),
      //     spreadRadius: Get.isDarkMode ? 20 : 10,
      //   ),

      // ],
    ),
    child: Center(
      child: child,
    ),
  );
}
