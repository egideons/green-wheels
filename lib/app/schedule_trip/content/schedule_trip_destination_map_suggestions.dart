import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../theme/colors.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';

scheduleTripDestinationMapSuggestions(
  ColorScheme colorScheme,
  ScheduleTripController controller,
  Size media,
) {
  return ListView.separated(
    itemCount: 20,
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    separatorBuilder: (context, index) => kSmallSizedBox,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: controller.selectDestinationSuggestion,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 50,
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
                  controller.destination.value,
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 16,
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
