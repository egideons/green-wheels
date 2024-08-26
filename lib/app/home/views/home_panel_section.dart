import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/components/drag_handle.dart';
import '../content/book_ride_destination_map_suggestions.dart';
import '../content/book_ride_option_tabbar.dart';
import '../content/book_ride_pickup_location_map_suggestions.dart';
import '../content/book_ride_search_for_driver_section.dart';
import '../content/book_ride_stop_location_map_suggestions.dart';
import 'book_a_ride_form_view.dart';

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
                child: Obx(
                  () {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: media.width / 3.6,
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
                          bookARideFormView(media, colorScheme, controller),
                          kSizedBox,
                          Column(
                            children: () {
                              if (controller.mapSuggestionIsSelected.isTrue) {
                                return <Widget>[
                                  searchForDriverSection(
                                    colorScheme,
                                    controller,
                                  ),
                                ];
                              } else if (controller
                                  .isPickupLocationTextFieldActive.value) {
                                return <Widget>[
                                  pickupLocationMapSuggestions(
                                    colorScheme,
                                    controller,
                                    media,
                                  ),
                                ];
                              } else if (controller
                                  .isDestinationTextFieldActive.value) {
                                return <Widget>[
                                  destinationMapSuggestions(
                                    colorScheme,
                                    controller,
                                    media,
                                  )
                                ];
                              } else if (controller
                                  .isStopLocationTextFieldActive.value) {
                                return <Widget>[
                                  stopLocationMapSuggestions(
                                    colorScheme,
                                    controller,
                                    media,
                                  )
                                ];
                              }
                              return <Widget>[
                                SizedBox(height: media.height * .6),
                              ];
                            }(),
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
