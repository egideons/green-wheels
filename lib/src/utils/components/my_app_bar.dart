import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../src/constants/consts.dart';
import '../../../../../../../../theme/colors.dart';

myAppBar(
  ColorScheme colorScheme,
  Size media, {
  Color? backgroundColor,
  bool? centerTitle,
  bool? leadingIsVisible = true,
  String? title,
  bool? automaticallyImplyLeading,
  Widget? flexibleSpace,
  double? leadingWidth,
  double? elevation,
  double? scrolledUnderElevation,
  double? toolBarHeight,
  Widget? titleWidget,
  Widget? leading,
  PreferredSizeWidget? bottom,
  List<Widget>? actions,
  Color? titleColor,
  double? titleFontSize,
}) {
  return AppBar(
    backgroundColor: backgroundColor ?? colorScheme.surface,
    centerTitle: centerTitle ?? false,
    automaticallyImplyLeading: automaticallyImplyLeading ?? false,
    flexibleSpace: flexibleSpace ?? Container(),
    elevation: elevation ?? 0,
    scrolledUnderElevation: scrolledUnderElevation ?? 0,
    bottom: bottom,
    toolbarHeight: toolBarHeight ?? kToolbarHeight,
    leadingWidth: leadingWidth ?? 56.0,
    leading: leadingIsVisible == true
        ? leading ??
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: IconButton(
                tooltip: "Go back",
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.chevron_left,
                  size: 26,
                ),
              ),
            )
        : const SizedBox(),
    title: titleWidget ??
        SizedBox(
          width: media.width / 1.6,
          child: Text(
            title ?? "",
            textAlign: centerTitle == true ? TextAlign.center : TextAlign.start,
            style: defaultTextStyle(
              color: titleColor ?? kTextBlackColor,
              fontSize: titleFontSize ?? 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
    actions: actions ?? [],
  );
}
