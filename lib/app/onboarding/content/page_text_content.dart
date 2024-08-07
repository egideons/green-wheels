import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/others/onboarding_controller.dart';
import '../../../theme/colors.dart';

pageTextContent(int index, OnboardingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: kDefaultPadding * 2,
      horizontal: 10,
    ),
    child: Column(
      children: [
        Text(
          controller.onboardContent.value.items[index].title,
          textAlign: TextAlign.center,
          maxLines: 4,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: kTextBlackColor,
          ),
        ),
        kSizedBox,
        Text(
          controller.onboardContent.value.items[index].description,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: kTextBlackColor,
          ),
        ),
      ],
    ),
  );
}
