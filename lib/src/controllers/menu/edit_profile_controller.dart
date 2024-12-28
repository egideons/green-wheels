import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/main.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  static EditProfileController get instance {
    return Get.find<EditProfileController>();
  }

  @override
  void onInit() {
    getRiderProfile();
    super.onInit();
  }

  //================ Keys =================\\
  final formKey = GlobalKey<FormState>();

  //================ Booleans =================\\
  var isLoading = false.obs;
  var isSubmitting = false.obs;

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var riderModel = RiderModel.fromJson(null).obs;

  //================ Controllers =================\\
  var fullNameEC = TextEditingController();
  var countryEC = TextEditingController();
  var stateEC = TextEditingController();
  var cityEC = TextEditingController();
  var streetEC = TextEditingController();

  //================ Focus Nodes =================\\
  var fullNameFN = FocusNode();
  var countryFN = FocusNode();
  var stateFN = FocusNode();
  var cityFN = FocusNode();
  var streetFN = FocusNode();

  //================ Functions =================\\
  onFieldSubmitted(String value) {
    submitForm();
  }

  //Get Rider Profile
  Future<void> getRiderProfile() async {
    isLoading.value = true;
    var url = ApiUrl.baseUrl + ApiUrl.getRiderProfile;
    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.getRequest(url, userToken);

    if (response == null) {
      isLoading.value = false;
      return;
    }

    try {
      if (response.statusCode == 200) {
        // log("Response body=> ${response.body}");

        // Convert to json
        dynamic responseJson;

        responseJson = jsonDecode(response.body);

        getRiderProfileResponseModel.value =
            GetRiderProfileResponseModel.fromJson(responseJson);

        riderModel.value = getRiderProfileResponseModel.value.data;

        log(getRiderProfileResponseModel.value.message);
        log(jsonEncode(riderModel.value));

        fullNameEC.text = riderModel.value.fullName;
        countryEC.text = riderModel.value.country;
        stateEC.text = riderModel.value.state;
        cityEC.text = riderModel.value.city;
        streetEC.text = riderModel.value.street;
      } else {
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      isSubmitting.value = true;

      var url = ApiUrl.baseUrl + ApiUrl.editProfile;

      var userToken = prefs.getString("userToken");

      Map data = {
        "full_name": fullNameEC.text,
        "country": countryEC.text,
        "state": stateEC.text,
        "city": cityEC.text,
        "street": streetEC.text,
      };

      // var finalData = jsonEncode(data);

      log("This is the Url: $url");
      log("This is the Data: $data");

      //HTTP Client Service
      http.Response? response =
          await HttpClientService.patchRequest(url, userToken, data);

      if (response == null) {
        isSubmitting.value = false;
        return;
      }

      try {
        // Convert to json
        dynamic responseJson;

        responseJson = jsonDecode(response.body);

        log("This is the response body ====> ${response.body}");
        responseJson = jsonDecode(response.body);

        if (response.statusCode == 200) {
          getRiderProfileResponseModel.value =
              GetRiderProfileResponseModel.fromJson(responseJson);

          riderModel.value = getRiderProfileResponseModel.value.data;
          getRiderProfile();

          Get.back();
          ApiProcessorController.successSnack(responseJson["message"]);
        } else {
          ApiProcessorController.warningSnack(responseJson["message"]);
        }
      } catch (e) {
        log(e.toString());
      }
      isSubmitting.value = false;
    }
  }
}
