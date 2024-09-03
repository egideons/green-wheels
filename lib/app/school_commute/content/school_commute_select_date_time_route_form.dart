import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_wheels/src/controllers/app/school_commute_controller.dart';

import '../../../src/constants/assets.dart';
import '../../../src/constants/consts.dart';
import '../../../src/utils/textformfields/android/android_textformfield.dart';

schoolCommuteSelectDateTimeRouteForm(
  OutlineInputBorder defaultTextFieldBorderStyle,
  SchoolCommuteController controller, {
  bool? isEnabled,
}) {
  return Form(
    key: controller.scheduleTripFormKey,
    child: Column(
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.calendarOutlineIconSvg),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                onTap: controller.selectDateFunc,
                readOnly: true,
                enabled: isEnabled ?? true,
                hintText: "Select Date",
                controller: controller.selectedDateEC,
                textInputAction: TextInputAction.next,
                focusNode: controller.selectedDateFN,
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
              child: Column(
                children: [
                  AndroidTextFormField(
                    hintText: "Select Pickup Time",
                    onTap: controller.selectPickupTimeFunc,
                    readOnly: true,
                    enabled: isEnabled ?? true,
                    controller: controller.selectedPickupTimeEC,
                    textInputAction: TextInputAction.next,
                    focusNode: controller.selectedPickupTimeFN,
                    textCapitalization: TextCapitalization.none,
                    filled: true,
                    inputBorder: defaultTextFieldBorderStyle,
                    focusedBorder: defaultTextFieldBorderStyle,
                    enabledBorder: defaultTextFieldBorderStyle,
                    validator: (value) {
                      return null;
                    },
                  ),
                  kHalfSizedBox,
                  AndroidTextFormField(
                    hintText: "Select Drop-off Time",
                    onTap: controller.selectDropOffTimeFunc,
                    readOnly: true,
                    enabled: isEnabled ?? true,
                    controller: controller.selectedDropOffTimeEC,
                    textInputAction: TextInputAction.next,
                    focusNode: controller.selectedDropOffTimeFN,
                    textCapitalization: TextCapitalization.none,
                    filled: true,
                    inputBorder: defaultTextFieldBorderStyle,
                    focusedBorder: defaultTextFieldBorderStyle,
                    enabledBorder: defaultTextFieldBorderStyle,
                    validator: (value) {
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        kSizedBox,
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.routeIconSvg),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                hintText: "Select Route",
                readOnly: true,
                enabled: isEnabled ?? true,
                onTap: controller.showSelectRouteModal,
                controller: controller.selectedRouteEC,
                textInputAction: TextInputAction.next,
                focusNode: controller.selectedRouteFN,
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
    ),
  );
}
