import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:iconsax/iconsax.dart';

import '../../../src/constants/consts.dart';

class TripFeedbackAppreciationDialog extends GetView<HomeScreenController> {
  const TripFeedbackAppreciationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    Timer(const Duration(milliseconds: 1000), () async {
      controller.goToHomeScreen();
    });

    return Container(
      width: media.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: controller.goToHomeScreen,
              icon: const Icon(Iconsax.close_circle, size: 32),
            ),
          ),
          SvgPicture.asset(Assets.greenWavyCheckIconSvg),
          kHalfSizedBox,
          Text(
            "Thank you for your feedback!",
            maxLines: 10,
            textAlign: TextAlign.center,
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          kBigSizedBox,
        ],
      ),
    );
  }
}
