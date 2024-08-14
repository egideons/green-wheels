import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/auth/email_otp/screen/email_otp.dart';
import '../others/api_processor_controller.dart';
import 'email_otp_controller.dart';

class EmailSignupController extends GetxController {
  static EmailSignupController get instance {
    return Get.find<EmailSignupController>();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final emailEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final emailFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var responseStatus = 0.obs;
  var isChecked = false.obs;
  var responseMessage = "".obs;

  @override
  void onInit() {
    super.onInit();

    emailFN.requestFocus();
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

      if (emailEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your email");
        return;
      } else if (!emailEC.text.isEmail) {
        ApiProcessorController.errorSnack("Please enter a valid email");
        return;
      }

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 3));

      Get.put(EmailOTPController());
      await Get.to(
        () => EmailOTP(
          userEmail: emailEC.text,
          loadData: EmailOTPController.instance.submitOTPSignup,
        ),
        routeName: "/email-otp",
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

  //=========== onChanged Functions ===========\\
  toggleCheck(value) {
    isChecked.value = !isChecked.value;
  }
}
