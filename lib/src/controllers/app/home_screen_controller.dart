import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../app/home/modals/book_ride_request_accepted_modal.dart';
import '../../../app/home/modals/book_ride_searching_for_driver_modal.dart';
import '../../constants/assets.dart';

class HomeScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

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

  @override
  void onClose() {
    tabBarController.dispose();
    timer?.cancel();
    super.onClose();
  }

  late TabController tabBarController;
  var selectedTabBar = 0.obs;
  var progress = .0.obs;
  Timer? timer;

  // Position? userPosition;
  CameraPosition? cameraPosition;

  //================ Keys =================\\
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  //================ Boolean =================\\
  var isRefreshing = false.obs;
  var isLocationPermissionGranted = false.obs;
  var showInfo = false.obs;
  var isPickupLocationTextFieldActive = false.obs;
  var isDestinationTextFieldActive = false.obs;
  var isStopLocationVisible = false.obs;
  var isStopLocationTextFieldActive = false.obs;
  var mapSuggestionIsSelected = false.obs;
  var bookDriverTimerFinished = false.obs;
  var bookDriverFound = false.obs;

  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;
  var scrollController = ScrollController();
  var panelController = PanelController();

  final pickupLocationEC =
      TextEditingController(text: "Pin Plaza, 1st Avenue, Festac");
  final stop1LocationEC = TextEditingController();
  final stop2LocationEC = TextEditingController();
  final stop3LocationEC = TextEditingController();
  final destinationEC = TextEditingController();

  //================ Focus Nodes =================\\
  final pickupLocationFN = FocusNode();
  final stop1LocationFN = FocusNode();
  final stop2LocationFN = FocusNode();
  final stop3LocationFN = FocusNode();
  final destinationFN = FocusNode();

//================ Panel Functions =================\\
  togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  openPanel() => panelController.open();
  closePanel() => panelController.close();

//================ OnTap and Onchanged =================\\
  void selectPickupSuggestion() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void selectStopLocationSuggestion() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void selectDestinationSuggestion() async {
    mapSuggestionIsSelected.value = true;
    // FocusScope.of(Get.context!).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void destinationOnTap() async {
    isStopLocationVisible.value = true;
    mapSuggestionIsSelected.value = false;
  }

  pickupLocationOnChanged(value) {
    mapSuggestionIsSelected.value = false;

    // Check if the text field is empty
    if (value.isEmpty) {
      isPickupLocationTextFieldActive.value = false;
      isDestinationTextFieldActive.value = false;
    } else {
      if (stop1LocationEC.text.isEmpty) {
        isDestinationTextFieldActive.value = false;
        isStopLocationTextFieldActive.value = false;
        isPickupLocationTextFieldActive.value = true;
      } else {
        isDestinationTextFieldActive.value = false;
        isStopLocationTextFieldActive.value = true;
        isPickupLocationTextFieldActive.value = true;
      }
    }
  }

  destinationOnChanged(value) {
    mapSuggestionIsSelected.value = false;

    // Check if the text field is empty
    if (value.isEmpty) {
      isDestinationTextFieldActive.value = false;
    } else {
      if (stop1LocationEC.text.isEmpty) {
        isStopLocationTextFieldActive.value = false;
        isPickupLocationTextFieldActive.value = false;
        isDestinationTextFieldActive.value = true;
      } else {
        isStopLocationTextFieldActive.value = true;
        isPickupLocationTextFieldActive.value = false;
        isDestinationTextFieldActive.value = true;
      }
    }
  }

  stopLocationOnChanged(value) {
    mapSuggestionIsSelected.value = false;

    // Check if the text field is empty
    if (value.isEmpty) {
      isStopLocationTextFieldActive.value = false;
    } else {
      isDestinationTextFieldActive.value = false;
      isPickupLocationTextFieldActive.value = false;
      isStopLocationTextFieldActive.value = true;
    }
  }

//================ on Field Submitted =================\\
  onFieldSubmitted(value) {
    submitForm();
  }

//================ Submit Form =================\\
  Future<void> submitForm() async {
    await Future.delayed(const Duration(seconds: 1));
  }

//=================================== Ride tabs ==========================================\\
  List<Map<String, dynamic>> tabData(ColorScheme colorScheme) => [
        {
          'icon': Assets.carOutlineIconSvg,
          'label': 'Book',
          'color': colorScheme.primary,
        },
        {
          'icon': Assets.carCalendarOutlineIconSvg,
          'label': 'Schedule',
          'color': colorScheme.primary,
        },
        {
          'icon': Assets.carClockIconOutlineSvg,
          'label': 'Rent',
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
    // showHomeModalBottomSheet();

    // This will display info immediately and then hide it after 3 seconds
    displayInfo();
    await Future.delayed(const Duration(seconds: 3));
    hideInfo();
  }

  //==================================== Google Maps =========================================\\
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );
  // Future<void> loadMapData() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.',
  //     );
  //   }
  //   await _getAndGoToUserCurrentLocation();
  // }

  // Future<Position> _getAndGoToUserCurrentLocation() async {
  //   Position userLocation = await Geolocator.getCurrentPosition(
  //     locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  //     // desiredAccuracy: LocationAccuracy.high,
  //   ).then(
  //     (location) => userPosition = location,
  //   );

  //   LatLng latLngPosition =
  //       LatLng(userLocation.latitude, userLocation.longitude);

  //   cameraPosition = CameraPosition(target: latLngPosition, zoom: 20);

  //   newGoogleMapController?.animateCamera(
  //     CameraUpdate.newCameraPosition(cameraPosition!),
  //   );

  //   return userLocation;
  // }

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

  //==== Book Ride Section =========================================================================>

  //============== Progress Indicatior =================\\
  // Method to update the progress
  void updateProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      progress.value = value;
      log("Progress: ${progress.value}");
    }
  }

// Start the progress simulation with a Timer
  void simulateBookRideDriverSearchProgress() {
    progress.value = 0.0;
    driverHasArrived.value = false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (progress.value < 0.9) {
        updateProgress(progress.value + 0.1);
      } else {
        // Directly set progress to 1.0 on the last step
        updateProgress(1.0);
        bookDriverTimerFinished.value = true;
        bookDriverFound.value = true;
        update();
        log("Timer finished: ${bookDriverTimerFinished.value}");
        log("Driver found: ${bookDriverFound.value}");
        cancelProgress();
      }
    });
  }

  // Cancel the progress simulation
  void cancelProgress() {
    timer?.cancel();
  }

  void cancelBookRideDriverRequest() async {
    Get.close(0);
    progress.value = 0.0;
    bookDriverTimerFinished.value = false;
    bookDriverFound.value = false;
    update();

    await openPanel();
  }

  //=============================== Modal Bottom Sheets =====================================\\

  void showSearchingForDriverModalSheet() async {
    final media = MediaQuery.of(Get.context!).size;

    await closePanel();

    simulateBookRideDriverSearchProgress();

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: Get.context!,
      useSafeArea: true,
      isDismissible: false,
      constraints:
          BoxConstraints(maxHeight: media.height / 1.6, minWidth: media.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) {
        return const BookRideSearchingForDriverModal();
      },
    );
  }

  void showBookRideRequestAcceptedModal() async {
    final media = MediaQuery.of(Get.context!).size;

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      enableDrag: false,
      context: Get.context!,
      useSafeArea: true,
      isDismissible: false,
      constraints:
          BoxConstraints(maxHeight: media.height, minWidth: media.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      builder: (context) {
        return const BookRideRequestAcceptedModal();
      },
    );
  }

  var driverHasArrived = false.obs;

  runDriverHasArrived() {
    driverHasArrived.value = true;
  }

  //==== Schedule Trip =========================================================================>

  //==== Rent Ride =========================================================================>
}
