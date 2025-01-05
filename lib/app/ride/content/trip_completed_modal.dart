import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/default_info_container.dart';
import 'package:green_wheels/src/utils/components/drag_handle.dart';
import 'package:green_wheels/src/utils/components/estimated_travel_time.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/ride_controller.dart';
import '../../../src/utils/components/amount_charge_section.dart';
import '../../../src/utils/components/driver_avatar_name_and_rating.dart';
import '../../../src/utils/components/payment_type_section.dart';
import '../../../src/utils/components/ride_address_section.dart';
import '../../../theme/colors.dart';

class TripCompletedModal extends GetView<RideController> {
  const TripCompletedModal({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: dragHandle(media),
            ),
            Text(
              "Trip completed",
              textAlign: TextAlign.start,
              style: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            kSizedBox,
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
                    driverName: "John Kennedy",
                    numOfStars: 4,
                    isUserVerified: true,
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
                  Row(
                    children: [
                      Text(
                        "Plate number",
                        style: defaultTextStyle(
                          color: kTextBlackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kWidthSizedBox,
                      Expanded(
                        child: Text(
                          "ABJ23 456",
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            kSizedBox,
            defaultInfoContainer(
              child: rideAddressSection(
                colorScheme,
                pickup: controller.pickupLocation,
                destination: controller.destination,
              ),
            ),
            kSizedBox,
            defaultInfoContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  amountChargeSection(
                    colorScheme,
                    amount: controller.rideAmount,
                  ),
                  kSizedBox,
                  estimatedTravelTime(
                    colorScheme,
                    estimatedTime: controller.rideTime,
                  ),
                  kSizedBox,
                  paymentTypeSection(),
                ],
              ),
            ),
            kSizedBox,
            kSizedBox,
            AndroidElevatedButton(
              title: "Rate Ride",
              onPressed: controller.giveFeedback,
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
