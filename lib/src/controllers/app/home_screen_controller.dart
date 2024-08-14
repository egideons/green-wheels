import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/assets.dart';

class HomeScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

  late TabController tabBarController;
  var selectedTabBar = 0.obs;

  //================ Keys =================\\
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //================ Boolean =================\\
  var isRefreshing = false.obs;

  var isLocationPermissionGranted = false.obs;
  var showInfo = false.obs;
  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();

  GoogleMapController? newGoogleMapController;

//=================================== Ride tabs ==========================================\\
  List<Map<String, dynamic>> tabData(ColorScheme colorScheme) => [
        {
          'icon': Assets.carOutlineIconSvg,
          'label': 'Book a ride',
          'color': colorScheme.primary,
        },
        {
          'icon': Assets.scheduleRideOutlineIconSvg,
          'label': 'Schedule a trip',
          'color': colorScheme.primary,
        },
        {
          'icon': Assets.carOutlineIconSvg,
          'label': 'Rent a ride',
          'color': colorScheme.primary,
        },
      ];

//================ Select Tab =================//
  void clickOnTabBarOption(int index) {
    selectedTabBar.value = index;
  }

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

  @override
  void onClose() {
    tabBarController.dispose();
    super.onClose();
  }

  //======================================= Google Maps ================================================\\

  @override
  void onInit() {
    requestLocationPermission();
    tabBarController = TabController(length: 3, vsync: this);
    tabBarController.addListener(() {
      selectedTabBar.value = tabBarController.index;
    });
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
}
