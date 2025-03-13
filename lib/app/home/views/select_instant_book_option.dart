import 'package:flutter/material.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';
import 'package:green_wheels/theme/colors.dart';

selectInstantBookOption(Size media, HomeScreenController controller) {
  return Align(
    alignment: Alignment.topCenter,
    child: SizedBox(
      width: media.width,
      child: Row(
        children: [
          InkWell(
            onTap: controller.goToPersonalRide,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 120,
              width: media.width / 2.5,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kFrameBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 4), // Elevation effect
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Just me",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          kWidthSizedBox,
          InkWell(
            onTap: controller.goToSharedRide,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 120,
              width: media.width / 2.5,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kFrameBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: Offset(0, 4), // Elevation effect
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outlined,
                    color: kPrimaryColor,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Shared Ride",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
