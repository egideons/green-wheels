import 'package:flutter/material.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../src/utils/components/car_name_and_rating.dart';
import '../../../../../src/utils/components/rent_ride_amount_charge.dart';
import '../../../../../src/utils/components/time_and_date_section.dart';
import '../../../../../theme/colors.dart';
import 'car_rental_container.dart';

completedCarRentalContainer(
  ColorScheme colorScheme,
  Size media, {
  String? vehicleImage,
  String? vehicleName,
  int? numOfStars,
  String? vehiclePlateNumber,
  int? amount,
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
            numOfStars: numOfStars ?? 5,
            vehicleImage: vehicleImage ?? "",
            vehicleName: vehicleName ?? "",
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
                  vehiclePlateNumber ?? "",
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          kSizedBox,
          timeAndDateSection(colorScheme),
          kSizedBox,
          rentRideAmountCharge(rideAmount: amount ?? 0),
        ],
      ),
    ),
  );
}
