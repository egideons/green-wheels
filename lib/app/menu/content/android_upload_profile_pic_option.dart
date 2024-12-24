import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/theme/colors.dart';

androidUploadProfilePicOption(
  ColorScheme colorScheme, {
  void Function()? onTap,
  String? icon,
  String? label,
}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap ?? () {},
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 60,
          width: 60,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                width: 0.5,
                color: colorScheme.inversePrimary,
              ),
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              icon ?? "",
              // ignore: deprecated_member_use
              color: colorScheme.primary,
            ),
          ),
        ),
      ),
      kHalfSizedBox,
      Text(
        label ?? "",
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
