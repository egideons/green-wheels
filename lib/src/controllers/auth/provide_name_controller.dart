import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/home/screen/home_screen.dart';
import 'package:green_wheels/main.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/models/rider/get_registration_rider_response_model.dart';
import 'package:green_wheels/src/models/rider/registration_rider_model.dart';
import 'package:green_wheels/src/routes/routes.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

import '../others/api_processor_controller.dart';

class ProvideNameController extends GetxController {
  static ProvideNameController get instance {
    return Get.find<ProvideNameController>();
  }

  //=========== Models ===========\\
  var registrationRiderModel = RegistrationRiderModel.fromJson(null).obs;
  var getRegistrationRiderModel =
      GetRegistrationRiderResponseModel.fromJson(null).obs;

  //=========== Variables ===========\\
  var riderId = Get.arguments?["riderId"] ?? "";

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

      var url = ApiUrl.baseUrl + ApiUrl.completeRegistration;

      Map data = {
        "rider_id": riderId.toString(),
        "full_name": userNameEC.text,
        "phone": "",
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

          //Save state that the user has entered their name
          prefs.setBool("hasEnteredName", true);
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
    update();
  }

  //=========== Provide Phone for Email Signup ===========\\
  toProvidePhone() async {
    Get.toNamed(
      Routes.providePhone,
      preventDuplicates: true,
      arguments: {
        "riderId": riderId,
        "fullName": userNameEC.text,
      },
    );
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
