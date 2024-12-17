import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../content/book_a_ride/book_ride_destination_map_suggestions.dart';
import '../content/book_a_ride/book_ride_pickup_location_map_suggestions.dart';
import '../content/book_a_ride/book_ride_search_for_driver_section.dart';
import 'book_a_ride_form_view.dart';

bookInstantRideTabBarView(
  Size media,
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bookARideFormView(media, colorScheme, controller),
      kSizedBox,
      Column(
        children: () {
          if (controller.mapSuggestionIsSelected.isTrue) {
            return <Widget>[
              bookRideSearchForDriverSection(
                colorScheme,
                controller,
              ),
            ];
          } else if (controller.isPickupLocationTextFieldActive.value) {
            return <Widget>[
              bookRidePickupLocationMapSuggestions(
                colorScheme,
                controller,
                media,
              ),
              SizedBox(height: media.height * .4),
            ];
          } else if (controller.isDestinationTextFieldActive.value) {
            return <Widget>[
              bookRideDestinationMapSuggestions(
                colorScheme,
                controller,
                media,
              ),
              SizedBox(height: media.height * .4),
            ];
          }
          //  else if (controller.isStopLocationTextFieldActive.value) {
          //   return <Widget>[
          //     bookRideStopLocationMapSuggestions(
          //       colorScheme,
          //       controller,
          //       media,
          //     ),
          //     SizedBox(height: media.height * .4),
          //   ];
          // }
          return <Widget>[
            SizedBox(height: media.height * .6),
          ];
        }(),
      ),
    ],
  );
}
