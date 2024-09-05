import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/menu_screen_controller.dart';
import '../../../theme/colors.dart';

menuOption(
  ColorScheme colorScheme,
  MenuScreenController controller, {
  void Function()? nav,
  IconData? icon,
  String? title,
}) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: .8,
          color: colorScheme.primary,
        ),
      ),
    ),
    child: ListTile(
      onTap: nav ?? () {},
      leading: Icon(icon),
      title: Text(
        title ?? "",
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}
