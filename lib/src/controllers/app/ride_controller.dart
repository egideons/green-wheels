import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../app/ride/content/trip_completed_modal.dart';
import '../../../app/ride/content/trip_payment_successful_modal.dart';
import '../../../theme/colors.dart';

class RideController extends GetxController {
  static RideController get instance {
    return Get.find<RideController>();
  }

  @override
  void onInit() {
    initFunctions();
    super.onInit();
  }

  //================ Boolean =================\\
  var isLocationPermissionGranted = false.obs;
  var floatingIconButtonIsVisible = false.obs;
  var showInfo = false.obs;
  var showRideInfo = false.obs;
  var rideInProgress = false.obs;
  var rideComplete = false.obs;

  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;
  var panelController = PanelController();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  //====================================== Setting Google Map Consts =========================================\\

  void onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  //======================================= Google Maps ================================================\\

  /// When the location services are not enabled or permissions are denied the `Future` will return an error.
  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      isLocationPermissionGranted.value = true;
      update();
    }
    if (status.isDenied) {
      Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  //======================================== Init Function =========================================//
  initFunctions() async {
    await Future.delayed(const Duration(seconds: 10));
    showTripCompletedModal();
  }

  //======================================== Ride Functions =========================================//

  // void showStartRide() {
  //   final media = MediaQuery.of(Get.context!).size;

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     context: Get.context!,
  //     showDragHandle: true,
  //     useSafeArea: true,
  //     constraints:
  //         BoxConstraints(maxHeight: media.height / 3, minWidth: media.width),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(32),
  //         topRight: Radius.circular(32),
  //       ),
  //     ),
  //     builder: (context) {
  //       return const TripStartedModal();
  //     },
  //   );
  // }

  void showTripCompletedModal() async {
    Get.close(0);
    final media = MediaQuery.of(Get.context!).size;

    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      context: Get.context!,
      barrierColor: kTransparentColor,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: media.height,
        minWidth: media.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (context) {
        return Obx(
          () {
            return const TripCompletedModal();
          },
        );
      },
    );
  }

  //=============== Payment Section ================\\
  makePayment() async {
    Get.close(0);
    final media = MediaQuery.of(Get.context!).size;

    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      context: Get.context!,
      barrierColor: kTransparentColor,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: media.height / 1.6,
        minWidth: media.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (context) {
        return Obx(
          () {
            return const TripPaymentSuccessfulModal();
          },
        );
      },
    );
  }
}
