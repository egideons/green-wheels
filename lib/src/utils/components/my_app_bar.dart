import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../src/constants/consts.dart';
import '../../../../../../../../theme/colors.dart';

myAppBar(
  ColorScheme colorScheme,
  Size media, {
  Color? backgroundColor,
  double? toolbarHeight,
  bool? centerTitle,
  bool? isLeadingVisible,
  String? title,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? colorScheme.surface,
    toolbarHeight: toolbarHeight ?? kToolbarHeight,
    centerTitle: centerTitle ?? true,
    leading: isLeadingVisible == true
        ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: kBlackColor,
            ),
          )
        : const SizedBox(),
    title: SizedBox(
      width: media.width - 100,
      child: Text(
        title ?? "",
        textAlign: TextAlign.start,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    actions: actions ?? [],
    bottom: bottom,
  );
}
