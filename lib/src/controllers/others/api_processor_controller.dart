// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

class ApiProcessorController extends GetxController {
  static Future<dynamic> errorState(data) async {
    try {
      if (data.statusCode == 200) {
        return data.body;
      }
      // errorSnack("Something went wrong");
      return;
    } catch (e) {
      // errorSnack("Check your internet and try again");
      return;
    }
  }

  static void successSnack(msg) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: SizedBox(
          width: Get.width,
          child: Text(
            "SUCCESS",
            overflow: TextOverflow.ellipsis,
            style: defaultTextStyle(
              color: kTextWhiteColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        messageText: SizedBox(
          width: Get.width,
          child: Text(
            msg,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: defaultTextStyle(
              color: kTextWhiteColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        icon: const Icon(
          Icons.check_circle,
          size: 16,
          color: kTextWhiteColor,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: kSuccessColor,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withOpacity(0.6)],
        // ),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
        mainButton: IconButton(
          onPressed: () {
            Get.back();
          },
          color: kTextWhiteColor,
          icon: const Icon(
            Icons.cancel,
            size: 14,
          ),
        ),
      ),
    );
  }

  static void errorSnack(msg) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: SizedBox(
          width: Get.width,
          child: Text(
            "ERROR",
            overflow: TextOverflow.ellipsis,
            style: defaultTextStyle(
              color: kLightBackgroundColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.40,
            ),
          ),
        ),
        messageText: SizedBox(
          width: Get.width,
          child: Text(
            msg,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: defaultTextStyle(
              color: kLightBackgroundColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.40,
            ),
          ),
        ),
        icon: const Icon(
          Icons.error_rounded,
          size: 18,
          color: kLightBackgroundColor,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withOpacity(0.6)],
        // ),
        margin: const EdgeInsets.all(10),
        backgroundColor: kErrorColor,
        duration: const Duration(seconds: 2),
        mainButton: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.cancel,
            size: 14,
            color: kLightBackgroundColor,
          ),
        ),
      ),
    );
  }
}
