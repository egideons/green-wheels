import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

dragHandle(Size media) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      height: 4,
      width: media.width / 3,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: kBlackColor,
      ),
    ),
  );
}
