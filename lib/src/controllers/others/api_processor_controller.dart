// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:green_wheels/src/constants/consts.dart';

import '../../../theme/colors.dart';

class ApiProcessorController extends GetxController {
  static void normalSnack(String? msg, {Duration? duration}) {
    var colorScheme = Theme.of(Get.context!).colorScheme;
    var media = MediaQuery.of(Get.context!).size;
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(
          Icons.info,
          size: 16,
          color: kInformationColor,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: colorScheme.surface,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        duration: duration ?? const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: colorScheme.inversePrimary.withValues(),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withValues(),],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   color: kLightBackgroundColor,
        //   icon: const Icon(
        //     Icons.cancel,
        //     size: 14,
        //   ),
        // ),
      ),
    );
  }

  static void successSnack(String? msg) {
    var colorScheme = Theme.of(Get.context!).colorScheme;
    var media = MediaQuery.of(Get.context!).size;
    Get.showSnackbar(
      GetSnackBar(
        // titleText: SizedBox(
        //   width: Get.width,
        //   child: Text(
        //     "",
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //     style: defaultTextStyle(
        //       color: kLightBackgroundColor,
        //       fontSize: 14.0,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
          style: defaultTextStyle(
            color: kSuccessColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(
          Icons.check_circle,
          size: 16,
          color: kSuccessColor,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        backgroundColor: colorScheme.surface,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        duration: const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: colorScheme.inversePrimary.withValues(),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withValues(),],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   color: kLightBackgroundColor,
        //   icon: const Icon(
        //     Icons.cancel,
        //     size: 14,
        //   ),
        // ),
      ),
    );
  }

  static void errorSnack(String? msg) {
    var colorScheme = Theme.of(Get.context!).colorScheme;
    var media = MediaQuery.of(Get.context!).size;

    Get.showSnackbar(
      GetSnackBar(
        // titleText: SizedBox(
        //   width: Get.width,
        //   child: Text(
        //     msg,
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //     style: defaultTextStyle(
        //       color: kLightBackgroundColor,
        //       fontSize: 14.0,
        //       fontWeight: FontWeight.w500,
        //       letterSpacing: -0.40,
        //     ),
        //   ),
        // ),
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: defaultTextStyle(
            color: kErrorColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.40,
          ),
        ),
        icon: const Icon(
          Icons.error_rounded,
          size: 18,
          color: kErrorColor,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        backgroundColor: colorScheme.surface,
        duration: const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: colorScheme.inversePrimary.withValues(),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withValues(),],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.cancel,
        //     size: 14,
        //     color: kErrorColor,
        //   ),
        // ),
      ),
    );
  }

  static void warningSnack(String? msg) {
    var colorScheme = Theme.of(Get.context!).colorScheme;
    var media = MediaQuery.of(Get.context!).size;

    Get.showSnackbar(
      GetSnackBar(
        // titleText: SizedBox(
        //   width: Get.width,
        //   child: Text(
        //     msg,
        //     overflow: TextOverflow.ellipsis,
        //     maxLines: 4,
        //     style: defaultTextStyle(
        //       color: kLightBackgroundColor,
        //       fontSize: 14.0,
        //       fontWeight: FontWeight.w500,
        //       letterSpacing: -0.40,
        //     ),
        //   ),
        // ),
        messageText: Text(
          msg ?? "",
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: defaultTextStyle(
            color: kWarningColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.40,
          ),
        ),
        icon: const Icon(
          Icons.warning_rounded,
          size: 18,
          color: kWarningColor,
        ),
        shouldIconPulse: true,
        isDismissible: true,
        barBlur: 2.0,
        borderRadius: 10,
        snackPosition: SnackPosition.TOP,
        maxWidth: media.width - 40,
        backgroundColor: colorScheme.surface,
        duration: const Duration(seconds: 2),
        boxShadows: [
          BoxShadow(
            color: colorScheme.inversePrimary.withValues(),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        // backgroundGradient: LinearGradient(
        //   colors: [kSuccessColor, kSuccessColor.withValues(),],
        // ),
        // margin: const EdgeInsets.all(60),
        // mainButton: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.cancel,
        //     size: 14,
        //     color: kWarningColor,
        //   ),
        // ),
      ),
    );
  }
}
