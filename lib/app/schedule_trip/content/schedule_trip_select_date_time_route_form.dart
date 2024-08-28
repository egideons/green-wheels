import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../src/constants/assets.dart';
import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';
import '../../../src/utils/textformfields/android/android_textformfield.dart';

scheduleTripSelectDateTimeRouteForm(
  OutlineInputBorder defaultTextFieldBorderStyle,
  ScheduleTripController controller,
) {
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
              child: AndroidTextFormField(
                hintText: "Select Time",
                onTap: controller.selectTimeFunc,
                readOnly: true,
                controller: controller.selectedTimeEC,
                textInputAction: TextInputAction.next,
                focusNode: controller.selectedTimeFN,
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
            SvgPicture.asset(Assets.routeIconSvg),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                hintText: "Select Route",
                readOnly: true,
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
