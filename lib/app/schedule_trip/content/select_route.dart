import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/src/utils/components/trip_icons_section.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';
import '../../../src/utils/buttons/android/android_elevated_button.dart';
import 'schedule_trip_destination_map_suggestions.dart';
import 'schedule_trip_pickup_location_map_suggestions.dart';
import 'schedule_trip_route_form.dart';

class ScheduleTripSelectRoute extends GetView<ScheduleTripController> {
  const ScheduleTripSelectRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(colorScheme, media, title: "select a route"),
      body: Container(
        width: media.width,
        decoration: ShapeDecoration(
          color: colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
        child: Obx(() {
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Container(
                width: media.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: ShapeDecoration(
                  color: kFrameBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Where to?",
                      style: defaultTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                      ),
                    ),
                    kHalfSizedBox,
                    Row(
                      children: [
                        tripIconsSection(colorScheme, controller),
                        kHalfWidthSizedBox,
                        Expanded(
                          child: scheduleTripRouteForm(
                            controller,
                            colorScheme,
                            media,
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                  ],
                ),
              ),
              kSizedBox,
              Column(
                children: () {
                  if (controller.mapSuggestionIsSelected.value) {
                    return <Widget>[
                      AndroidElevatedButton(
                        title: "Done",
                        onPressed: controller.submitRouteForm,
                      )
                    ];
                  } else if (controller.isPickupLocationTextFieldActive.value) {
                    return <Widget>[
                      scheduleTripPickupLocationMapSuggestions(
                        colorScheme,
                        controller,
                        media,
                      ),
                      SizedBox(height: media.height * .2),
                    ];
                  } else if (controller.isDestinationTextFieldActive.value) {
                    return <Widget>[
                      scheduleTripDestinationMapSuggestions(
                        colorScheme,
                        controller,
                        media,
                      ),
                      SizedBox(height: media.height * .2),
                    ];
                  }
                  // else if (controller.isStopLocationTextFieldActive.value) {
                  //   return <Widget>[
                  //     scheduleTripStopLocationMapSuggestions(
                  //       colorScheme,
                  //       controller,
                  //       media,
                  //     )
                  //   ];
                  // }
                  return <Widget>[
                    SizedBox(height: media.height * .2),
                  ];
                }(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
