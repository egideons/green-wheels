import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';
import 'package:green_wheels/src/utils/components/drag_handle.dart';
import 'package:green_wheels/theme/colors.dart';

class SharedRidePanel extends GetView<HomeScreenController> {
  const SharedRidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Obx(() {
      return Container(
        decoration: ShapeDecoration(
          color: colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: media.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 120,
                vertical: 10,
              ),
              child: dragHandle(media),
            ),
            Expanded(
              // Keep only one Expanded here
              child: AnimatedContainer(
                width: media.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Waiting for others to join in ",
                              style: defaultTextStyle(
                                color: kTextBlackColor,
                                fontSize: 12.6,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      controller.sharedRideWaitingFormattedTime,
                                  style: defaultTextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 12.6,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "2 Joined",
                              textAlign: TextAlign.end,
                              style: defaultTextStyle(
                                color: kTextBlackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
