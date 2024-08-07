import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../app/auth/login/screen/login_screen.dart';
import '../../../app/splash/success/screen/success_screen.dart';
import '../../constants/consts.dart';
import '../others/api_processor_controller.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance {
    return Get.find<ResetPasswordController>();
  }

  //=========== Form Key ===========\\
  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  //=========== Focus nodes ===========\\
  final passwordFN = FocusNode();
  final confirmPasswordFN = FocusNode();

  //=========== Booleans ===========\\
  var isLoading = false.obs;
  var isPasswordValid = false.obs;
  var isConfirmPasswordValid = false.obs;
  var passwordIsHidden = true.obs;
  var confirmPasswordIsHidden = true.obs;
  var formIsValid = false.obs;
  var isTypingPassword = false.obs;
  var isTypingConfirmPassword = false.obs;

  //=========== passwordOnChanged ===========\\
  passwordOnChanged(value) {
    var passwordRegExp = RegExp(passwordPattern);

    // Check if the text field is empty
    if (value.isEmpty) {
      isTypingPassword.value = false;
    } else {
      isTypingPassword.value = true;
    }

    update();

    if (!passwordRegExp.hasMatch(passwordEC.text) &&
        isTypingPassword.value == true) {
      isPasswordValid.value = false;
      setFormIsInvalid();
    } else {
      isPasswordValid.value = true;
      update();
    }

    update();
  }

  confirmPasswordOnChanged(value) {
    // Check if the text field is empty
    if (value.isEmpty) {
      isTypingConfirmPassword.value = false;
    } else {
      isTypingConfirmPassword.value = true;
    }

    update();

    if (confirmPasswordEC.text == passwordEC.text) {
      isConfirmPasswordValid.value = true;
      setFormIsValid();
    } else {
      isConfirmPasswordValid.value = false;
      setFormIsInvalid();
      update();
    }

    update();
  }

  setFormIsValid() {
    formIsValid.value = true;
  }

  setFormIsInvalid() {
    formIsValid.value = false;
  }

  //=========== Submit ===========\\
  onSubmitted(value) {
    if (formIsValid.isTrue) {
      resetPassword();
    }
  }

  Future<void> resetPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (passwordEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your password");
        return;
      } else if (confirmPasswordEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please confirm your password");
        return;
      } else if (confirmPasswordEC.text != passwordEC.text) {
        ApiProcessorController.errorSnack("Passwords do not match");
        return;
      }
      isLoading.value = true;
      update();

      await Future.delayed(const Duration(seconds: 2));
      ApiProcessorController.successSnack("Password reset successful");

      Get.to(
        () => SuccessScreen(
          subtitle:
              "Your Password has been reset successfully. Now login with your new Password.",
          loadScreen: () {
            Get.offAll(
              () => const LoginScreen(),
              routeName: "/login",
              fullscreenDialog: true,
              curve: Curves.easeInOut,
              predicate: (routes) => false,
              popGesture: false,
              transition: Get.defaultTransition,
            );
          },
        ),
        routeName: "/success-screen",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        preventDuplicates: true,
        popGesture: false,
        transition: Get.defaultTransition,
      );

      isLoading.value = false;
      update();
    }
  }
}
