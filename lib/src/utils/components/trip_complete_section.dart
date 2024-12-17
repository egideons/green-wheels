import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import '../../controllers/others/url_launcher_controller.dart';
import 'chat_and_call_section.dart';

tripCompleteSection(ColorScheme colorScheme) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Trip completed",
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
      ),
      const Spacer(),
      chatAndCallSection(
        colorScheme,
        chatFunc: () {
          UrlLaunchController.sendSms("+2347034922494");
        },
        callFunc: () {
          UrlLaunchController.makePhoneCall("+2347034922494");
        },
      ),
    ],
  );
}
