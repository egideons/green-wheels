import 'package:flutter/material.dart';

import '../../../../../src/controllers/menu/ride_history_menu_controller.dart';
import '../../../../../theme/colors.dart';

rideHistoryMenuTabs(
  ColorScheme colorScheme,
  RideHistoryMenuController controller,
) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      decoration: const ShapeDecoration(
        color: kFrameBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: TabBar(
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
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
        ),
        tabs: const [
          Tab(text: "Completed"),
          Tab(text: "Cancelled"),
        ],
      ),
    ),
  );
}
