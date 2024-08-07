import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/consts.dart';
import '../../routes/routes.dart';
import '../others/api_processor_controller.dart';

class ResetPasswordViaEmailController extends GetxController {
  static ResetPasswordViaEmailController get instance {
    return Get.find<ResetPasswordViaEmailController>();
  }

  @override
  void onInit() {
    emailFN.requestFocus();
    super.onInit();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final emailEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final emailFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var formIsValid = false.obs;
  var responseStatus = 0.obs;
  var responseMessage = "".obs;

  //=========== onChanged Functions ===========\\

  emailOnChanged(value) {
    var emailRegExp = RegExp(emailPattern);
    if (!emailRegExp.hasMatch(emailEC.text)) {
      isEmailValid.value = false;
      setFormIsInvalid();
    } else {
      isEmailValid.value = true;
      setFormIsValid();
    }

    update();
  }

  setFormIsValid() {
    formIsValid.value = true;
  }

  setFormIsInvalid() {
    formIsValid.value = false;
  }

  //=========== Login Methods ===========\\
  onSubmitted(value) {
    if (formIsValid.isTrue) {
      submitEmail();
    }
  }

  Future<void> submitEmail() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (emailEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your email");
        setFormIsInvalid();
        return;
      } else if (isEmailValid.value == false) {
        ApiProcessorController.errorSnack("Please enter a valid email");
        setFormIsInvalid();
        return;
      }

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(milliseconds: 1000));
      ApiProcessorController.successSnack("An OTP has been sent to your email");

      Get.toNamed(Routes.resetPasswordViaEmailOTP, preventDuplicates: true);

      isLoading.value = false;
      update();
    }
  }
}
