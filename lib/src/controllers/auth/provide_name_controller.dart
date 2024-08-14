import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';

import '../../../app/home/screen/home_screen.dart';
import '../../../main.dart';
import '../../routes/routes.dart';
import '../others/api_processor_controller.dart';

class ProvideNameController extends GetxController {
  static ProvideNameController get instance {
    return Get.find<ProvideNameController>();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final userNameEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final userNameFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var responseStatus = 0.obs;
  var formIsValid = false.obs;
  var responseMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    userNameFN.requestFocus();
  }

  //=========== Submit ===========\\
  onSubmitted(value) {
    if (formIsValid.isTrue) {
      toHomeScreen();
    }
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

      var userNameRegExp = RegExp(namePattern);

      if (userNameEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your name");
        return;
      } else if (!userNameRegExp.hasMatch(userNameEC.text)) {
        ApiProcessorController.errorSnack("Please enter a valid name");
        return;
      }

      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 3));

      //Save state that the user has entered their name
      prefs.setBool("hasEnteredName", true);

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

  //=========== Provide Phone for Email Signup ===========\\
  toProvidePhone() async {
    Get.toNamed(Routes.providePhone, preventDuplicates: true);
  }

  //=========== OnChanged ===========\\
  userNameOnChanged(value) {
    var userNameRegExp = RegExp(namePattern);
    if (!userNameRegExp.hasMatch(userNameEC.text)) {
      setFormIsInvalid();
    } else {
      setFormIsValid();
    }
    update();
  }
}
