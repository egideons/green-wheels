import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../src/controllers/others/onboarding_controller.dart';

smoothPageIndicator(ColorScheme colorScheme, OnboardingController controller) {
  return Center(
    child: SmoothPageIndicator(
      controller: controller.pageController.value,
      count: controller.onboardContent.value.items.length,
      onDotClicked: (index) {
        controller.pageController.value.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      effect: ExpandingDotsEffect(
        spacing: 2,
        radius: 20.0,
        expansionFactor: 8.0,
        dotWidth: 5.0,
        dotHeight: 4,
        paintStyle: PaintingStyle.fill,
        strokeWidth: 1.0,
        dotColor: colorScheme.inversePrimary,
        activeDotColor: colorScheme.primary,
      ),
    ),
  );
}
