import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/buttons/android/android_outlined_button.dart';
import 'package:green_wheels/src/utils/components/time_and_date_section.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/utils/components/chat_and_call_section.dart';
import '../../../../src/utils/components/ride_address_section.dart';
import '../../../../theme/colors.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';
import '../../../src/controllers/others/url_launcher_controller.dart';
import '../../../src/utils/components/amount_charge_section.dart';
import '../../../src/utils/components/default_info_container.dart';
import '../../../src/utils/components/driver_avatar_name_and_rating.dart';

class ScheduleTripRideRequestAcceptedModal
    extends GetView<ScheduleTripController> {
  const ScheduleTripRideRequestAcceptedModal({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: media.width,
      padding: const EdgeInsets.only(top: 20),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  "Request accepted!",
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                chatAndCallSection(
                  colorScheme,
                  chatFunc: () {
                    UrlLaunchController.sendSms("+2347034922494");
                  },
                  callFunc: () {
                    UrlLaunchController.makePhoneCall("+2347034922494");
                  },
                ),
              ],
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
            kBigSizedBox,
            defaultInfoContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timeAndDateSection(
                    colorScheme,
                    date: controller.selectedDateEC.text,
                    time: controller.selectedTimeEC.text,
                  ),
                  kSizedBox,
                  rideAddressSection(
                    colorScheme,
                    pickup: controller.pickupLocationEC.text,
                    destination: controller.destinationEC.text,
                  ),
                  kSizedBox,
                  amountChargeSection(
                    colorScheme,
                    amount: controller.rideAmount.value,
                  ),
                ],
              ),
            ),
            kSizedBox,
            AndroidElevatedButton(
              title: "Done",
              onPressed: controller.goToHomeScreen,
            ),
            kSizedBox,
            AndroidOutlinedButton(
              title: "Cancel Request",
              onPressed: controller.showScheduleTripCancelRequestModal,
            ),
            kBigSizedBox,
            kBigSizedBox,
          ],
        ),
      ),
    );
  }
}
