import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/models/auth/login_response_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth/email_otp/screen/email_otp.dart';
import '../others/api_processor_controller.dart';
import 'email_otp_controller.dart';

class EmailLoginController extends GetxController {
  static EmailLoginController get instance {
    return Get.find<EmailLoginController>();
  }

  //=========== Models ===========\\
  var loginResponse = LoginResponseModel.fromJson(null).obs;

  //=========== Variables ===========\\
  var riderId = 0;
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

  //=========== Login ===========\\

  Future<void> login() async {
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
      update();

      var url = ApiUrl.baseUrl + ApiUrl.login;

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

      try {
        // Convert to json
        dynamic responseJson;

        responseJson = jsonDecode(response.body);

        log("This is the response body ====> ${response.body}");

        //Map the response json to the model provided
        loginResponse.value = LoginResponseModel.fromJson(responseJson);
        responseMessage.value = loginResponse.value.message;
        riderId = loginResponse.value.data.riderId;

        if (response.statusCode == 200) {
          await Future.delayed(const Duration(seconds: 1));
          ApiProcessorController.warningSnack(loginResponse.value.message);

          await Get.to(
            () => EmailOTP(
              userEmail: emailEC.text,
              loadData: EmailOTPController.instance.submitOTPLogin,
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
          ApiProcessorController.warningSnack(responseJson["message"]);
        }
      } catch (e) {
        log(e.toString());
      }

      await Future.delayed(const Duration(seconds: 3));
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    emailFN.requestFocus();
  }

  //=========== Submit ===========\\
  onSubmitted(value) {
    login();
  }

  //=========== onChanged Functions ===========\\
  toggleCheck(value) {
    isChecked.value = !isChecked.value;
  }
}
