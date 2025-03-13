import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/main.dart';
import 'package:green_wheels/src/models/auth/initiate_signup_response_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

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

  //=========== Models ===========\\
  var initiateSignupResponseModel =
      InitiateSignupResponseModel.fromJson(null).obs;
  var rideID = 0.obs;

  @override
  void onInit() {
    super.onInit();
    emailFN.requestFocus();
  }

  //=========== onChanged Functions ===========\\
  toggleCheck(value) {
    isChecked.value = !isChecked.value;
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

      var url = ApiUrl.baseUrl + ApiUrl.initiate;

      Map data = {"identifier": emailEC.text, "type": "email"};

      log("This is the Url: $url");
      log("This is the login Data: $data");

      //HTTP Client Service
      http.Response? response =
          await HttpClientService.postRequest(url, null, data);

      if (response == null) {
        isLoading.value = false;

        return;
      }
      // Convert to json
      dynamic responseJson;

      responseJson = jsonDecode(response.body);
      try {
        log("This is the response body ====> ${response.body}");

        if (response.statusCode == 200) {
          initiateSignupResponseModel.value =
              InitiateSignupResponseModel.fromJson(responseJson);
          responseMessage.value = initiateSignupResponseModel.value.message;

          var riderId = initiateSignupResponseModel.value.data.riderId;

          prefs.setString("userEmail", emailEC.text);
          await Future.delayed(const Duration(seconds: 1));
          prefs.setString("riderId", riderId.toString());
          await Future.delayed(const Duration(seconds: 1));

          //Display Snackbar
          ApiProcessorController.successSnack(responseMessage.value);

          // Get.put(EmailOTPController());
          await Get.to(
            () => EmailOTP(
              loadData: EmailOTPController.instance.submitOTPSignup,
            ),
            binding: BindingsBuilder.put(() => EmailOTPController()),
            arguments: {"email": emailEC.text, "riderId": riderId},
            routeName: "/email-otp",
            fullscreenDialog: true,
            curve: Curves.easeInOut,
            preventDuplicates: true,
            popGesture: false,
            transition: Get.defaultTransition,
          );
        } else {
          //Display Snackbar
          ApiProcessorController.warningSnack(responseJson["message"]);
          log(responseJson);
        }
      } catch (e) {
        ApiProcessorController.warningSnack(responseJson["message"]);

        log(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }
}
