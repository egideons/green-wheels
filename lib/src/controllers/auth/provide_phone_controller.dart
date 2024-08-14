import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';

import '../../../app/home/screen/home_screen.dart';
import '../../../main.dart';
import '../others/api_processor_controller.dart';

class ProvidePhoneController extends GetxController {
  static ProvidePhoneController get instance {
    return Get.find<ProvidePhoneController>();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final phoneNumberEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final phoneNumberFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var responseStatus = 0.obs;
  var formIsValid = false.obs;
  var responseMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    phoneNumberFN.requestFocus();
  }

  //=========== Submit ===========\\
  onSubmitted(value) {
    if (formIsValid.isTrue) {
      toHomeScreen();
    }
  }

  //=========== OnChanged ===========\\
  phoneNumberOnChanged(value) {
    var phoneNumberRegExp = RegExp(mobilePattern);
    if (!phoneNumberRegExp.hasMatch(phoneNumberEC.text)) {
      setFormIsInvalid();
    } else {
      setFormIsValid();
    }
    update();
  }

  //=========== Form is invalid ===========\\
  setFormIsInvalid() {
    formIsValid.value = false;
  }

  //=========== Form is valid ===========\\
  setFormIsValid() {
    formIsValid.value = true;
  }

  //=========== Signup ===========\\

  Future<void> toHomeScreen() async {
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

      //Save state that the user has entered their phone number
      prefs.setBool("hasEnteredPhoneNumber", true);

      await Get.to(
        () => const HomeScreen(),
        routeName: "/home",
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
}
