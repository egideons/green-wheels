import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/phone_otp/screen/phone_otp.dart';
import 'package:green_wheels/src/constants/consts.dart';

import '../others/api_processor_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance {
    return Get.find<LoginController>();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final phoneNumberEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final phoneNumberFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var isPhoneNumberValid = false.obs;
  var responseStatus = 0.obs;
  var responseMessage = "".obs;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      var phoneNumberRegExp = RegExp(mobilePattern);

      if (phoneNumberEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your phone number");
        return;
      } else if (!phoneNumberRegExp.hasMatch(phoneNumberEC.text)) {
        ApiProcessorController.errorSnack("Please enter a valid phone number");
        return;
      }

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 3));

      await Get.to(
        () => PhoneOTP(userPhoneNumber: phoneNumberEC.text),
        routeName: "/phone-otp",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        preventDuplicates: true,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    }
    isLoading.value = false;
    update();
  }

  //=========== Signup ===========\\
  onSubmitted(value) {
    login();
  }

  //=========== onChanged Functions ===========\\
}
