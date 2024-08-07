import 'package:flutter/material.dart';

import '../../../../src/constants/consts.dart';

resetPasswordPageHeader(
    {ColorScheme? colorScheme, Size? media, String? title, String? subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? "",
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: defaultTextStyle(
          fontSize: 31,
          color: colorScheme!.primary,
        ),
      ),
      kSizedBox,
      SizedBox(
        width: media!.width - 50,
        child: Text(
          subtitle ?? "",
          maxLines: 10,
          textAlign: TextAlign.center,
          style: defaultTextStyle(
            color: colorScheme.primary,
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ],
  );
}
