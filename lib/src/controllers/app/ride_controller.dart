import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../../app/home/screen/home_screen.dart';
// import '../../../app/home/views/android/payment_success_dialog.dart';
// import '../../../app/ride/content/end_trip_modal.dart';
// import '../../../app/ride/content/start_ride_modal.dart';

class RideController extends GetxController {
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  static RideController get instance {
    return Get.find<RideController>();
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

  displayRideInfo() async {
    showRideInfo.value = true;
    update();
  }

  // endRide() async {
  //   hideRideInfo();
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   Get.offAll(
  //     () => const HomeScreen(),
  //     routeName: "/home",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     predicate: (routes) => false,
  //     transition: Get.defaultTransition,
  //   );
  //   // HomeScreenController.instance.showHomeModalBottomSheet();
  // }

  //======================================= Google Maps ================================================\\

  hideRideInfo() async {
    rideInProgress.value = false;
    rideComplete.value = false;

    showRideInfo.value = false;
    update();
  }

  //======================================== Init Function =========================================//
  initFunctions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // showStartRide();
  }

  @override
  void onInit() {
    initFunctions();
    super.onInit();
  }

  //====================================== Setting Google Map Consts =========================================\\

  void onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  // openPaymentSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const PaymentSuccessDialog();
  //     },
  //   );
  // }

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

  // void reShowEndRideModal() async {
  //   final media = MediaQuery.of(Get.context!).size;

  //   await showFloatingIconButton();

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     isDismissible: true,
  //     context: Get.context!,
  //     barrierColor: kTransparentColor,
  //     useSafeArea: true,
  //     constraints: BoxConstraints(
  //       maxHeight: media.height / 1.4,
  //       minWidth: media.width,
  //     ),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(50),
  //         topRight: Radius.circular(50),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Obx(
  //         () {
  //           return EndTripModal(displayInfo: showRideInfo.value);
  //         },
  //       );
  //     },
  //   );

  //   rideInProgressFunc();
  //   await Future.delayed(const Duration(seconds: 5));
  //   rideCompleteFunc();
  // }

  rideCompleteFunc() async {
    rideComplete.value = true;
    update();
  }

  rideInProgressFunc() async {
    rideInProgress.value = true;
    update();
  }

  // void showEndRideModal() async {
  //   Get.close(0);
  //   final media = MediaQuery.of(Get.context!).size;

  //   await showFloatingIconButton();

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     isDismissible: true,
  //     context: Get.context!,
  //     barrierColor: kTransparentColor,
  //     useSafeArea: true,
  //     constraints: BoxConstraints(
  //       maxHeight: media.height / 1.6,
  //       minWidth: media.width,
  //     ),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(50),
  //         topRight: Radius.circular(50),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Obx(
  //         () {
  //           return EndTripModal(displayInfo: showRideInfo.value);
  //         },
  //       );
  //     },
  //   );

  // This will display info immediately and then hide it after 3 seconds
  //   displayRideInfo();
  //   await Future.delayed(const Duration(seconds: 2));
  //   rideInProgressFunc();
  //   await Future.delayed(const Duration(seconds: 5));
  //   rideCompleteFunc();
  // }

  //================= End Ride ===================\\

  showFloatingIconButton() {
    floatingIconButtonIsVisible.value = true;
    update();
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
  //         BoxConstraints(maxHeight: media.height, minWidth: media.width),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(32),
  //         topRight: Radius.circular(32),
  //       ),
  //     ),
  //     builder: (context) {
  //       return const StartRideModal();
  //     },
  //   );
  // }
}
