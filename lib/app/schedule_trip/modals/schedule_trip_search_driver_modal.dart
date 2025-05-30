import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/utils/components/default_info_container.dart';
import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';
import '../../../src/utils/buttons/android/android_outlined_button.dart';
import '../../../src/utils/components/amount_charge_section.dart';
import '../../../src/utils/components/payment_type_section.dart';
import '../content/schedule_trip_select_date_time_route_form.dart';

class ScheduleTripSearchingForDriverModal
    extends GetView<ScheduleTripController> {
  const ScheduleTripSearchingForDriverModal({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    var defaultTextFieldBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    );

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
      child: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // defaultInfoContainer(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       kSizedBox,
              //       estimatedTravelTime(
              //         colorScheme,
              //         estimatedTime: "${intFormattedText(10)}mins",
              //       ),
              //       kSizedBox,
              //     ],
              //   ),
              // ),
              defaultInfoContainer(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    amountChargeSection(
                      colorScheme,
                      amount: controller.rideAmount.value,
                    ),
                    kSizedBox,
                    scheduleTripSelectDateTimeRouteForm(
                      defaultTextFieldBorderStyle,
                      controller,
                      isEnabled: false,
                    ),
                    kSizedBox,
                    paymentTypeSection(
                      paymentType: controller.paymentType.value,
                    ),
                  ],
                ),
              ),

              kHalfSizedBox,
              controller.scheduleDriverFound.value
                  ? Text(
                      "Driver found!",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      "Searching for a Driver",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              kSmallSizedBox,

              controller.scheduleDriverFound.value
                  ? SizedBox()
                  : controller.scheduleDriverTimerFinished.value
                      ? SizedBox()
                      : Center(
                          child: CupertinoActivityIndicator(),
                        ),

              kSizedBox,
              controller.scheduleDriverFound.value
                  ? SizedBox()
                  : controller.scheduleDriverTimerFinished.value
                      ? AndroidElevatedButton(
                          title: "Retry",
                          onPressed: controller.retryscheduleTrip,
                        )
                      : SizedBox(),

              kSizedBox,
              AndroidOutlinedButton(
                title: "Cancel request",
                onPressed: controller.showScheduleTripCancelRequestModal,
              ),
              kSizedBox,
            ],
          ),
        );
      }),
    );
  }
}
