import 'package:flutter/material.dart';
import 'package:green_wheels/src/utils/components/amount_charge_section.dart';

import '../../../../../../../src/constants/consts.dart';
import '../../../../../../../src/utils/components/ride_address_section.dart';
import '../../../../../../../src/utils/components/time_and_date_section.dart';
import '../../../../../../../theme/colors.dart';

pendingScheduledRideContainer(
  ColorScheme colorScheme,
  Size media, {
  String? driverName,
  String? vehicleName,
  String? pickup,
  double? amount,
  String? destination,
  void Function()? viewPendingScheduledRide,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        driverName ?? "",
        textAlign: TextAlign.start,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      kHalfSizedBox,
      Text(
        vehicleName ?? "",
        textAlign: TextAlign.start,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 12.8,
          fontWeight: FontWeight.w500,
        ),
      ),
      kHalfSizedBox,
      amountChargeSection(
        colorScheme,
        amount: amount ?? 0,
        fontSize: 14,
        isSpaceBetween: false,
      ),
      kHalfSizedBox,
      timeAndDateSection(colorScheme),
      kSizedBox,
      rideAddressSection(
        colorScheme,
        pickup: pickup ?? "",
        destination: destination ?? "",
      ),
      // kSizedBox,
      // SizedBox(
      //   width: media.width / 2.8,
      //   child: AndroidElevatedButton(
      //     title: "View",
      //     isRowVisible: true,
      //     buttonIcon: Icons.chevron_right_rounded,
      //     buttonIconSize: 24,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     onPressed: viewPendingScheduledRide ?? () {},
      //   ),
      // ),
    ],
  );
}
