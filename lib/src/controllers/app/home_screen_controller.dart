import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

// import '../../../app/home/content/home_modal_bottom_sheet.dart';
// import '../../../app/home/views/android/accept_scheduled_ride_request_modal.dart';
// import '../../../app/home/views/android/accept_todays_ride_request_modal.dart';
// import '../../../app/home/views/android/accepted_scheduled_ride_request_modal.dart';
// import '../../../app/home/views/android/scheduled_ride_requests_modal.dart';
// import '../../../app/home/views/android/todays_ride_requests_modal.dart';
// import '../../../app/profile/screen/profile_screen.dart';
// import '../../../app/ride/screen/ride_screen.dart';
import '../../models/ride_tab_model.dart';

class HomeScreenController extends GetxController {
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

  //================ Keys =================\\
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //================ Ride Tabs =================\\
  var rideTabs = [
    RideTabModel(title: "Rides for Today", numOfRides: 3, isSelected: true),
    RideTabModel(title: "Scheduled Rides", numOfRides: 5, isSelected: false),
  ].obs;

  //================ Boolean =================\\
  var isRefreshing = false.obs;
  var isScrollToTopBtnVisible = false.obs;
  var isLocationPermissionGranted = false.obs;
  var showInfo = false.obs;
  var showRideInfo = false.obs;
  var rideInProgress = false.obs;
  var rideComplete = false.obs;

  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

//=============================== Open Drawer =====================================\\

  // void goToProfile() {
  //   Get.to(
  //     () => const ProfileScreen(),
  //     transition: Transition.rightToLeft,
  //     routeName: "/profile-screen",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     preventDuplicates: true,
  //   );
  // }

  //=============================== Display Info =====================================\\
  displayInfo() async {
    showInfo.value = true;
    update();
  }

  hideInfo() async {
    showInfo.value = false;
    update();
  }

  //=============================== Init Functions =====================================\\

  void initFunctions() async {
    //   await Future.delayed(const Duration(milliseconds: 500), () {
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       if (Get.context != null) {
    //         showHomeModalBottomSheet();
    //       }
    //     });
    //   });
    // This runs after 500 milliseconds
    await Future.delayed(const Duration(milliseconds: 500));
    // showHomeModalBottomSheet();

    // This will display info immediately and then hide it after 3 seconds
    displayInfo();
    await Future.delayed(const Duration(seconds: 3));
    hideInfo();
  }

  //======================================= Google Maps ================================================\\

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

  //================ Handle refresh ================\\

  Future<void> onRefresh() async {
    isRefreshing.value = true;
    update();

    await Future.delayed(const Duration(seconds: 2));

    isRefreshing.value = false;
    update();
  }

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

  void returnHome() async {
    Get.close(2);
  }

  //================ Select Tab =================//
  void selectTab(int index) {
    for (int i = 0; i < rideTabs.length; i++) {
      rideTabs[i].isSelected = i == index;
    }
    update();
  }

  // void showAcceptedScheduledRideRequestModal() {
  //   Get.close(0);
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
  //       return const AcceptedScheduledRideRequestModal();
  //     },
  //   );
  // }

  // void showAcceptScheduledRideRequestModal() {
  //   final media = MediaQuery.of(Get.context!).size;

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     showDragHandle: true,
  //     enableDrag: true,
  //     context: Get.context!,
  //     useSafeArea: true,
  //     constraints:
  //         BoxConstraints(maxHeight: media.height / 1.4, minWidth: media.width),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(32),
  //         topRight: Radius.circular(32),
  //       ),
  //     ),
  //     builder: (context) {
  //       return const AcceptScheduledRideRequestModal();
  //     },
  //   );
  // }

  // void showAcceptTodaysRideRequestsModal() {
  //   final media = MediaQuery.of(Get.context!).size;

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     context: Get.context!,
  //     showDragHandle: true,
  //     constraints:
  //         BoxConstraints(maxHeight: media.height / 1.4, minWidth: media.width),
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(32),
  //         topRight: Radius.circular(32),
  //       ),
  //     ),
  //     builder: (context) {
  //       return const AcceptTodaysRideRequestModal();
  //     },
  //   );
  // }

  //===============================  Bottom modal sheet =====================================\\

  // showHomeModalBottomSheet() {
  //   final media = MediaQuery.of(Get.context!).size;

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     constraints:
  //         BoxConstraints(maxHeight: media.height / 1.8, minWidth: media.width),
  //     enableDrag: true,
  //     context: Get.context!,
  //     useSafeArea: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(50),
  //         topRight: Radius.circular(50),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Obx(() {
  //         return HomeBottomModalSheet(displayInfo: showInfo.value);
  //       });
  //     },
  //   );
  // }

  //======================================== Scheduled Rides =========================================//
  // showScheduledRidesModal() {
  //   var media = MediaQuery.of(Get.context!).size;
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     context: Get.context!,
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
  //       return const ScheduledRideRequestsModal();
  //     },
  //   );
  // }

  //======================================== Today's Rides =========================================//
  // showTodaysRideRequestsModal() {
  //   var media = MediaQuery.of(Get.context!).size;
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     showDragHandle: true,
  //     enableDrag: true,
  //     context: Get.context!,
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
  //       return const TodaysRideRequestsModal();
  //     },
  //   );
  // }

  // void startRide() async {
  //   Get.off(
  //     () => const RideScreen(),
  //     routeName: "/ride",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     preventDuplicates: true,
  //     transition: Get.defaultTransition,
  //   );
  //   RideController.instance.showStartRide();
  // }
}
