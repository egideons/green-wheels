import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/app/school_commute_controller.dart';
import 'package:green_wheels/src/utils/components/trip_icons_section.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:iconsax/iconsax.dart';

import '../../../src/constants/consts.dart';
import '../../../src/utils/buttons/android/android_elevated_button.dart';
import '../content/school_commute_destination_map_suggestions.dart';
import '../content/school_commute_pickup_location_map_suggestions.dart';
import '../content/school_commute_route_form.dart';
import '../content/school_commute_stop_location_map_suggestions.dart';

class SchoolCommuteSelectRouteModal extends GetView<SchoolCommuteController> {
  const SchoolCommuteSelectRouteModal({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
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
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Get.close(0);
              },
              icon: const Icon(Iconsax.close_circle, size: 32),
            ),
          ),
          kHalfSizedBox,
          Container(
            width: media.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      child: schoolCommuteRouteForm(
                          controller, colorScheme, media),
                    ),
                  ],
                ),
                kSizedBox,
              ],
            ),
          ),
          kSizedBox,
          Obx(
            () {
              return Column(
                children: () {
                  if (controller.mapSuggestionIsSelected.isTrue) {
                    return <Widget>[
                      AndroidElevatedButton(
                        title: "Done",
                        onPressed: controller.submitRouteForm,
                      )
                    ];
                  } else if (controller.isPickupLocationTextFieldActive.value) {
                    return <Widget>[
                      schoolCommutePickupLocationMapSuggestions(
                        colorScheme,
                        controller,
                        media,
                      ),
                    ];
                  } else if (controller.isDestinationTextFieldActive.value) {
                    return <Widget>[
                      schoolCommuteDestinationMapSuggestions(
                        colorScheme,
                        controller,
                        media,
                      )
                    ];
                  } else if (controller.isStopLocationTextFieldActive.value) {
                    return <Widget>[
                      schoolCommuteStopLocationMapSuggestions(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
