import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/components/drag_handle.dart';
import '../content/book_a_ride/book_ride_option_tabbar.dart';
import 'book_a_ride_tabbar_view.dart';

homePanelSection(
  ColorScheme colorScheme,
  Size media,
  BuildContext context,
  // ScrollController scrollController,
) {
  var overlayPortalController = OverlayPortalController();
  return GetBuilder<HomeScreenController>(
    init: HomeScreenController(),
    builder: (controller) {
      return Container(
        decoration: ShapeDecoration(
          color: colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedContainer(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Row(
                children: [
                  Icon(
                    Icons.info_outlined,
                    color: colorScheme.surface,
                    size: 32,
                  ),
                  kSmallWidthSizedBox,
                  Flexible(
                    child: Text(
                      "Please note that every vehicle has a security camera for safety reasons.",
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: colorScheme.surface,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                width: media.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: ShapeDecoration(
                  color: colorScheme.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                ),
                child: Obx(
                  () {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: media.width / 3.4,
                            ),
                            child: dragHandle(media),
                          ),
                          kSmallSizedBox,
                          Container(
                            decoration: ShapeDecoration(
                              color: colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  width: .8,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                            child: Obx(
                              () {
                                return rideOptionTabBar(
                                  controller,
                                  colorScheme,
                                );
                              },
                            ),
                          ),
                          kSizedBox,
                          controller.selectedTabBar.value == 0
                              ? bookRideTabBarView(
                                  media,
                                  colorScheme,
                                  controller,
                                )
                              : controller.selectedTabBar.value == 1
                                  ? Column(
                                      children: [
                                        kBigSizedBox,
                                        AndroidElevatedButton(
                                          title: "Schedule a Ride",
                                          onPressed: controller.scheduleATrip,
                                        ),
                                        kSizedBox,
                                        AndroidElevatedButton(
                                          title: "School Commutes",
                                          onPressed: () {},
                                        ),
                                      ],
                                    )
                                  : const Column(
                                      children: [],
                                    ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
