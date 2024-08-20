import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

defaultInfoContainer({Widget? child, EdgeInsets? padding}) {
  return Container(
    padding: padding ??
        const EdgeInsets.symmetric(
          vertical: kDefaultPadding,
          horizontal: 10,
        ),
    decoration: const ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      color: kFrameBackgroundColor,
    ),
    child: child ?? Container(),
  );
}
