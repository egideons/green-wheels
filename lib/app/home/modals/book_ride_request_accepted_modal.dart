import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_outlined_button.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/components/chat_and_call_section.dart';
import '../../../../src/utils/components/ride_address_section.dart';
import '../../../../theme/colors.dart';
import '../../../src/controllers/others/url_launcher_controller.dart';
import '../../../src/utils/components/amount_charge_section.dart';
import '../../../src/utils/components/default_info_container.dart';
import '../../../src/utils/components/driver_avatar_name_and_rating.dart';
import '../../../src/utils/components/estimated_travel_time.dart';
import '../../../src/utils/components/payment_type_section.dart';

class BookRideRequestAcceptedModal extends GetView<HomeScreenController> {
  const BookRideRequestAcceptedModal({super.key});

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request accepted!",
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Driver is on his way",
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                chatAndCallSection(
                  colorScheme,
                  chatFunc: () {
                    UrlLaunchController.sendSms("07039502751");
                  },
                  callFunc: () {
                    UrlLaunchController.makePhoneCall("07039502751");
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
            kSizedBox,
            defaultInfoContainer(
              child: rideAddressSection(
                colorScheme,
                pickup: "Pin Plaza, 1st Avenue",
                destination:
                    "Holy Family Catholic church, 22 road, Festac Town",
              ),
            ),
            kSizedBox,
            defaultInfoContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  amounChargeSection(colorScheme, amount: 2000),
                  kSizedBox,
                  estimatedTravelTime(
                    colorScheme,
                    estimatedTime: "${intFormattedText(10)}mins",
                  ),
                  kSizedBox,
                  paymentTypeSection(colorScheme),
                ],
              ),
            ),
            kSizedBox,
            AndroidOutlinedButton(
              title: "Cancel request",
              onPressed: controller.cancelBookRideDriverRequest,
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
