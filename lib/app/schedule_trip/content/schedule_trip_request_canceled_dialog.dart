import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/constants/consts.dart';
import '../../../src/controllers/app/schedule_trip_controller.dart';

class ScheduleTripRequestCanceledDialog
    extends GetView<ScheduleTripController> {
  const ScheduleTripRequestCanceledDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    Timer(const Duration(milliseconds: 1000), () async {
      Get.close(3);
    });

    return Container(
      width: media.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(Assets.cancelWavyIconSvg),
          kHalfSizedBox,
          Text(
            "Request canceled!",
            maxLines: 10,
            textAlign: TextAlign.center,
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          kSizedBox,
        ],
      ),
    );
  }
}
