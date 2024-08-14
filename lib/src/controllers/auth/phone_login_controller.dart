import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/phone_otp/screen/phone_otp.dart';
import 'package:green_wheels/src/constants/consts.dart';

import '../../routes/routes.dart';
import '../others/api_processor_controller.dart';
import 'phone_otp_controller.dart';

class PhoneLoginController extends GetxController {
  static PhoneLoginController get instance {
    return Get.find<PhoneLoginController>();
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

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 3));

      Get.put(PhoneOTPController());
      await Get.to(
        () => PhoneOTP(
          userPhoneNumber: phoneNumberEC.text,
          loadData: PhoneOTPController.instance.submitOTPLogin,
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

  @override
  void onInit() {
    super.onInit();

    phoneNumberFN.requestFocus();
  }

  //=========== login ===========\\
  onSubmitted(value) {
    login();
  }

  //=========== onChanged Functions ===========\\
  toEmailLogin() {
    Get.toNamed(Routes.emailLogin, preventDuplicates: true);
  }
}
