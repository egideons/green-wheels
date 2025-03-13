// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/home/views/book_instant_ride_tabbar_view.dart';
import 'package:green_wheels/app/home/views/select_instant_book_option.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/components/drag_handle.dart';
import '../content/book_a_ride/book_ride_option_tabbar.dart';
import 'rent_ride_tabbar_view.dart';
import 'schedule_trip_tabbar_view.dart';

homePanelSection(
  ColorScheme colorScheme,
  Size media,
  BuildContext context,
  HomeScreenController controller,
) {
  return Obx(
    () => Container(
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
          controller.infoMessage.value.isEmpty
              ? const SizedBox()
              : AnimatedContainer(
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
                          controller.infoMessage.value,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: colorScheme.surface,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Container(
            width: media.width,
            padding: const EdgeInsets.symmetric(
              horizontal: 140,
              vertical: 10,
            ),
            decoration: ShapeDecoration(
              color: colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
            ),
            child: dragHandle(media),
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
              decoration: BoxDecoration(
                color: colorScheme.surface,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                      child: rideOptionTabBar(
                        controller,
                        colorScheme,
                      ),
                    ),
                    kSizedBox,
                    Obx(
                      () {
                        switch (controller.selectedTabBar.value) {
                          case 0:
                            return SizedBox(
                              height: media.height * .4,
                              child: PageView(
                                controller: controller
                                    .selectInstantBookOptionPageController,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  selectInstantBookOption(media, controller),
                                  Container(
                                    child: () {
                                      if (controller
                                          .sharedRideIsSelected.value) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                "Page Two",
                                                style: defaultTextStyle(
                                                  color: kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            kSizedBox,
                                            TextButton(
                                              onPressed: controller
                                                  .goBackToSelectInstantBookOption,
                                              child: Text(
                                                "Go Back",
                                                textAlign: TextAlign.center,
                                                style: defaultTextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return bookInstantRideTabBarView(
                                          media,
                                          colorScheme,
                                          controller,
                                        );
                                      }
                                    }(),
                                  ),
                                ],
                              ),
                            );

                          case 1:
                            return scheduleTripTabBarView(controller);
                          case 2:
                            return rentRideTabBarView(
                              media,
                              colorScheme,
                              controller,
                            );
                          default:
                            return Container(); // Handle unexpected values
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
