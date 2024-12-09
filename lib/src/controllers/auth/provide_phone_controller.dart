import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/models/rider/get_registration_rider_response_model.dart';
import 'package:green_wheels/src/models/rider/registration_rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/home/screen/home_screen.dart';
import '../../../main.dart';
import '../others/api_processor_controller.dart';

class ProvidePhoneController extends GetxController {
  static ProvidePhoneController get instance {
    return Get.find<ProvidePhoneController>();
  }

  //=========== Models ===========\\
  var registrationRiderModel = RegistrationRiderModel.fromJson(null).obs;

  var getRegistrationRiderModel =
      GetRegistrationRiderResponseModel.fromJson(null).obs;

  //=========== Variables ===========\\
  var riderId = Get.arguments?["riderId"] ?? "";
  var fullName = Get.arguments?["fullName"] ?? "";

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

      var url = ApiUrl.baseUrl + ApiUrl.completeRegistration;

      Map data = {
        "rider_id": riderId.toString(),
        "full_name": fullName,
        "phone": phoneNumberEC.text,
      };

      var userToken = prefs.getString("userToken");
      log(userToken.toString());
      log("This is the Url: $url");
      log("This is the email otp data: $data");

      //HTTP Client Service
      http.Response? response =
          await HttpClientService.postRequest(url, null, data);

      if (response == null) {
        isLoading.value = false;
        return;
      }

      try {
        // Convert to json
        dynamic responseJson;

        responseJson = jsonDecode(response.body);

        log("This is the response body ====> ${response.body}");

        getRegistrationRiderModel.value =
            GetRegistrationRiderResponseModel.fromJson(responseJson);

        registrationRiderModel.value = getRegistrationRiderModel.value.data;

        if (response.statusCode == 200) {
          ApiProcessorController.successSnack(responseJson["message"]);

          //Save state that the user has entered their phone number
          prefs.setBool("hasEnteredPhoneNumber", true);
          await Future.delayed(const Duration(seconds: 1));

          await Get.offAll(
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
          log(responseJson["message"]);
        }
        //Map the response json to the model provided
      } catch (e) {
        log(e.toString());
      }
    }

    isLoading.value = false;
  }
}
