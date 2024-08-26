import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/amount_charge_section.dart';
import 'package:green_wheels/src/utils/components/payment_type_section.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/components/default_info_container.dart';
import '../../../../src/utils/components/estimated_travel_time.dart';
import '../../../src/constants/consts.dart';
import '../../../src/utils/buttons/android/android_outlined_button.dart';

class BookRideSearchingForDriverModal extends GetView<HomeScreenController> {
  const BookRideSearchingForDriverModal({super.key});

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
            Obx(() {
              return Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: kFrameBackgroundColor,
                    ),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: controller.progress.value,
                  minHeight: 10,
                  backgroundColor: kFrameBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              );
            }),
            kHalfSizedBox,
            Obx(() {
              return controller.bookDriverFound.value
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
                    );
            }),
            kSizedBox,
            Obx(
              () {
                return controller.bookDriverTimerFinished.value &&
                        controller.bookDriverFound.value
                    ? AndroidElevatedButton(
                        title: "Continue",
                        onPressed: controller.showBookRideRequestAcceptedModal,
                      )
                    : AndroidElevatedButton(
                        title: "Retry",
                        onPressed:
                            controller.simulateBookRideDriverSearchProgress,
                      );
              },
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
