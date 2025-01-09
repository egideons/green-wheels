import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../src/utils/components/car_name_and_rating.dart';
import '../../../../../src/utils/components/rent_ride_amount_charge.dart';
import '../../../../../src/utils/components/time_and_date_section.dart';
import 'car_rental_container.dart';

completedCarRentalContainer(
  ColorScheme colorScheme,
  Size media, {
  String? vehicleImage,
  String? vehicleName,
  // int? numOfStars,
  String? vehiclePlateNumber,
  int? amount,
  int? totalAmount,
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
            vehiclePlateNumber: vehiclePlateNumber,
            vehicleImage: vehicleImage ?? "",
            vehicleName: vehicleName ?? "",
          ),
          kSizedBox,
          timeAndDateSection(colorScheme),
          kSizedBox,
          rentRideAmountCharge(rideAmount: amount ?? 0),
          kHalfSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
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
                        text: intFormattedText(totalAmount ?? 0),
                        style: defaultTextStyle(
                          color: kTextBlackColor,
                          fontSize: 18,
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
  );
}
