import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/others/url_launcher_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_outlined_button.dart';
import 'package:green_wheels/src/utils/components/chat_and_call_section.dart';
import 'package:green_wheels/src/utils/components/drag_handle.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/components/ride_address_section.dart';
import '../../../../theme/colors.dart';
import '../../../src/utils/components/amount_charge_section.dart';
import '../../../src/utils/components/default_info_container.dart';
import '../../../src/utils/components/driver_avatar_name_and_rating.dart';
import '../../../src/utils/components/estimated_travel_time.dart';
import '../../../src/utils/components/payment_type_section.dart';

class BookRideRequestAcceptedPanel extends GetView<HomeScreenController> {
  const BookRideRequestAcceptedPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

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
      child: Obx(() {
        return Column(
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.driverHasArrived.value
                      ? "Driver has arrived!"
                      : "Request accepted!",
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                kSmallWidthSizedBox,
                Icon(Icons.check_circle, color: kSuccessColor)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.driverHasArrived.value
                      ? "Please avoid keeping the driver waiting"
                      : "Driver is on his way",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  style: defaultTextStyle(
                    color: controller.driverHasArrived.value
                        ? colorScheme.error
                        : kSuccessColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // if (!controller.driverHasArrived.value)
                //   Text(
                //     "~ ${controller.driverLocationUpdatesResponse.} ",
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 4,
                //     textAlign: TextAlign.center,
                //     style: defaultTextStyle(
                //       color: colorScheme.primary,
                //       fontSize: 14,
                //       fontWeight: FontWeight.w400,
                //     ),
                //   ),
              ],
            ),
            kSizedBox,
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHalfDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    defaultInfoContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: driverAvatarNameRating(
                                  colorScheme,
                                  driverName: controller.driverName.value,
                                  numOfStars: controller.driverRating.value,
                                ),
                              ),
                              kBigWidthSizedBox,
                              chatAndCallSection(
                                colorScheme,
                                chatToolTip: "Message Driver",
                                callToolTip: "Call Driver",
                                chatFunc: () {
                                  UrlLaunchController.sendSms(
                                    controller.driverPhoneNumber.value,
                                  );
                                },
                                callFunc: () {
                                  UrlLaunchController.makePhoneCall(
                                    controller.driverPhoneNumber.value,
                                  );
                                },
                              ),
                            ],
                          ),
                          kSizedBox,
                          Row(
                            children: [
                              Text(
                                "Vehicle Type",
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              kWidthSizedBox,
                              Expanded(
                                child: Text(
                                  "Esse Green wheels",
                                  style: defaultTextStyle(
                                    color: colorScheme.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          kHalfSizedBox,
                        ],
                      ),
                    ),
                    kSizedBox,
                    defaultInfoContainer(
                      child: rideAddressSection(
                        colorScheme,
                        pickup: controller.pickupLocationEC.text,
                        destination: controller.destinationEC.text,
                      ),
                    ),
                    kSizedBox,
                    defaultInfoContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          amountChargeSection(
                            colorScheme,
                            isSpaceBetween: true,
                            amount: controller.instantRideData.value.amount,
                          ),
                          kSizedBox,
                          estimatedTravelTime(
                            colorScheme,
                            estimatedTime: convertSecondsToAppropriateTime(
                              controller.estimatedInstantRideTime.value,
                            ),
                          ),
                          kSizedBox,
                          paymentTypeSection(
                            paymentType: controller.paymentType.value,
                          ),
                        ],
                      ),
                    ),
                    kSizedBox,
                    AndroidOutlinedButton(
                      title: controller.driverHasArrived.value
                          ? "Cancel ride"
                          : "Cancel request",
                      onPressed: controller.driverHasArrived.value
                          ? controller.showCancellationFeeModal
                          : controller.cancelBookRideDriverRequest,
                    ),
                    SizedBox(height: media.height * .4),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
