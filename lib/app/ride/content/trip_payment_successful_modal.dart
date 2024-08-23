import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/ride_controller.dart';
import '../../../theme/colors.dart';

class TripPaymentSuccessfulModal extends GetView<RideController> {
  const TripPaymentSuccessfulModal({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: media.width,
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.greenWavyCheckIconSvg),
            kBigSizedBox,
            Text(
              "Payment Successful!",
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            kSizedBox,
            Text(
              "Amount Paid",
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            kHalfSizedBox,
            Text.rich(
              TextSpan(
                text: "$nairaSign ",
                style: defaultTextStyle(
                  color: colorScheme.primary,
                  fontSize: 16,
                  fontFamily: "",
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: intFormattedText(2000),
                    style: defaultTextStyle(
                      color: colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            kBigSizedBox,
            kBigSizedBox,
            Text(
              "How was your trip?",
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            kHalfSizedBox,
            Text(
              "Your feedback will help us improve trip experiences to serve you better",
              maxLines: 10,
              textAlign: TextAlign.center,
              style: defaultTextStyle(
                color: kDisabledTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            kBigSizedBox,
            AndroidElevatedButton(
              title: "Provide feedback",
              onPressed: controller.giveFeedback,
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
