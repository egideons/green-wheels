import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/drag_handle.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/ride_controller.dart';
import '../../../src/utils/components/default_info_container.dart';
import '../../../src/utils/components/driver_avatar_name_and_rating.dart';
import '../../../theme/colors.dart';

ridePanelSection(
  ColorScheme colorScheme,
  Size media,
  BuildContext context,
  RideController controller,
) {
  return GetBuilder<RideController>(
    init: RideController(),
    builder: (controller) {
      return Container(
        decoration: ShapeDecoration(
          color: colorScheme.surface,
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
            dragHandle(media),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      controller.rideInfo.value,
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
                  defaultInfoContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Driver information",
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        driverAvatarNameRating(
                          colorScheme,
                          driverName: controller.driverName,
                          numOfStars: controller.driverRating,
                        ),
                        kSizedBox,
                        Row(
                          children: [
                            Text(
                              "Vehicle Type",
                              style: defaultTextStyle(
                                color: kTextBlackColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            kWidthSizedBox,
                            Expanded(
                              child: Text(
                                "Esse Green wheels",
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        kHalfSizedBox,
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Plate number",
                        //       style: defaultTextStyle(
                        //         color: kTextBlackColor,
                        //         fontSize: 13,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //     kWidthSizedBox,
                        //     Expanded(
                        //       child: Text(
                        //         "ABJ23 456",
                        //         style: defaultTextStyle(
                        //           color: kTextBlackColor,
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  kSizedBox,
                  Obx(
                    () {
                      if (!controller.rideComplete.value) {
                        if (controller.routeIsVisible.value) {
                          return AndroidElevatedButton(
                            title: "Hide Route",
                            onPressed: controller.hideRoute,
                          );
                        } else {
                          return AndroidElevatedButton(
                            title: "Show Route",
                            onPressed: controller.showRoute,
                          );
                        }
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
