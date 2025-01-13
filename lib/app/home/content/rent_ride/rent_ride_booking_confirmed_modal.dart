import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_outlined_button.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/buttons/android/android_elevated_button.dart';
import '../../../../src/utils/components/car_name_and_rating.dart';
import '../../../../src/utils/components/default_info_container.dart';
import '../../../../src/utils/components/time_and_date_section.dart';
import '../../../../theme/colors.dart';

class RentRideBookingConfirmedModal extends GetView<HomeScreenController> {
  const RentRideBookingConfirmedModal({super.key});

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
            Text(
              "Booking confirmed!",
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
                    "Car information",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  carNameRating(
                    colorScheme,
                    vehicleImage: controller.selectedVehicleImage.value,
                    // vehicleImage: controller.selectedVehicleImage.value,
                    vehicleName: controller.selectedVehicleName.value,
                    // numOfStars: controller.selectedVehicleNumOfStars.value,
                    isUserVerified: true,
                  ),
                  kSizedBox,
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
                          controller.selectedVehiclePlateNumber.value,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timeAndDateSection(
                    colorScheme,
                    date: controller.rentRideDateEC.text,
                    time: controller.rentRidePickupTimeEC.text,
                  ),
                  kSizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount Charge\n(per minute)",
                        style: defaultTextStyle(
                          color: kTextBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Text.rich(
                          textAlign: TextAlign.end,
                          TextSpan(
                            text: '$nairaSign ',
                            style: defaultTextStyle(
                              color: kTextBlackColor,
                              fontSize: 16,
                              fontFamily: "",
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: convertToCurrency(
                                  controller.rentRideChargePerMinute.value,
                                ),
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            kSizedBox,
            AndroidElevatedButton(
              title: "Done",
              onPressed: controller.doneRentingRide,
            ),
            kSizedBox,
            AndroidOutlinedButton(
              title: "Cancel booking",
              onPressed: controller.cancelRentRideBooking,
            ),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
