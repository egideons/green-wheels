import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';

import '../../../app/auth/phone_otp/screen/phone_otp.dart';
import '../../routes/routes.dart';
import '../others/api_processor_controller.dart';
import 'phone_otp_controller.dart';

class PhoneSignupController extends GetxController {
  static PhoneSignupController get instance {
    return Get.find<PhoneSignupController>();
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
  var isChecked = false.obs;
  var responseMessage = "".obs;
  var nigerianDialCode = "+234";

  @override
  void onInit() {
    super.onInit();

    phoneNumberFN.requestFocus();
  }

  //=========== Submit ===========\\
  onSubmitted(value) {
    if (isChecked.value == true) {
      signup();
    }
  }

//=========== Signup ===========\\

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Check if phone number starts with 0
      if (phoneNumberEC.text.startsWith('0')) {
        phoneNumberEC.text = phoneNumberEC.text.substring(1);
      }

      var phoneNumberRegExp = RegExp(mobilePattern);

      if (phoneNumberEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your phone number");
        return;
      } else if (!phoneNumberRegExp.hasMatch(phoneNumberEC.text)) {
        ApiProcessorController.errorSnack("Please enter a valid phone number");
        return;
      }

      log("This is the phone number:${phoneNumberEC.text}");

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 3));

      Get.put(PhoneOTPController());
      await Get.to(
        () => PhoneOTP(
          userPhoneNumber: phoneNumberEC.text,
          loadData: PhoneOTPController.instance.submitOTPSignup,
        ),
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

  toEmailSignup() {
    Get.toNamed(Routes.emailSignup, preventDuplicates: true);
  }

  //=========== onChanged Functions ===========\\
  toggleCheck(value) {
    isChecked.value = !isChecked.value;
  }

  //=========== Navigate ===========\\
  toPhoneLogin() {
    Get.toNamed(Routes.phoneLogin, preventDuplicates: true);
  }
}
