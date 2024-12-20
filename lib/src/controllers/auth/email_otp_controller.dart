import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/provide_name/screen/provide_name_screen.dart';
import 'package:green_wheels/src/models/auth/verify_otp_response_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/home/screen/home_screen.dart';
import '../../../main.dart';
import '../others/api_processor_controller.dart';

class EmailOTPController extends GetxController {
  static EmailOTPController get instance {
    return Get.find<EmailOTPController>();
  }

  @override
  void onInit() {
    startTimer();
    pin1FN.requestFocus();
    super.onInit();
  }

  //=========== Variables ===========\\

  late Timer _timer;
  var userEmail = Get.arguments?["userEmail"] ?? "";
  var riderId = Get.arguments?["riderId"] ?? "";
  String userToken = "";

  //=========== Models ===========\\
  var verifyOTPResponse = VerifyOTPResponseModel.fromJson(null).obs;

  //=========== Form Key ===========\\

  final formKey = GlobalKey<FormState>();

  //=========== Controllers ===========\\

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

  //================= Resend OTP ======================\\
  void requestOTP() async {
    secondsRemaining.value = 60;
    timerComplete.value = false;
    var url = ApiUrl.baseUrl + ApiUrl.resendOtp;

    Map data = {"email": userEmail};

    log("This is the Url: $url");
    log("User Email: $userEmail");

    // Client service
    var response = await HttpClientService.postRequest(url, null, data);

    if (response == null) {
      isLoading.value = false;
      return;
    }
    try {
      // Convert to json
      dynamic responseJson;
      responseJson = jsonDecode(response.body);

      log("This is the response json ====> $responseJson");

      if (response.statusCode == 200) {
        ApiProcessorController.successSnack(responseJson["message"]);
        await Future.delayed(const Duration(milliseconds: 500));
        await startTimer();
      } else {
        log("Request failed with status: ${response.statusCode}");
        log("Response body: ${response.body}");
        ApiProcessorController.warningSnack(responseJson["message"]);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  //================= submit OTP Signup ======================\\
  Future<void> submitOTPLogin() async {
    isLoading.value = true;
    update();

    //Pause the timer
    pauseTimer();
    timerComplete.value = false;

    var url = ApiUrl.baseUrl + ApiUrl.verifyOtp;

    var otpCode = pin1EC.text + pin2EC.text + pin3EC.text + pin4EC.text;

    Map data = {
      "rider_id": riderId.toString(),
      "otp": otpCode,
    };

    log("This is the Url: $url");
    log("This is the email otp data: $data");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.postRequest(url, null, data);

    if (response == null) {
      isLoading.value = false;
      //Continue the timer and enable resend button
      startTimer();
      return;
    }

    // //Save state that the user has logged in
    // prefs.setBool("isLoggedIn", true);

    try {
      // Convert to json
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      // log("This is the response body ====> ${response.body}");

      if (response.statusCode == 200) {
        // Map the response json to the model provided
        verifyOTPResponse.value = VerifyOTPResponseModel.fromJson(responseJson);
        prefs.setString("userToken", verifyOTPResponse.value.data.token);

        //Save state that the user has logged in
        prefs.setBool("isLoggedIn", true);

        await Future.delayed(const Duration(seconds: 2));
        ApiProcessorController.successSnack(responseJson["message"]);

        Get.offAll(
          () => const HomeScreen(),
          routeName: "/home",
          fullscreenDialog: true,
          curve: Curves.easeInOut,
          predicate: (routes) => false,
          popGesture: false,
          transition: Get.defaultTransition,
        );
      } else {
        ApiProcessorController.warningSnack(responseJson["message"]);

        log("Request failed with status: ${response.statusCode}");
        log("Response body: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }

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

    var url = ApiUrl.baseUrl + ApiUrl.verifyOtp;

    var otpCode = pin1EC.text + pin2EC.text + pin3EC.text + pin4EC.text;

    Map data = {
      "rider_id": riderId.toString(),
      "otp": otpCode,
    };

    log("This is the Url: $url");
    log("This is the email otp data: $data");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.postRequest(url, null, data);

    if (response == null) {
      isLoading.value = false;
      //Continue the timer and enable resend button
      startTimer();
      return;
    }

    try {
      // Convert to json
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      // log("This is the response body ====> ${response.body}");

      if (response.statusCode == 200) {
        // Map the response json to the model provided
        verifyOTPResponse.value = VerifyOTPResponseModel.fromJson(responseJson);
        prefs.setString("userToken", verifyOTPResponse.value.data.token);

        //Save state that the user has logged in
        prefs.setBool("isLoggedIn", true);

        await Future.delayed(const Duration(seconds: 2));
        ApiProcessorController.successSnack(responseJson["message"]);
        Get.to(
          () => const ProvideNameScreen(isEmailSignup: true),
          routeName: "/provide-name",
          arguments: {"riderId": riderId, "email": userEmail},
          fullscreenDialog: true,
          curve: Curves.easeInOut,
          preventDuplicates: true,
          popGesture: false,
          transition: Get.defaultTransition,
        );
      } else {
        ApiProcessorController.warningSnack(responseJson["message"]);

        log("Request failed with status: ${response.statusCode}");
        log("Response body: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }

    isLoading.value = false;

    //Continue the timer and enable resend button
    startTimer();
  }
}
