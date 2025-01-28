import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/assets.dart';
import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/components/default_info_container.dart';
import '../../../src/utils/textformfields/android/android_textformfield.dart';

rentRideTabBarView(
  Size media,
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  var defaultTextFieldBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  return Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultInfoContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: controller.rentRideFormKey,
            child: Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.calendarOutlineIconSvg),
                    kHalfWidthSizedBox,
                    Expanded(
                      child: AndroidTextFormField(
                        onTap: controller.selectRentRideDate,
                        readOnly: true,
                        enabled: true,
                        hintText: "Select Date",
                        controller: controller.rentRideDateEC,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.rentRideDateFN,
                        textCapitalization: TextCapitalization.none,
                        filled: true,
                        inputBorder: defaultTextFieldBorderStyle,
                        focusedBorder: defaultTextFieldBorderStyle,
                        enabledBorder: defaultTextFieldBorderStyle,
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                kSizedBox,
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.clockIconSvg),
                    kHalfWidthSizedBox,
                    Expanded(
                      child: AndroidTextFormField(
                        hintText: "Select Time",
                        onTap: controller.selectRentRidePickupTime,
                        readOnly: true,
                        enabled: true,
                        controller: controller.rentRidePickupTimeEC,
                        textInputAction: TextInputAction.next,
                        focusNode: controller.rentRidePickupTimeFN,
                        textCapitalization: TextCapitalization.none,
                        filled: true,
                        inputBorder: defaultTextFieldBorderStyle,
                        focusedBorder: defaultTextFieldBorderStyle,
                        enabledBorder: defaultTextFieldBorderStyle,
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                controller.chooseAvailableVehicleTextFieldIsVisible.value
                    ? Column(
                        children: [
                          kSizedBox,
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Assets.carFrontViewOutlineSvg),
                              kHalfWidthSizedBox,
                              Expanded(
                                child: AndroidTextFormField(
                                  hintText: controller
                                          .isLoadingAvailableVehicles.value
                                      ? "Loading Vehicles.."
                                      : "Choose your vehicle",
                                  onTap: controller.chooseAvailableVehicle,
                                  readOnly: true,
                                  enabled: true,
                                  controller:
                                      controller.chooseAvailableVehicleEC,
                                  textInputAction: TextInputAction.next,
                                  focusNode:
                                      controller.chooseAvailableVehicleFN,
                                  textCapitalization: TextCapitalization.none,
                                  filled: true,
                                  inputBorder: defaultTextFieldBorderStyle,
                                  focusedBorder: defaultTextFieldBorderStyle,
                                  enabledBorder: defaultTextFieldBorderStyle,
                                  suffixIcon: const Icon(
                                    Icons.chevron_right,
                                    color: kBlackColor,
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          kSizedBox,
                          if (controller.selectedVehicleName.value.isNotEmpty)
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                      shape: const CircleBorder(),
                                      color: colorScheme.primary),
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    color: colorScheme.secondary,
                                    size: 16,
                                  ),
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: AndroidTextFormField(
                                    readOnly: true,
                                    onTap: controller
                                        .setRentRidePickupGoogleMapsLocation,
                                    controller:
                                        controller.rentRidePickupLocationEC,
                                    hintText: "Enter your pickup location",
                                    textInputAction: TextInputAction.next,
                                    focusNode:
                                        controller.rentRidePickupLocationFN,
                                    textCapitalization: TextCapitalization.none,
                                    filled: true,
                                    inputBorder: defaultTextFieldBorderStyle,
                                    focusedBorder: defaultTextFieldBorderStyle,
                                    enabledBorder: defaultTextFieldBorderStyle,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        kHalfSizedBox,
        if (controller.selectedVehicleName.value.isNotEmpty)
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
        kSizedBox,
        AndroidElevatedButton(
          title: "Confirm booking",
          disable: controller.confirmRentRideBookingButtonIsEnabled.isFalse,
          isLoading: controller.confirmRentRideBookingButtonIsLoading.value,
          onPressed: controller.confirmRentRideBooking,
        ),
        if (controller.selectedVehicleName.value.isNotEmpty)
          SizedBox(height: media.height * .6)
      ],
    );
  });
}
