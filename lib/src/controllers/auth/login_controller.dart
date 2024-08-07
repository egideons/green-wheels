import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/email_otp/screen/email_otp.dart';

import '../../constants/consts.dart';
import '../../routes/routes.dart';
import '../others/api_processor_controller.dart';

class LoginController extends GetxController {
  static LoginController get instance {
    return Get.find<LoginController>();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final emailFN = FocusNode();
  final passwordFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var isPasswordValid = false.obs;
  var passwordIsHidden = true.obs;
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

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (emailEC.text.isEmpty) {
        setFormIsInvalid();
        update();
        ApiProcessorController.errorSnack("Please enter your email");
        return;
      }

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 3));

      ApiProcessorController.successSnack("Login successful");

      await Get.to(
        () => EmailOTP(userEmail: emailEC.text),
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

  navigateToForgotPassword() {
    Get.toNamed(Routes.resetPasswordViaEmail, preventDuplicates: true);
  }

  //=========== Login Methods ===========\\
  onSubmitted(value) {
    if (formIsValid.isTrue) {
      login();
    }
  }

  passwordOnChanged(value) {
    var passwordRegExp = RegExp(loginPasswordPattern);
    if (isEmailValid.isTrue) {
      if (!passwordRegExp.hasMatch(passwordEC.text)) {
        isPasswordValid.value = false;
        setFormIsInvalid();
      } else {
        isPasswordValid.value = true;
        setFormIsValid();
        update();
      }
    } else {
      isPasswordValid.value = false;
      setFormIsInvalid();
    }
    update();
  }

  setFormIsInvalid() {
    formIsValid.value = false;
  }

  setFormIsValid() {
    formIsValid.value = true;
  }
}
