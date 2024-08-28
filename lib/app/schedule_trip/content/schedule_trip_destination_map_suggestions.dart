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
                size: 32,
              ),
              kSmallWidthSizedBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: media.width - 100,
                    child: Text(
                      "Destination: Holy Family Catholic Church",
                      style: defaultTextStyle(
                        color: kTextBlackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  kSmallSizedBox,
                  Text(
                    "22 Road, Festac Town",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
