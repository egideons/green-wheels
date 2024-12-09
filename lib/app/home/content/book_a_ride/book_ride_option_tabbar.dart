import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../theme/colors.dart';

rideOptionTabBar(HomeScreenController controller, ColorScheme colorScheme) {
  return TabBar(
    controller: controller.tabBarController,
    onTap: (value) => controller.clickOnTabBarOption(value),
    enableFeedback: true,
    mouseCursor: SystemMouseCursors.click,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: kTransparentColor,
    automaticIndicatorColorAdjustment: true,
    labelColor: colorScheme.surface,
    unselectedLabelColor: kTextBlackColor,
    indicator: BoxDecoration(
      color: colorScheme.primary,
      borderRadius: controller.selectedTabBar.value == 0
          ? const BorderRadius.all(
              Radius.circular(8),
            )
          : controller.selectedTabBar.value == 1
              ? const BorderRadius.all(
                  Radius.circular(8),
                )
              : const BorderRadius.all(
                  Radius.circular(8),
                ),
    ),
    tabs: List.generate(
      controller.tabData(colorScheme).length,
      (index) {
        final tab = controller.tabData(colorScheme)[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8.0),
          child: Column(
            children: [
              SvgPicture.asset(
                tab['icon']!,
                // ignore: deprecated_member_use
                color: controller.selectedTabBar.value == index
                    ? colorScheme.surface
                    : tab['color'],
              ),
              Text(
                tab['label']!,
                style: defaultTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: controller.selectedTabBar.value == index
                      ? colorScheme.surface
                      : tab['color'],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
