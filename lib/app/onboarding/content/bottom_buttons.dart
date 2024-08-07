import 'package:flutter/material.dart';

import '../../../src/controllers/others/onboarding_controller.dart';
import '../../../src/utils/buttons/android/android_elevated_button.dart';
import '../../../theme/colors.dart';

bottomButtons(Size media, OnboardingController controller) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: () {
        if (controller.currentPage.value == 0) {
          return [
            const SizedBox(),
            IconButton.filled(
              onPressed: () {
                controller.imageController.value.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
                controller.pageController.value.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.chevron_right,
                color: kSecondaryColor,
                size: 34,
              ),
            )
          ];
        }
        if (controller.currentPage.value + 1 ==
            controller.onboardContent.value.items.length) {
          return [
            IconButton.filled(
              onPressed: () {
                controller.imageController.value.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
                controller.pageController.value.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.chevron_left,
                color: kSecondaryColor,
                size: 34,
              ),
            ),
            SizedBox(
              width: media.width / 2,
              child: AndroidElevatedButton(
                title: "Get Started",
                onPressed: controller.toLogin,
                isRowVisible: true,
                mainAxisAlignment: MainAxisAlignment.center,
                buttonIcon: Icons.chevron_right,
                buttonIconSize: 32,
              ),
            )
          ];
        } else {
          return [
            IconButton.filled(
              onPressed: () {
                controller.imageController.value.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
                controller.pageController.value.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.chevron_left,
                color: kSecondaryColor,
                size: 34,
              ),
            ),
            IconButton.filled(
              onPressed: () {
                controller.imageController.value.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
                controller.pageController.value.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.chevron_right,
                color: kSecondaryColor,
                size: 34,
              ),
            )
          ];
        }
      }(),
    ),
  );
}
