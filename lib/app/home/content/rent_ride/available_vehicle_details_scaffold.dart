import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/models/rent_ride_vehicle_model.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/buttons/android/android_outlined_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';

class AvailableVehicleDetailsScaffold extends GetView<HomeScreenController> {
  const AvailableVehicleDetailsScaffold({required this.vehicle, super.key});

  final RentRideVehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: myAppBar(
        colorScheme,
        media,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Text(
                vehicle.vehicleName,
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kHalfSizedBox,
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: kStarColor),
                  Text(
                    vehicle.numOfReviews == 1
                        ? "${vehicle.rating} (${intFormattedText(vehicle.numOfReviews)} Review)"
                        : "${vehicle.rating} (${intFormattedText(vehicle.numOfReviews)} Reviews)",
                    style: defaultTextStyle(
                      color: kDisabledTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              FadeInRight(
                child: Image.asset(
                  vehicle.vehicleImage,
                  filterQuality: FilterQuality.high,
                  scale: .4,
                ),
              ),
              kSizedBox,
              Text(
                "Specifications",
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kSmallSizedBox,
              Row(
                children: List.generate(
                  3,
                  (index) {
                    var specificationsInfo =
                        controller.vehicleSpecificationsInfo(vehicle)[index];
                    return FadeInRight(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                width: .8,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(specificationsInfo["icon"]),
                              kSmallSizedBox,
                              Text(
                                specificationsInfo["title"],
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                specificationsInfo["subtitle"],
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              kSizedBox,
              Text(
                "Car features",
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kSmallSizedBox,
              Column(
                children: List.generate(
                  controller.vehicleFeaturesInfo(vehicle).length,
                  (index) {
                    var featuresInfo =
                        controller.vehicleFeaturesInfo(vehicle)[index];
                    return FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                width: .8,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                featuresInfo["title"],
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                featuresInfo["subtitle"],
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              kSizedBox,
              Row(
                children: [
                  Expanded(
                    child: AndroidOutlinedButton(
                      title: "Cancel",
                      borderWidth: 2,
                      borderColor: colorScheme.primary,
                      onPressed: controller.cancelSelectAvailableRide,
                    ),
                  ),
                  kHalfWidthSizedBox,
                  Expanded(
                    child: AndroidElevatedButton(
                      title: "Select car",
                      onPressed: () {
                        controller.selectAvailableRide(vehicle);
                      },
                    ),
                  ),
                ],
              ),
              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
