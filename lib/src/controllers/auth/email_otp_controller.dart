import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../app/home/screen/home_screen.dart';
import '../../../app/auth/provide_name/screen/provide_name_screen.dart';
import '../../../app/home/screen/home_screen.dart';
import '../../../main.dart';
import '../others/api_processor_controller.dart';

class EmailOTPController extends GetxController {
  static EmailOTPController get instance {
    return Get.find<EmailOTPController>();
  }

  //=========== Variables ===========\\

  late Timer _timer;

  //=========== Form Key ===========\\

  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\

  final emailEC = TextEditingController();

  final pin1EC = TextEditingController();
  final pin2EC = TextEditingController();
  final pin3EC = TextEditingController();
  final pin4EC = TextEditingController();
  //=========== Focus nodes ===========\\
  final pin1FN = FocusNode();

  final pin2FN = FocusNode();
  final pin3FN = FocusNode();
  final pin4FN = FocusNode();
  //=========== Booleans ===========\\
  var secondsRemaining = 30.obs;

  var isLoading = false.obs;
  var formIsValid = false.obs;
  var timerComplete = false.obs;
  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  void onInit() {
    startTimer();
    pin1FN.requestFocus();
    super.onInit();
  }

  // //=========== on Submitted ===========\\
  // onSubmitted(value) {
  //   if (formIsValid.isTrue) {
  //     submitOTP();
  //     update();
  //   }
  // }

  pauseTimer() {
    if (timerComplete.value == false && isLoading.value == true) {
      _timer.cancel();
    }
  }

  //====================== Functions =========================\\

  //================= Onchanged ======================\\
  pin1Onchanged(value, context) {
    if (value.isEmpty) {
      setFormIsInvalid();
    }
    if (value.length == 1) {
      FocusScope.of(context).nextFocus();
    }
    update();
  }

  pin2Onchanged(value, context) {
    if (value.isEmpty) {
      FocusScope.of(context).previousFocus();
      setFormIsInvalid();
    }
    if (value.length == 1) {
      FocusScope.of(context).nextFocus();
    }
    update();
  }

  pin3Onchanged(value, context) {
    if (value.isEmpty) {
      FocusScope.of(context).previousFocus();
      setFormIsInvalid();
    }
    if (value.length == 1) {
      FocusScope.of(context).nextFocus();
    }
    update();
  }

  pin4Onchanged(value, context) {
    if (value.isEmpty) {
      FocusScope.of(context).previousFocus();
      setFormIsInvalid();
    }
    if (value.length == 1) {
      FocusScope.of(context).nearestScope;
      setFormIsValid();
      update();
      return;
    }
    update();
  }

  //================= Resend OTP ======================\\
  void requestOTP() async {
    secondsRemaining.value = 60;
    timerComplete.value = false;
    startTimer();
    update();
    ApiProcessorController.successSnack("An OTP has been sent to your email");
  }

  setFormIsInvalid() {
    formIsValid.value = false;
  }

  //================= Set form validity ======================\\

  setFormIsValid() {
    formIsValid.value = true;
  }

  //================= Start Timer ======================\\
  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        timerComplete.value = true;
        _timer.cancel();
      }
    });
  }

  //================= submit OTP Signup ======================\\
  Future<void> submitOTPLogin() async {
    isLoading.value = true;
    update();

    //Pause the timer
    pauseTimer();
    timerComplete.value = false;

    //Save state that the user has logged in
    prefs.setBool("isLoggedIn", true);
    //Save state that the user has entered their phone number
    prefs.setBool("hasEnteredPhoneNumber", true);
    //Save state that the user has entered their name
    prefs.setBool("hasEnteredName", true);

    await Future.delayed(const Duration(seconds: 3));
    ApiProcessorController.successSnack("Verification successful");

    Get.offAll(
      () => const HomeScreen(),
      routeName: "/home",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );

    isLoading.value = false;
    update();

    //Continue the timer and enable resend button
    onInit();
  }

  //================= submit OTP Signup ======================\\
  Future<void> submitOTPSignup() async {
    isLoading.value = true;
    update();

    //Pause the timer
    pauseTimer();
    timerComplete.value = false;

    //Save state that the user has logged in
    prefs.setBool("isLoggedIn", true);

    await Future.delayed(const Duration(seconds: 3));
    ApiProcessorController.successSnack("Verification successful");
    Get.to(
      () => const ProvideNameScreen(isEmailSignup: true),
      routeName: "/provide-name",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      preventDuplicates: true,
      popGesture: false,
      transition: Get.defaultTransition,
    );

    isLoading.value = false;
    update();

    //Continue the timer and enable resend button
    onInit();
  }
}
