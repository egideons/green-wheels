import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:iconsax/iconsax.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/ride_controller.dart';

class TripFeedbackAppreciationDialog extends GetView<RideController> {
  const TripFeedbackAppreciationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

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
              icon: const Icon(Iconsax.close_circle),
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
          kSizedBox,
          kBigSizedBox,
          AndroidElevatedButton(
            title: "Home screen",
            onPressed: controller.goToHomeScreen,
          ),
          kBigSizedBox,
        ],
      ),
    );
  }
}
