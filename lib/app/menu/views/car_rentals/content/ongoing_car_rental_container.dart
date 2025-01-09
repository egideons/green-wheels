import 'package:flutter/material.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../src/utils/components/car_name_and_rating.dart';
import '../../../../../src/utils/components/rent_ride_amount_charge.dart';
import '../../../../../src/utils/components/time_and_date_section.dart';
import 'car_rental_container.dart';

ongoingCarRentalContainer(
  ColorScheme colorScheme,
  Size media, {
  String? vehicleImage,
  String? vehicleName,
  int? numOfStars,
  String? vehiclePlateNumber,
  int? amount,
  void Function()? view,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: carRentalContainer(
      colorScheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          carNameRating(
            colorScheme,
            vehicleImage: vehicleImage ?? "",
            vehicleName: vehicleName ?? "",
            vehiclePlateNumber: vehiclePlateNumber ?? "",
          ),

          kSizedBox,
          timeAndDateSection(colorScheme),
          kSizedBox,
          rentRideAmountCharge(rideAmount: amount ?? 0),
          // kSizedBox,
          // SizedBox(
          //   width: media.width / 2.8,
          //   child: AndroidElevatedButton(
          //     title: "View",
          //     isRowVisible: true,
          //     buttonIcon: Icons.chevron_right_rounded,
          //     buttonIconSize: 24,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     onPressed: view ?? () {},
          //   ),
          // ),
        ],
      ),
    ),
  );
}
