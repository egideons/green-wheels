import 'package:flutter/material.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/utils/buttons/android/android_elevated_button.dart';
import '../../../../src/utils/components/default_info_container.dart';
import '../../../../theme/colors.dart';

availableCarContainer({
  String? vehicleName,
  String? vehicleImage,
  String? vehicleGearType,
  int? numOfSeats,
  String? vehicleFuelType,
  void Function()? goToAvailableVehicleDetails,
}) {
  return defaultInfoContainer(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vehicleName ?? "",
                    textAlign: TextAlign.start,
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: vehicleGearType ?? "",
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: ' | ',
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: numOfSeats == 1
                              ? "${intFormattedText(numOfSeats ?? 0)} Seat"
                              : "${intFormattedText(numOfSeats ?? 0)} Seats",
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' | ',
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    vehicleFuelType ?? "",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(vehicleImage ?? "", height: 66),
          ],
        ),
        kSizedBox,
        AndroidElevatedButton(
          title: "View car details",
          onPressed: goToAvailableVehicleDetails ?? () {},
        ),
        kSmallSizedBox,
      ],
    ),
  );
}
