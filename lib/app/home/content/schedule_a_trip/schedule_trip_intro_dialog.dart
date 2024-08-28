import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../theme/colors.dart';

class ScheduleTripIntroDialog extends GetView<HomeScreenController> {
  const ScheduleTripIntroDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: media.width,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Get.close(0);
                },
                icon: const Icon(Iconsax.close_circle, size: 32)),
          ),
          SvgPicture.asset(
            Assets.carCalendarOutlineIconSvg,
            height: 50,
          ),
          kBigSizedBox,
          Column(
            children: List.generate(
              controller.scheduleTripIntroInfo.length,
              (index) {
                final infoTab = controller.scheduleTripIntroInfo[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        infoTab["icon"]!,
                      ),
                      kHalfWidthSizedBox,
                      Expanded(
                        child: Text(
                          infoTab["label"]!,
                          maxLines: 2,
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          kBigSizedBox,
          kBigSizedBox,
          SizedBox(
            width: media.width - 200,
            child: AndroidElevatedButton(
              title: "Proceed",
              onPressed: controller.goToScheduleTripScreen,
            ),
          ),
          SizedBox(height: media.height * .05),
        ],
      ),
    );
  }
}
