import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../src/constants/assets.dart';
import '../../../../src/constants/consts.dart';

loadingScreenContent(
  Size media,
  ColorScheme colorScheme,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 120,
        width: 120,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          image: const DecorationImage(
            image: AssetImage(Assets.appIconLightBg),
          ),
        ),
      ),
      const SizedBox(
        height: kDefaultPadding * 2,
      ),
      LoadingAnimationWidget.staggeredDotsWave(
        color: colorScheme.secondary,
        size: 50,
      ),
    ],
  );
}
