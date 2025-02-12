import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/amount_charge_section.dart';
import 'package:green_wheels/src/utils/components/payment_type_section.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/components/default_info_container.dart';
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
      child: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              defaultInfoContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    amountChargeSection(
                      colorScheme,
                      amount: controller.instantRideData.value.amount,
                    ),
                    kSizedBox,
                    // estimatedTravelTime(
                    //   colorScheme,
                    //   estimatedTime: controller.totalInstantRideTime.value,
                    // ),
                    // kSizedBox,
                    paymentTypeSection(
                      paymentType: controller.paymentType.value,
                    ),
                  ],
                ),
              ),
              kSizedBox,

              // Obx(() {
              //   return Container(
              //     decoration: ShapeDecoration(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //         side: const BorderSide(
              //           color: kFrameBackgroundColor,
              //         ),
              //       ),
              //     ),
              //     child: LinearProgressIndicator(
              //       value: controller.progress.value,
              //       minHeight: 10,
              //       borderRadius: BorderRadius.circular(8),
              //       backgroundColor: kFrameBackgroundColor,
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         colorScheme.primary,
              //       ),
              //     ),
              //   );
              // }),
              // kHalfSizedBox,
              controller.bookDriverFound.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Driver found",
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kSmallWidthSizedBox,
                        Icon(Icons.check_circle, color: kSuccessColor)
                      ],
                    )
                  : controller.bookDriverTimerFinished.value
                      ? SizedBox()
                      : Text(
                          "Searching for a Driver",
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
              kSmallSizedBox,
              controller.bookDriverFound.value
                  ? SizedBox()
                  : controller.bookDriverTimerFinished.value
                      ? SizedBox()
                      : Center(
                          child: CupertinoActivityIndicator(),
                        ),
              kSizedBox,
              controller.bookDriverFound.value
                  ? SizedBox()
                  : controller.bookDriverTimerFinished.value
                      ? AndroidElevatedButton(
                          title: "Retry",
                          onPressed: controller.retryBookInstantRide,
                        )
                      : SizedBox(),

              controller.bookDriverFound.value
                  ? AndroidElevatedButton(
                      title: "Continue",
                      onPressed: controller.showBookRideRequestAcceptedModal,
                    )
                  : SizedBox(),
              kSizedBox,
              AndroidOutlinedButton(
                title: "Cancel request",
                onPressed: controller.cancelBookRideDriverRequest,
              ),
              kSizedBox,
            ],
          ),
        );
      }),
    );
  }
}
