import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:green_wheels/main.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/registration_rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../routes/routes.dart';

class MenuScreenController extends GetxController {
  static MenuScreenController get instance {
    return Get.find<MenuScreenController>();
  }

  @override
  void onInit() {
    getRiderProfile();
    super.onInit();
  }

  //================ Variables =================\\
  var walletBalance = "".obs;
  //================ Booleans =================\\
  var isLoadingRiderProfile = false.obs;

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var registrationRiderModel = RegistrationRiderModel.fromJson(null).obs;

  //===================== Variable ========================\\
  List<Map<String, dynamic>> menuTotalInfo = [
    {
      "icon": Iconsax.routing,
      "number": 0,
      "label": "Ride bookings",
    },
    {
      "icon": Iconsax.calendar_1,
      "number": 0,
      "label": "Scheduled Rides",
    },
    {
      "icon": Iconsax.car,
      "number": 0,
      "label": "Car rentals",
    },
  ];

  List<Map<String, dynamic>> get menuOptions {
    return [
      {
        "icon": Iconsax.routing,
        "nav": goToRideHistory,
        "label": "Ride History",
      },
      {
        "icon": Iconsax.calendar_1,
        "nav": goToScheduledTrips,
        "label": "Scheduled Trips",
      },
      {
        "icon": Iconsax.car,
        "nav": goToCarRentals,
        "label": "Car Rentals",
      },
      {
        "icon": Iconsax.wallet_1,
        "nav": goToGreenWalletPayment,
        "label": "Green Wallet Payment",
      },
      {
        "icon": Iconsax.message_question,
        "nav": goToFAQs,
        "label": "FAQ",
      },
      {
        "icon": Iconsax.setting_2,
        "nav": goToSettings,
        "label": "Settings",
      },
    ];
  }

  //===================== Navivations ========================\\
  goToRideHistory() async {
    Get.toNamed(
      Routes.rideHistoryMenu,
      preventDuplicates: true,
    );
  }

  goToScheduledTrips() async {
    Get.toNamed(
      Routes.scheduledTripsMenu,
      preventDuplicates: true,
    );
  }

  goToCarRentals() async {
    Get.toNamed(
      Routes.carRentalsMenu,
      preventDuplicates: true,
    );
  }

  goToGreenWalletPayment() async {
    Get.toNamed(
      Routes.greenWalletPaymentMenu,
      preventDuplicates: true,
      arguments: {"wallet_ballance": walletBalance.value},
    );
  }

  goToFAQs() async {
    // Get.toNamed(
    //   Routes.faqMenu,
    //   preventDuplicates: true,
    // );
  }

  goToSettings() async {
    // Get.toNamed(
    //   Routes.settingsMenu,
    //   preventDuplicates: true,
    // );
  }

  //Get Rider  Details
  Future<void> getRiderProfile() async {
    isLoadingRiderProfile.value = true;
    var url = ApiUrl.baseUrl + ApiUrl.getRiderProfile;
    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.getRequest(url, userToken);

    if (response == null) {
      isLoadingRiderProfile.value = false;
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

        registrationRiderModel.value = getRiderProfileResponseModel.value.data;
        walletBalance.value = registrationRiderModel.value.walletBalance;

        log(getRiderProfileResponseModel.value.message);
        log(jsonEncode(registrationRiderModel.value));
      } else {
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
    isLoadingRiderProfile.value = false;
  }
}
