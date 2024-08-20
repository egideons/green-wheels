import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/components/drag_handle.dart';
import '../content/destination_map_suggestions.dart';
import '../content/pickup_location_map_suggestions.dart';
import '../content/ride_option_tabbar.dart';
import '../content/search_for_driver_section.dart';
import '../content/stop_location_map_suggestions.dart';
import 'book_ride_view.dart';

homePanelSection(
  ColorScheme colorScheme,
  Size media,
  BuildContext context,
  // ScrollController scrollController,
) {
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
                child: ListView(
                  // controller: scrollController,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: media.width / 3.6),
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
                    bookRideView(media, colorScheme, controller),
                    kSizedBox,
                    Obx(
                      () {
                        return controller.mapSuggestionIsSelected.isTrue
                            ? searchForDriverSection(
                                colorScheme,
                                controller,
                              )
                            : Expanded(
                                child: controller
                                        .isPickupLocationTextFieldActive.value
                                    ? pickupLocationMapSuggestions(
                                        colorScheme,
                                        controller,
                                        media,
                                      )
                                    : controller
                                            .isDestinationTextFieldActive.value
                                        ? destinationMapSuggestions(
                                            colorScheme,
                                            controller,
                                            media,
                                          )
                                        : controller
                                                .isStopLocationTextFieldActive
                                                .value
                                            ? stopLocationMapSuggestions(
                                                colorScheme,
                                                controller,
                                                media,
                                              )
                                            : const SizedBox(height: 300));
                      },
                    ),
                    kBigSizedBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
