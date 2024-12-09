import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/phone_login/screen/phone_login_screen.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth/phone_signup/screen/phone_signup_screen.dart';
import '../../../app/home/screen/home_screen.dart';
import '../../../app/onboarding/screen/onboarding_screen.dart';
import '../../../main.dart';

class AuthController extends GetxController {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () {
      loadApp();
    });
    super.onInit();
  }

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var riderModel = RiderModel.fromJson(null).obs;

  var isLoading = false.obs;
  var responseStatus = 0.obs;
  var responseMessage = "".obs;
  var isLoggedIn = false.obs;

  Future<void> loadApp() async {
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;

    bool notNewUser = await getRiderProfile();

    if (notNewUser) {
      if (isLoggedIn.value) {
        // User is logged in, navigate to the home screen
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
        // User is onboarded but not logged in, navigate to the phone login screen
        await Get.offAll(
          () => const PhoneLoginScreen(),
          routeName: "/login",
          fullscreenDialog: true,
          curve: Curves.easeInOut,
          predicate: (routes) => false,
          popGesture: false,
          transition: Get.defaultTransition,
        );
      }
      // }
      //else if (isLoggedIn.value) {
      //   // User is logged in, navigate to the home screen
      //   await Get.offAll(
      //     () => const HomeScreen(),
      //     routeName: "/home",
      //     fullscreenDialog: true,
      //     curve: Curves.easeInOut,
      //     predicate: (routes) => false,
      //     popGesture: false,
      //     transition: Get.defaultTransition,
      //   );
    } else if (isOnboarded) {
      // User is onboarded but not logged in, navigate to the sign up screen
      await Get.offAll(
        () => const PhoneSignupScreen(),
        routeName: "/signup",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    } else {
      // User is not onboarded, navigate to the onboarding screen
      await Get.offAll(
        () => const OnboardingScreen(),
        routeName: "/onboarding",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    }
  }

  //Get Rider Profile
  Future<bool> getRiderProfile() async {
    var url = ApiUrl.baseUrl + ApiUrl.getRiderProfile;

    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.getRequest(url, userToken);

    if (response == null) {
      return false;
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

        isLoggedIn.value = riderModel.value.loggedIn;

        log(getRiderProfileResponseModel.value.message);
        log(jsonEncode(riderModel.value));

        return true;
      } else {
        log("An error occured, Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
