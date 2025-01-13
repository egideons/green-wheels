import 'package:flutter/material.dart';
import 'package:green_wheels/src/controllers/app/schedule_trip_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../theme/colors.dart';

scheduleTripPickupLocationMapSuggestions(
  ColorScheme colorScheme,
  ScheduleTripController controller,
  Size media,
) {
  return ListView.separated(
    itemCount: controller.pickupPlacePredictions.length,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    separatorBuilder: (context, index) => kSmallSizedBox,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          controller.selectPickupSuggestion(index);
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                width: 1,
                color: colorScheme.inversePrimary,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.location,
                color: colorScheme.primary,
                size: 20,
              ),
              kSmallWidthSizedBox,
              Expanded(
                child: Text(
                  controller.pickupPlacePredictions[index].description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
