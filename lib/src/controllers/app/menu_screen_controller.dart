import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/auth/phone_login/screen/phone_login_screen.dart';
import 'package:green_wheels/app/menu/content/android_select_profile_pic_modal.dart';
import 'package:green_wheels/main.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:green_wheels/src/controllers/others/url_launcher_controller.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/image_upload_response_model.dart';
import 'package:green_wheels/src/models/rider/rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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
  var fileName = "".obs;
  var profileImageUrl = prefs.getString("profileImageUrl") ?? "";

  //================ Booleans =================\\
  var isLoadingRiderProfile = false.obs;
  var isUploadingProfilePic = false.obs;
  var profilePicIsUploaded = false.obs;
  var cameraPermissionIsGranted = false.obs;
  var profilePicUploadIsCanceled = false.obs;

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var riderModel = RiderModel.fromJson(null).obs;
  var imageUploadResponseModel = ImageUploadResponseModel.fromJson(null).obs;

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
        "trailingIsVisible": true,
      },
      {
        "icon": Iconsax.calendar_1,
        "nav": goToScheduledTrips,
        "label": "Scheduled Trips",
        "trailingIsVisible": true,
      },
      {
        "icon": Iconsax.car,
        "nav": goToCarRentals,
        "label": "Car Rentals",
        "trailingIsVisible": true,
      },
      {
        "icon": Iconsax.wallet_1,
        "nav": goToGreenWalletPayment,
        "label": "Green Wallet Payment",
        "trailingIsVisible": true,
      },
      {
        "icon": Iconsax.message_question,
        "nav": goToFAQs,
        "label": "FAQ",
        "trailingIsVisible": true,
      },
      {
        "icon": Iconsax.logout_1,
        "nav": logOut,
        "label": "Logout",
        "trailingIsVisible": false,
      },
    ];
  }

  //===================== Navivations ========================\\
  goToEditProfile() async {
    Get.toNamed(
      Routes.editProfile,
      preventDuplicates: true,
    );
  }

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
    UrlLaunchController.launchWeb(
      "https://essemobility.com/about-us",
      LaunchMode.externalApplication,
    );
  }

  logOut() async {
    prefs.remove("userToken");
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

  //Get Rider Profile
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

        riderModel.value = getRiderProfileResponseModel.value.data;
        walletBalance.value = riderModel.value.walletBalance;

        log(getRiderProfileResponseModel.value.message);
        log(jsonEncode(riderModel.value));
      } else {
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
    isLoadingRiderProfile.value = false;
  }

  //================ Upload Profile Picture ==================\\
  final ImagePicker picker = ImagePicker();
  XFile? selectedProfileImage;

  showUploadProfilePicModal() {
    var media = MediaQuery.of(Get.context!).size;

    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      useSafeArea: true,
      showDragHandle: true,
      sheetAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
      constraints:
          BoxConstraints(maxHeight: media.height / 3.2, maxWidth: media.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: const AndroidSelectProfilePicModal(),
        );
      },
    );
  }

  requestCameraPermission() async {
    try {
      log('Requesting camera permission');
      var status = await Permission.camera.request();
      log('Permission status: $status');

      if (status.isGranted) {
        cameraPermissionIsGranted.value = true;
        Get.close(0);
        uploadProfilePicWithCamera();
      } else if (status.isDenied) {
        await Permission.camera.request();
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    } catch (e) {
      log('Error while requesting camera permission: $e');
    }
  }

  requestGalleryPermission() async {
    try {
      log('Requesting media library permission');
      var status = await Permission.mediaLibrary.request();
      log('Permission status: $status');

      if (status.isGranted) {
        cameraPermissionIsGranted.value = true;
        Get.close(0);
        uploadProfilePicWithGallery();
      } else if (status.isDenied) {
        await Permission.mediaLibrary.request();
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    } catch (e) {
      log('Error while requesting media library permission: $e');
    }
  }

  uploadProfilePicWithCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedProfileImage = image;
      profilePicUploadIsCanceled.value = false;

      update();
    }
  }

  uploadProfilePicWithGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedProfileImage = image;
      profilePicUploadIsCanceled.value = false;

      update();
    }
  }

  cancelUpload() {
    profilePicUploadIsCanceled.value = true;
  }

  Future<void> uploadProfilePic() async {
    if (selectedProfileImage == null) {
      ApiProcessorController.warningSnack("No image selected");
      return;
    }
    if (await checkXFileSize(selectedProfileImage)) {
      ApiProcessorController.warningSnack("Image size must not exceed 5mb");
      return;
    }

    isUploadingProfilePic.value = true;

    // URL and token for the request
    var url = ApiUrl.baseUrl + ApiUrl.uploadProfileImage;
    var userToken = prefs.getString("userToken") ?? "";

    //HTTP Client Service
    var streamedResponse = await HttpClientService.uploadProfilePicture(
      url,
      userToken,
      selectedProfileImage!,
    );

    if (streamedResponse == null) {
      isUploadingProfilePic.value = false;
      ApiProcessorController.warningSnack("Failed to upload profile picture");
      return;
    }
    // Convert streamed response to readable data
    final responseBody = await streamedResponse.stream.bytesToString();
    final decodedResponse = jsonDecode(responseBody);

    // Log the status code and response body
    log("Response status code: ${streamedResponse.statusCode}");
    log("Response body: $responseBody");

    try {
      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        profilePicIsUploaded.value = true;

        imageUploadResponseModel.value =
            ImageUploadResponseModel.fromJson(decodedResponse);
        profileImageUrl = imageUploadResponseModel.value.data.path;
        fileName.value = imageUploadResponseModel.value.data.filename;

        var profileIsUpdated = await updateProfile(profileImageUrl);
        if (profileIsUpdated) {
          ApiProcessorController.successSnack(
            "Profile picture uploaded successfully",
          );
          prefs.setString("profileImageUrl", profileImageUrl);
        }
      } else {
        ApiProcessorController.warningSnack(
          "Failed to upload profile picture\n${decodedResponse["message"]},",
        );
      }
    } on SocketException {
      ApiProcessorController.warningSnack("Please connect to the internet");
    } catch (e) {
      log(e.toString());
    }
    isUploadingProfilePic.value = false;
  }

  Future<bool> updateProfile(String imageUrl) async {
    var url = ApiUrl.baseUrl + ApiUrl.editProfile;

    var userToken = prefs.getString("userToken");

    Map data = {
      "image": imageUrl,
    };

    // var finalData = jsonEncode(data);

    log("This is the Url: $url");
    log("This is the Data: $data");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.patchRequest(url, userToken, data);

    if (response == null) {
      return false;
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
        return true;
      } else {
        ApiProcessorController.warningSnack(responseJson["message"]);
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
