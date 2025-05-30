import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/app/google_maps/google_maps.dart';
import 'package:green_wheels/app/home/content/rent_ride/choose_available_vehicle_scaffold.dart';
import 'package:green_wheels/app/home/modals/book_ride_cancel_ride_fee_modal.dart';
import 'package:green_wheels/app/home/modals/trip_feedback_appreciation_dialog.dart';
import 'package:green_wheels/app/home/modals/trip_feedback_modal.dart';
import 'package:green_wheels/src/controllers/app/google_maps_controller.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:green_wheels/src/models/ride/accepted_ride_request_model.dart';
import 'package:green_wheels/src/models/ride/available_vehicles_response_model.dart';
import 'package:green_wheels/src/models/ride/driver_arrived_response_model.dart';
import 'package:green_wheels/src/models/ride/driver_location_updates_response_model.dart';
import 'package:green_wheels/src/models/ride/instant_ride_amount_response_model.dart';
import 'package:green_wheels/src/models/ride/rent_ride_vehicle_model.dart';
import 'package:green_wheels/src/models/ride/ride_completed_response_model.dart';
import 'package:green_wheels/src/models/ride/ride_started_response_model.dart';
import 'package:green_wheels/src/models/ride/shared_ride_request_response_model.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/book_instant_ride_web_socket_service.dart';
import 'package:green_wheels/src/services/client/book_shared_ride_web_socket_service.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:green_wheels/src/services/google_maps/autocomplete_prediction_model.dart';
import 'package:green_wheels/src/services/google_maps/location_service.dart';
import 'package:green_wheels/src/utils/components/animated_dialog.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../app/home/content/book_a_ride/book_ride_request_canceled_dialog.dart';
import '../../../app/home/content/rent_ride/rent_ride_booking_canceled_dialog.dart';
import '../../../app/home/content/rent_ride/rent_ride_booking_confirmed_modal.dart';
import '../../../app/home/content/schedule_a_trip/schedule_trip_intro_dialog.dart';
import '../../../app/home/content/school_commute/school_commute_intro_dialog.dart';
import '../../../app/home/modals/book_ride_cancel_request_modal.dart';
import '../../../app/home/modals/book_ride_searching_for_driver_modal.dart';
import '../../../app/menu/screen/menu_screen.dart';
import '../../../app/schedule_trip/screen/schedule_trip_screen.dart';
import '../../../app/school_commute/screen/school_commute_screen.dart';
import '../../../app/splash/loading/screen/loading_screen.dart';
import '../../../main.dart';
import '../../constants/assets.dart';
import '../../constants/consts.dart';
import '../others/loading_controller.dart';

class HomeScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

  @override
  void onInit() {
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
    bookRideTimer?.cancel();
    _sharedRideWaitingTimer?.cancel();
    super.onClose();
  }

  //================ Variables =================\\
  var infoMessage = "".obs;
  var pinnedLocation = "".obs;
  var driverName = "".obs;
  var driverPhoneNumber = "".obs;
  var driverRating = 0.obs;
  var driverTotalRides = 0.obs;
  var vehicleImage = Assets.vehiclePng;
  late LatLng draggedLatLng;
  var markers = <Marker>[].obs;
  var locationPinBottomPadding = 50.0.obs;

  final List<MarkerId> markerId = <MarkerId>[
    const MarkerId("RiderID"),
  ];
  List<String>? markerTitle;
  List<String>? markerSnippet;
  List<String> customMarkers = <String>[Assets.personLocationPng];
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var riderModel = RiderModel.fromJson(null).obs;
  var acceptedRideResponse = AcceptedRideRequestModel.fromJson(null).obs;
  var driverLocationUpdatesResponse =
      DriverLocationUpdateResponseModel.fromJson(null).obs;
  var driverArrivedResponse = DriverArrivedResponseModel.fromJson(null).obs;
  var rideStartedResponseModel = RideStartedResponseModel.fromJson(null).obs;
  var rideCompletedResponseModel =
      RideCompletedResponseModel.fromJson(null).obs;

  late TabController tabBarController;
  var selectedTabBar = 0.obs;

  Rx<Position?> userPosition = Rx<Position?>(null);
  CameraPosition? cameraPosition;

  //================ Keys =================\\
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final bookRideFormKey = GlobalKey<FormState>();
  final bookSharedRideFormKey = GlobalKey<FormState>();

  //================ Boolean =================\\
  var showInfo = false.obs;
  var routeIsVisible = false.obs;

  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

  var homePanelController = PanelController();
  var ridePanelController = PanelController();

//================ Panel Functions =================\\
  togglePanel() => homePanelController.isPanelOpen
      ? homePanelController.close()
      : homePanelController.open();

  closeHomePanel() => homePanelController.close();
  openHomePanel() => homePanelController.open();

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
    if (homePanelController.isPanelClosed) openHomePanel();
  }

  //=============================== Open Drawer =====================================\\

  void goToMenu() {
    Get.to(
      () => const MenuScreen(),
      transition: Transition.rightToLeft,
      routeName: "/menu",
      curve: Curves.easeInOut,
      fullscreenDialog: true,
      popGesture: true,
      preventDuplicates: true,
    );
  }

  //=============================== Init Functions =====================================\\
  //Get Rider  Details
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

  Future<void> initFunctions() async {
    infoMessage.value =
        "Please note that every vehicle has a security camera for safety reasons.";
    await Future.delayed(const Duration(seconds: 5));
    infoMessage.value = "";
    var loadDriverDetails = await getRiderProfile();

    if (loadDriverDetails) {
      pinnedLocation.value = "";
      markerTitle = <String>["Me"];
      markerSnippet = <String>["My Location"];
      await loadMapData();

      log("User Position: ${userPosition.value}");
      log("User pickupLocation: ${pickupLocationEC.text}");
    }
  }

  //==================================== Google Maps =========================================\\

  Future<void> loadMapData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      ApiProcessorController.errorSnack("Please enable location services");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        ApiProcessorController.errorSnack(
          "Could not retrieve your location.\nPlease enable location services",
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    await startRiderLocationUpdates();
    await getAndGoToUserCurrentLocation();
    // await loadCustomMarkers();
  }

  Future<Position> getAndGoToUserCurrentLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    userPosition.value = userLocation;

    LatLng latLngPosition =
        LatLng(userLocation.latitude, userLocation.longitude);
    cameraPosition = CameraPosition(target: latLngPosition, zoom: 12);

    newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition!),
    );

    pickupLat = userLocation.latitude.toString();
    pickupLong = userLocation.longitude.toString();

    pickupSharedLat = userLocation.latitude.toString();
    pickupSharedLong = userLocation.longitude.toString();
    destinationSharedLat = "6.45612277432871";
    destinationSharedLong = "7.507697509076796";
    destinationSharedLocation.value =
        "1st Floor Suite 09, Swissgarde Plaza, Ogui Rd, Achara, Enugu 400102, Enugu";
    sharedDestinationEC.text = destinationSharedLocation.value;

    log("User Position: $userLocation");
    log("Pickup Location: Latitude: $pickupLat, Longitude: $pickupLong");

    getInitialPlaceMark(latLngPosition);

    return userLocation;
  }

  Future<void> getInitialPlaceMark(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addressStr =
        "${address.name} ${address.street}, ${address.locality}, ${address.country}";
    pinnedLocation.value = addressStr;
    await Future.delayed(const Duration(milliseconds: 400));
    pickupLocationEC.text = pinnedLocation.value;
    pickupSharedLocationEC.text = pinnedLocation.value;

    log("LatLng: ${LatLng(position.latitude, position.longitude)}");
    log("PinnedLocation: $addressStr");
    log("Pickup Location EC: ${pickupLocationEC.text}");
  }
  //====================================== Get bytes from assets =========================================\\

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //====================================== Get Location Markers =========================================\\

  // Future<void> loadCustomMarkers() async {
  //   Position userLocation = await Geolocator.getCurrentPosition(
  //     locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
  //   );
  //   userPosition.value = userLocation;

  //   List<LatLng> latLng = <LatLng>[
  //     LatLng(userLocation.latitude, userLocation.longitude),
  //   ];
  //   for (int i = 0; i < customMarkers.length; i++) {
  //     final Uint8List markerIcon =
  //         await getBytesFromAssets(customMarkers[i], 100);

  //     markers.add(
  //       Marker(
  //         markerId: markerId[i],
  //         icon: BitmapDescriptor.bytes(markerIcon, height: 40),
  //         position: latLng[i],
  //         infoWindow: InfoWindow(
  //           title: markerTitle![i],
  //           snippet: markerSnippet![i],
  //         ),
  //       ),
  //     );
  //   }
  // }

  void onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  Timer? _riderLocationUpdateTimer;

  Future<void> startRiderLocationUpdates() async {
    _riderLocationUpdateTimer?.cancel(); // Ensure any existing timer is stopped
    _riderLocationUpdateTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      await updateRiderLocationAndMarker();
    });
  }

  void stopRiderLocationUpdates() {
    _riderLocationUpdateTimer?.cancel();
    _riderLocationUpdateTimer = null;
  }

  void restartRiderLocationUpdates() {
    stopRiderLocationUpdates();
    startRiderLocationUpdates();
  }

  Future<void> updateRiderLocationAndMarker() async {
    Position riderLocation = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    LatLng latLngPosition = LatLng(
      riderLocation.latitude,
      riderLocation.longitude,
    );

    // Create a unique marker for the driver
    final Uint8List markerIcon =
        await getBytesFromAssets(Assets.personLocationPng, 100);
    final Marker riderMarker = Marker(
      markerId: const MarkerId("RiderID"),
      icon: BitmapDescriptor.bytes(markerIcon, height: 40),
      position: latLngPosition,
      infoWindow: const InfoWindow(title: "Me", snippet: "My Location"),
    );

    // Remove existing driver marker before adding a new one
    if (markerId.isNotEmpty) {
      markers.removeWhere((marker) => marker.markerId.value == "RiderID");
    }

    // Ensure only 3 markers exist by adding the updated driver marker
    markers.add(riderMarker);

    cameraPosition = CameraPosition(target: latLngPosition, zoom: 16);

    // newGoogleMapController?.animateCamera(
    //   CameraUpdate.newCameraPosition(cameraPosition!),
    // );

    log(
      "Markers Updated: ${markers.length}",
      name: "Markers",
    );
  }

  //!============ Book Instant Ride Section ==========================================================>

  //================ Variables =================\\
  Timer? bookRideTimer;
  String pickupLat = "";
  String pickupLong = "";
  String destinationLat = "";
  String destinationLong = "";
  var pickupLocation = "".obs;
  var stopLocation1 = "".obs;
  var destinationLocation = "".obs;
  var estimatedInstantRideDistance = "".obs;
  var paymentType = "Green Wallet".obs;
  var progress = 0.0.obs;
  var estimatedInstantRideTime = 0.obs;
  var instantRideAmount = 0.0.obs;
  var sharedRideIsSelected = false.obs;
  var selectInstantBookOptionPageController = PageController();

  //================ Controllers =================\\
  var pickupLocationEC = TextEditingController();
  var destinationEC = TextEditingController();

  //================ Focus Nodes =================\\
  var pickupLocationFN = FocusNode();
  var destinationFN = FocusNode();

  //================ Models =================\\
  var instantRideAmountResponseModel =
      InstantRideAmountResponseModel.fromJson(null).obs;
  var instantRideData = InstantRideData.fromJson(null).obs;
  var priceBreakdown = PriceBreakdown.fromJson(null).obs;

  //================ Variables =================\\

  //================ Booleans =================\\
  var bookDriverTimerFinished = false.obs;
  var bookDriverFound = false.obs;
  var driverHasArrived = false.obs;
  var isBookingInstantRide = false.obs;

  goToPersonalRide() async {
    sharedRideIsSelected.value = false;
    await Future.delayed(const Duration(milliseconds: 200));
    selectInstantBookOptionPageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  goToSharedRide() async {
    sharedRideIsSelected.value = true;
    await Future.delayed(const Duration(milliseconds: 200));
    selectInstantBookOptionPageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  goBackToSelectInstantBookOption() async {
    selectInstantBookOptionPageController.animateToPage(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  //!================== Goto Google Maps ========================\\

  setPickupGoogleMapsLocation() async {
    var latitude = double.tryParse(pickupLat)!;
    var longitude = double.tryParse(pickupLong)!;
    final result = await Get.to(
      () => GoogleMaps(
        latitude: latitude,
        longitude: longitude,
      ),
      routeName: '/google-maps',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
      binding: BindingsBuilder(() => Get.lazyPut<GoogleMapsController>(
            () => GoogleMapsController(),
          )),
    );

    if (result != null) {
      final latitude = result["latitude"];
      final longitude = result["longitude"];
      final address = result["address"];

      pickupLocationEC.text = address;
      pickupLocation.value = address;
      pickupLat = latitude;
      pickupLong = longitude;

      log(
        "This are the result details:\nAddress: ${pickupLocation.value}\nLatitude: $pickupLat\nLongitude: $pickupLong",
      );
      if (pickupLocationEC.text.isNotEmpty &&
          destinationEC.text.isNotEmpty &&
          pickupLat.isNotEmpty &&
          destinationLat.isNotEmpty) {
        getRideAmount(
          pickup: pickupLocationEC.text,
          pickupLat: pickupLat,
          pickupLong: pickupLong,
          destination: destinationEC.text,
          destinationLat: destinationLat,
          destinationLong: destinationLong,
        );

        await Future.delayed(const Duration(seconds: 1));
        routeIsVisible.value = false;
        // Position userLocation = await Geolocator.getCurrentPosition(
        //   locationSettings:
        //       const LocationSettings(accuracy: LocationAccuracy.high),
        // );

        List<LatLng> latLng = <LatLng>[
          LatLng(double.tryParse(pickupLat)!, double.tryParse(pickupLong)!),
          LatLng(
            double.tryParse(destinationLat) ?? .0,
            double.tryParse(destinationLong) ?? .0,
          ),
        ];

        // Reset lists before inserting new values
        markerId.clear();
        customMarkers = <String>[Assets.locationPin1Png];
        markerTitle = <String>["Destination"];
        markerSnippet = <String>[destinationEC.text];

        // Insert new elements
        customMarkers.insert(0, Assets.locationPinPng);
        markerId.add(const MarkerId("DestinationID"));
        markerId.add(const MarkerId("PickupLocationID"));
        markerTitle?.insert(0, "Pickup Location");
        markerSnippet?.insert(0, pickupLocationEC.text);

        log(
          "Custom Markers: $customMarkers, Marker IDs: $markerId, Marker Snippets: $markerSnippet",
          name: "Markers",
        );

        markers.clear();

        for (int i = 0; i < customMarkers.length; i++) {
          final Uint8List markerIcon =
              await getBytesFromAssets(customMarkers[i], 100);

          markers.add(
            Marker(
              markerId: markerId[i],
              icon: BitmapDescriptor.bytes(markerIcon, height: 40),
              position: latLng[i],
              infoWindow: InfoWindow(
                title: markerTitle![i],
                snippet: markerSnippet![i],
              ),
            ),
          );
        }

        getPolyPoints(
          destinationLat: double.tryParse(destinationLat)!,
          destinationLong: double.tryParse(destinationLong)!,
          pickupLat: double.tryParse(pickupLat)!,
          pickupLong: double.tryParse(pickupLong)!,
          polylineCoordinates: polylineCoordinates,
        );

        LatLng pickupLatLngPostion = LatLng(
          double.tryParse(pickupLat)!,
          double.tryParse(pickupLong)!,
        );

        cameraPosition = CameraPosition(target: pickupLatLngPostion, zoom: 16);

        newGoogleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition!),
        );
        await Future.delayed(const Duration(seconds: 1));
        routeIsVisible.value = true;
        update();
      } else {
        LatLng pickupLatLngPostion = LatLng(
          double.tryParse(pickupLat)!,
          double.tryParse(pickupLong)!,
        );
        // Create a unique marker for the driver
        final Uint8List markerIcon =
            await getBytesFromAssets(Assets.locationPinPng, 100);
        final Marker pickupMarker = Marker(
          markerId: const MarkerId("PickupLocationID"),
          icon: BitmapDescriptor.bytes(markerIcon, height: 40),
          position: pickupLatLngPostion,
          infoWindow: InfoWindow(
            title: "Pickup Location",
            snippet: pickupLocationEC.text,
          ),
        );

        // Remove existing driver marker before adding a new one
        if (markerId.isNotEmpty) {
          markers.removeWhere(
            (marker) => marker.markerId.value == "PickupLocationID",
          );
        }

        // Ensure only 3 markers exist by adding the updated driver marker
        markers.add(pickupMarker);

        routeIsVisible.value = false;
        cameraPosition = CameraPosition(target: pickupLatLngPostion, zoom: 16);

        newGoogleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition!),
        );
      }
    }
  }

  setDestinationGoogleMapsLocation() async {
    final result = await Get.to(
      () => GoogleMaps(
        latitude: destinationLat.isNotEmpty
            ? double.tryParse(destinationLat)!
            : userPosition.value!.latitude,
        longitude: destinationLong.isNotEmpty
            ? double.tryParse(destinationLong)!
            : userPosition.value!.longitude,
      ),
      routeName: '/google-maps',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
      binding: BindingsBuilder(() => Get.lazyPut<GoogleMapsController>(
            () => GoogleMapsController(),
          )),
    );

    if (result != null) {
      final latitude = result["latitude"];
      final longitude = result["longitude"];
      final address = result["address"];

      destinationEC.text = address;
      destinationLocation.value = address;
      destinationLat = latitude;
      destinationLong = longitude;

      log(
        "This are the result details:\nAddress: ${destinationLocation.value}\nLatitude: $destinationLat\nLongitude: $destinationLong",
      );

      if (pickupLocationEC.text.isNotEmpty &&
          destinationEC.text.isNotEmpty &&
          pickupLat.isNotEmpty &&
          destinationLat.isNotEmpty) {
        getRideAmount(
          pickup: pickupLocationEC.text,
          pickupLat: pickupLat,
          pickupLong: pickupLong,
          destination: destinationEC.text,
          destinationLat: destinationLat,
          destinationLong: destinationLong,
        );
        await Future.delayed(const Duration(seconds: 1));
        routeIsVisible.value = false;
        // Position userLocation = await Geolocator.getCurrentPosition(
        //   locationSettings:
        //       const LocationSettings(accuracy: LocationAccuracy.high),
        // );

        List<LatLng> latLng = <LatLng>[
          LatLng(
            double.tryParse(pickupLat)!,
            double.tryParse(pickupLong)!,
          ),
          LatLng(
            double.tryParse(destinationLat) ?? .0,
            double.tryParse(destinationLong) ?? .0,
          ),
        ];

        // Reset lists before inserting new values
        markerId.clear();
        customMarkers = <String>[Assets.locationPin1Png];
        markerTitle = <String>["Destination"];
        markerSnippet = <String>[destinationEC.text];

        // Insert new elements
        customMarkers.insert(0, Assets.locationPinPng);
        markerId.add(const MarkerId("DestinationID"));
        markerId.add(const MarkerId("PickupLocationID"));
        markerTitle?.insert(0, "Pickup Location");
        markerSnippet?.insert(0, pickupLocationEC.text);

        log(
          "Custom Markers: $customMarkers, Marker IDs: $markerId, Marker Snippets: $markerSnippet",
          name: "Markers",
        );

        markers.clear();

        for (int i = 0; i < customMarkers.length; i++) {
          final Uint8List markerIcon =
              await getBytesFromAssets(customMarkers[i], 100);

          markers.add(
            Marker(
              markerId: markerId[i],
              icon: BitmapDescriptor.bytes(markerIcon, height: 40),
              position: latLng[i],
              infoWindow: InfoWindow(
                title: markerTitle![i],
                snippet: markerSnippet![i],
              ),
            ),
          );
        }

        getPolyPoints(
          destinationLat: double.tryParse(destinationLat)!,
          destinationLong: double.tryParse(destinationLong)!,
          pickupLat: double.tryParse(pickupLat)!,
          pickupLong: double.tryParse(pickupLong)!,
          polylineCoordinates: polylineCoordinates,
        );
        LatLng destinationLatLngPosition = LatLng(
          double.tryParse(destinationLat)!,
          double.tryParse(destinationLong)!,
        );

        cameraPosition =
            CameraPosition(target: destinationLatLngPosition, zoom: 16);

        newGoogleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition!),
        );
        await Future.delayed(const Duration(seconds: 1));
        routeIsVisible.value = true;
        update();
      } else {
        LatLng destinationLatLngPostion = LatLng(
          double.tryParse(pickupLat)!,
          double.tryParse(pickupLong)!,
        );
        // Create a unique marker for the driver
        final Uint8List markerIcon =
            await getBytesFromAssets(Assets.locationPin1Png, 100);
        final Marker destinationMarker = Marker(
          markerId: const MarkerId("DestinationID"),
          icon: BitmapDescriptor.bytes(markerIcon, height: 40),
          position: destinationLatLngPostion,
          infoWindow: InfoWindow(
            title: "Destination",
            snippet: destinationEC.text,
          ),
        );

        // Remove existing driver marker before adding a new one
        if (markerId.isNotEmpty) {
          markers.removeWhere(
            (marker) => marker.markerId.value == "DestinationID",
          );
        }

        // Ensure only 3 markers exist by adding the updated driver marker
        markers.add(destinationMarker);

        routeIsVisible.value = false;
        cameraPosition =
            CameraPosition(target: destinationLatLngPostion, zoom: 16);

        newGoogleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition!),
        );
      }
    }
  }

//! Ride Amount
  getRideAmount({
    String? pickup,
    String? pickupLat,
    String? pickupLong,
    String? destination,
    String? destinationLat,
    String? destinationLong,
  }) async {
    var url = ApiUrl.baseUrl + ApiUrl.rideAmount;

    var userToken = prefs.getString("userToken");

    var data = {
      "type": "instant",
      "pickup_location": {
        "address": pickup,
        "lat": pickupLat,
        "long": pickupLong,
      },
      "destination": {
        "address": destination,
        "lat": destinationLat,
        "long": destinationLong,
      }
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken"
    };

    //HTTP Client Service
    http.Response? response =
        // await HttpClientService.postRequest(url, userToken, data);
        await HttpClientService.postRequest(url, userToken, data, headers);

    log("Encoded Data: ${jsonEncode(data)}");

    log("URL=> $url\nUSERTOKEN=>$userToken\nData=>$data");

    if (response == null) {
      return;
    }

    try {
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      log("$responseJson", name: "Get Ride Amount Response");

      if (response.statusCode == 200) {
        instantRideAmountResponseModel.value =
            InstantRideAmountResponseModel.fromJson(responseJson);
        instantRideData.value = instantRideAmountResponseModel.value.data;
        priceBreakdown.value =
            instantRideAmountResponseModel.value.data.priceBreakdown;

        instantRideAmount.value = instantRideData.value.amount;

        calculateReadableTravelTime(
          priceBreakdown.value.distanceInMeters,
          estimatedInstantRideTime.value,
        );

        await Future.delayed(const Duration(milliseconds: 300));

        // FocusScope.of(Get.context!).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
      } else {
        ApiProcessorController.errorSnack("An error occured");
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log("This is the error:$e");
    }
  }

  //! WebSocket Service instance
  BookInstantRideReverbWebSocketService? bookInstantRideWebSocketService;

  Future<void> bookInstantRide() async {
    var url = ApiUrl.baseUrl + ApiUrl.bookInstantRide;

    var userToken = prefs.getString("userToken") ?? "";
    isBookingInstantRide.value = true;

    Map<String, dynamic> data = {
      "pickup_location": {
        "address": pickupLocationEC.text,
        "lat": pickupLat,
        "long": pickupLong,
      },
      "destination": {
        "address": destinationEC.text,
        "lat": destinationLat,
        "long": destinationLong,
      },
      "payment_type": "wallet",
    };

    log("URL=> $url\nUSERTOKEN=>$userToken\nData=>$data");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken"
    };

    //HTTP Client Service
    http.Response? response =
        // await HttpClientService.postRequest(url, userToken, data);
        await HttpClientService.postRequest(url, userToken, data, headers);

    if (response == null) {
      isBookingInstantRide.value = false;
      return;
    }

    try {
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      log("This is the responseJson: $responseJson\nResponse status code: ${response.statusCode}",
          name: "Book Instant Ride");

      if (response.statusCode == 201) {
        ApiProcessorController.successSnack("${responseJson["message"]}");
        isBookingInstantRide.value = false;

        bookInstantRideWebSocketService = BookInstantRideReverbWebSocketService(
          riderUUID: riderModel.value.riderUuid,
          authToken: userToken,
        );

        final websocketIsConnected =
            await bookInstantRideWebSocketService!.connect();
        log("Websocket is connected: $websocketIsConnected");

        if (websocketIsConnected) {
          showSearchingForDriverModalSheet();
          await bookRideAwaitDriverResponseTimer();
        } else {
          bookInstantRideWebSocketService?.disconnect();
          bookInstantRideWebSocketService = null; // Cleanup
        }
      } else {
        ApiProcessorController.warningSnack("${responseJson["message"]}");
        log(responseJson.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    isBookingInstantRide.value = false;
  }

  Future<void> retryBookInstantRide() async {
    Get.close(0);
    bookDriverTimerFinished.value = false;
    await bookInstantRide();
  }

  //! Update ride request data when a new message is received
  void updateRequestResponse(AcceptedRideRequestModel requestResponse) async {
    acceptedRideResponse.value = requestResponse;

    driverName.value =
        "${acceptedRideResponse.value.driver.firstName} ${acceptedRideResponse.value.driver.lastName}";
    driverPhoneNumber.value = acceptedRideResponse.value.driver.phone;
    driverRating.value =
        ((acceptedRideResponse.value.driver.rating).round()).toInt();
    driverTotalRides.value = acceptedRideResponse.value.driver.totalRides;
    estimatedInstantRideTime.value =
        acceptedRideResponse.value.data.estimatedTime;
    estimatedInstantRideDistance.value =
        acceptedRideResponse.value.data.distance;
    paymentType.value = acceptedRideResponse.value.data.paymentType;

    bookDriverTimerFinished.value = true;
    bookDriverFound.value = true;

    await Future.delayed(const Duration(milliseconds: 800), () {
      showBookRideRequestAcceptedPanel();
    });
    cancelProgress();
  }

  //! Update Driver Location
  void updateDriverLocationResponse(
      DriverLocationUpdateResponseModel response) async {
    driverLocationUpdatesResponse.value = response;

    LatLng driverLatLng = LatLng(
      response.driverLocation.lat,
      response.driverLocation.long,
    );

    // Create a unique marker for the driver
    final Uint8List markerIcon =
        await getBytesFromAssets(Assets.vehiclePng, 100);
    final Marker driverMarker = Marker(
      markerId: const MarkerId("DriverID"),
      icon: BitmapDescriptor.bytes(markerIcon, height: 40),
      position: driverLatLng,
      infoWindow: const InfoWindow(title: "Driver"),
    );

    // Remove existing driver marker before adding a new one
    markers.removeWhere((marker) => marker.markerId.value == "DriverID");

    // Ensure only 3 markers exist by adding the updated driver marker
    markers.add(driverMarker);

    log(
      "Markers Updated: ${markers.length}",
      name: "Markers",
    );

    routeIsVisible.value = true;
    if (driverLocationUpdatesResponse.value.hasArrived) {
      driverHasArrived.value = true;
    } else {
      driverHasArrived.value = false;
    }
    update();
  }

  //! Update Driver Arrived Response
  void updateDriverArrivedResponse(DriverArrivedResponseModel response) async {
    driverArrivedResponse.value = response;

    LatLng driverLatLng = LatLng(
      driverLocationUpdatesResponse.value.driverLocation.lat,
      driverLocationUpdatesResponse.value.driverLocation.long,
    );

    // Create a unique marker for the driver
    final Uint8List markerIcon =
        await getBytesFromAssets(Assets.vehiclePng, 100);
    final Marker driverMarker = Marker(
      markerId: const MarkerId("DriverID"),
      icon: BitmapDescriptor.bytes(markerIcon, height: 40),
      position: driverLatLng,
      infoWindow: const InfoWindow(title: "Driver"),
    );

    // Remove existing driver marker before adding a new one
    markers.removeWhere((marker) => marker.markerId.value == "DriverID");

    // Ensure only 3 markers exist by adding the updated driver marker
    markers.add(driverMarker);

    log(
      "Markers Updated: ${markers.length}",
      name: "Markers",
    );

    driverHasArrived.value = true;

    routeIsVisible.value = true;
    update();
  }

  var rideStarted = false.obs;
  var rideInfoMessage = "".obs;

  void rideStartedResponse(RideStartedResponseModel response) async {
    rideStartedResponseModel.value = response;
    rideStarted.value = true;
    rideInfoMessage.value = "Your Ride has started";

    await Future.delayed(const Duration(seconds: 30));

    rideInfoMessage.value = "Ride is ongoing";
    update();
  }

  var rideCompleted = false.obs;
  void rideCompletedResponse(RideCompletedResponseModel response) async {
    rideCompletedResponseModel.value = response;
    rideCompleted.value = true;
    rideInfoMessage.value = "Your Ride has been completed";

    ApiProcessorController.normalSnack(
      "Ride Charge has been deducted from your wallet",
    );
    update();
  }

  Future<void> bookRideAwaitDriverResponseTimer() async {
    progress.value = 0.0;
    const totalDuration = 60; // Total time in seconds
    final startTime = DateTime.now();

    bookRideTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsedTime = DateTime.now().difference(startTime).inSeconds;
      progress.value = (elapsedTime / totalDuration).clamp(0.0, 1.0);
      progress.refresh(); // Ensure UI updates

      if (elapsedTime >= totalDuration) {
        progress.value = 1.0;
        bookDriverTimerFinished.value = true;
        log("Timer finished: ${bookDriverTimerFinished.value}");
        cancelProgress();
        timer.cancel(); // Stop the timer when done
      }
    });
  }

  // Cancel the progress simulation
  void cancelProgress() {
    bookRideTimer?.cancel();
  }

  var cancelRequestSubmitButtonIsEnabled = false.obs;
  var cancelRequestFormKey = GlobalKey<FormState>();
  var isOtherSelected = false.obs;
  var otherOptionEC = TextEditingController();
  var otherOptionFN = FocusNode();
  var cancelRequestReasons = [
    "Waited for a long time",
    "Unable to contact the driver",
    "Wrong location inputted",
    "Other",
  ];
  // List to hold the state of each checkbox
  var cancelRequestReasonIsSelected = [false, false, false, false].obs;

  // Function to toggle the state of the checkboxes
  void toggleSelection(int index) {
    if (index == 3) {
      // "Other" checkbox
      cancelRequestReasonIsSelected[0] = false;
      cancelRequestReasonIsSelected[1] = false;
      cancelRequestReasonIsSelected[2] = false;
      cancelRequestReasonIsSelected[3] = !cancelRequestReasonIsSelected[3];
      cancelRequestSubmitButtonIsEnabled.value = false;
    } else {
      cancelRequestReasonIsSelected[3] = false; // Uncheck "Other"
      cancelRequestReasonIsSelected[index] =
          !cancelRequestReasonIsSelected[index];
      cancelRequestSubmitButtonIsEnabled.value = true;
    }
  }

  otherOptionOnchanged(String value) {
    if (value.isEmpty) {
      cancelRequestSubmitButtonIsEnabled.value = false;
    } else {
      cancelRequestSubmitButtonIsEnabled.value = true;
    }
  }

  Future<void> submitCancelRequestReason() async {
    if (cancelRequestFormKey.currentState!.validate()) {
      cancelRequestFormKey.currentState!.save();

      if (cancelRequestReasonIsSelected[3] == true &&
          otherOptionEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Field cannot be empty");
        return;
      }

      List<String> selectedValues = [];

      if (cancelRequestReasonIsSelected[0]) {
        selectedValues.add("Waited for a long time");
      }
      if (cancelRequestReasonIsSelected[1]) {
        selectedValues.add("Unable to contact the Driver");
      }
      if (cancelRequestReasonIsSelected[2]) {
        selectedValues.add("Wrong location inputted");
      }
      if (cancelRequestReasonIsSelected[3]) {
        selectedValues.add(otherOptionEC.text); // "Other" text
      }

      // Log or process the selected values
      log("Selected Values: $selectedValues");

      await showBookRideRequestCanceledDialog();
    }
  }

  Future<void> submitCancelRideReason() async {
    if (cancelRequestFormKey.currentState!.validate()) {
      cancelRequestFormKey.currentState!.save();

      if (cancelRequestReasonIsSelected[3] == true &&
          otherOptionEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Field cannot be empty");
        return;
      }

      List<String> selectedValues = [];

      if (cancelRequestReasonIsSelected[0]) {
        selectedValues.add("Waited for a long time");
      }
      if (cancelRequestReasonIsSelected[1]) {
        selectedValues.add("Unable to contact the Driver");
      }
      if (cancelRequestReasonIsSelected[2]) {
        selectedValues.add("Wrong location inputted");
      }
      if (cancelRequestReasonIsSelected[3]) {
        selectedValues.add(otherOptionEC.text); // "Other" text
      }

      // Log or process the selected values
      log("Selected Values: $selectedValues");

      await showBookRideRequestCanceledDialog();
    }
  }

  void cancelBookRideDriverRequest() async {
    final media = MediaQuery.of(Get.context!).size;

    // Get.close(0);

    if (bookDriverFound.value == true ||
        bookDriverTimerFinished.value == true) {
      progress.value = 0.0;
      bookDriverTimerFinished.value = false;
      bookDriverFound.value = false;
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      context: Get.context!,
      useSafeArea: true,
      isDismissible: false,
      constraints:
          BoxConstraints(maxHeight: media.height, minWidth: media.width),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(32),
      //     topRight: Radius.circular(32),
      //   ),
      // ),
      builder: (context) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: const BookRideCancelRequestModal(),
        );
      },
    );
  }

  showBookRideRequestCanceledDialog() {
    showDialog(
      context: Get.context!,
      barrierColor: kBlackColor.withValues(),
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          alignment: Alignment.center,
          elevation: 50,
          child: const BookRideRequestCanceledDialog(),
        );
      },
    );
  }

  goToHomeScreen() async {
    bookInstantRideWebSocketService?.disconnect();
    bookSharedRideWebSocketService?.disconnect();

    stopRiderLocationUpdates();
    await Get.offAll(
      () => LoadingScreen(
        loadData: LoadingController.instance.loadHomeScreen,
      ),
      routeName: "/home",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }

  //!=============================== Modal Bottom Sheets =====================================\\

  void showSearchingForDriverModalSheet() async {
    final media = MediaQuery.of(Get.context!).size;

    bookDriverFound.value = false;

    await closeHomePanel();

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: false,
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

  var ridePanelIsVisible = false.obs;
  void showBookRideRequestAcceptedPanel() async {
    Get.close(0);

    ridePanelIsVisible.value = true;

    await Future.delayed(const Duration(milliseconds: 500));
    ridePanelController.open();
  }

  showCancellationFeeModal() async {
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
        return const BookRideCancelRideFeeModal();
      },
    );
  }

  //===================================== Feedback Section ======================================\\
  var rating = 0.0.obs;

//====================== BOOL VALUES =======================\\
  var hasRated = false.obs;
  var submittingRequest = false.obs;
  var feedbackTextFieldIsActive = false.obs;

//========================== KEYS ===========================\\
  final formKey = GlobalKey<FormState>();

//======================= CONTROLLERS ========================\\
  final ratingPageController = PageController();
  final feedbackMessageEC = TextEditingController();

//====================== FOCUS NODES ==========================\\
  final feedbackMessageFN = FocusNode();

  giveFeedback() async {
    var context = Get.context!;
    hasRated.value = false;
    rating.value = 0.0;
    feedbackMessageEC.text.isEmpty ? null : feedbackMessageEC.clear();

    // Get.close(0);
    final media = MediaQuery.of(context).size;

    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      showDragHandle: true,
      context: context,
      barrierColor: kTransparentColor,
      useSafeArea: true,
      constraints:
          BoxConstraints(maxHeight: media.height, minWidth: media.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (context) {
        return const TripFeedbackModal();
      },
    );
  }

  rateRide(Size media, int index) {
    rating.value = index + 1;
    hasRated.value = true;
  }

  activateFeedbackTextField() {
    feedbackTextFieldIsActive.value = true;
  }

  deactivateFeedbackTextField(event) {
    feedbackTextFieldIsActive.value = false;
  }

  Future<void> submitFeedback() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // if (feedbackMessageEC.text.isEmpty) {
      //   ApiProcessorController.errorSnack("Field cannot be empty");
      //   return;
      // }
      submittingRequest.value = true;
      rideStarted.value = false;
      ridePanelIsVisible.value = false;
      ridePanelController.close();
      await Future.delayed(const Duration(seconds: 3));
      submittingRequest.value = false;
      showTripFeedbackAppreciationDialog();
    }
  }

  showTripFeedbackAppreciationDialog() {
    var context = Get.context!;
    Get.close(0);
    showAnimatedDialog(
      context: context,
      child: Dialog(
        insetAnimationCurve: Curves.easeIn,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        alignment: Alignment.center,
        elevation: 50,
        child: const TripFeedbackAppreciationDialog(),
      ),
    );
  }

  //!==== Shared Ride ==============================================================>
  //================ Variables =================\\
  String pickupSharedLat = "";
  String pickupSharedLong = "";
  String destinationSharedLat = "";
  String destinationSharedLong = "";
  var pickupSharedLocation = "".obs;
  var destinationSharedLocation = "".obs;
  var estimatedInstantSharedRideDistance = "".obs;
  var estimatedInstantSharedRideTime = 0.obs;
  var instantSharedRideAmount = 0.0.obs;

  //================ Booleans =================\\
  var shareRideButtonIsVisible = false.obs;
  var initiatingSharedRide = false.obs;
  var sharedRidePanelIsVisible = false.obs;
  var sharedRidePanelIsOpen = false.obs;

  //================ Controllers =================\\
  var pickupSharedLocationEC = TextEditingController();
  var sharedDestinationEC = TextEditingController();
  var sharedRidePanelController = PanelController();

  //================ Focus Nodes =================\\
  var pickupSharedLocationFN = FocusNode();
  var sharedDestinationFN = FocusNode();

  //================ Models =================\\
  var sharedRideRequestResponseModel =
      SharedRideRequestResponseModel.fromJson(null).obs;

  setSharedPickupGoogleMapsLocation() async {
    var latitude = double.tryParse(pickupSharedLat)!;
    var longitude = double.tryParse(pickupSharedLong)!;
    final result = await Get.to(
      () => GoogleMaps(
        latitude: latitude,
        longitude: longitude,
      ),
      routeName: '/google-maps',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
      binding: BindingsBuilder(() => Get.lazyPut<GoogleMapsController>(
            () => GoogleMapsController(),
          )),
    );

    if (result != null) {
      final latitude = result["latitude"];
      final longitude = result["longitude"];
      final address = result["address"];

      pickupSharedLocationEC.text = address;
      pickupSharedLocation.value = address;
      pickupSharedLat = latitude;
      pickupSharedLong = longitude;

      if (pickupSharedLocationEC.text.isNotEmpty &&
          sharedDestinationEC.text.isNotEmpty &&
          pickupSharedLat.isNotEmpty &&
          destinationSharedLat.isNotEmpty) {
        shareRideButtonIsVisible.value = true;
      }
    }
  }

  setSharedDestinationGoogleMapsLocation() async {
    var latitude = double.tryParse(pickupSharedLat)!;
    var longitude = double.tryParse(pickupSharedLong)!;
    final result = await Get.to(
      () => GoogleMaps(
        latitude: latitude,
        longitude: longitude,
      ),
      routeName: '/google-maps',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
      binding: BindingsBuilder(() => Get.lazyPut<GoogleMapsController>(
            () => GoogleMapsController(),
          )),
    );

    if (result != null) {
      final latitude = result["latitude"];
      final longitude = result["longitude"];
      final address = result["address"];

      pickupSharedLocationEC.text = address;
      pickupSharedLocation.value = address;
      pickupSharedLat = latitude;
      pickupSharedLong = longitude;
    }
  }

  BookSharedRideWebSocketService? bookSharedRideWebSocketService;

  openSharedRidePanel() {
    sharedRidePanelController.open();
    sharedRidePanelIsOpen.value = true;
  }

  closeSharedRidePanel() {
    sharedRidePanelController.close();
    sharedRidePanelIsOpen.value = false;
  }

  var sharedRideWaitingTimeRemaining = 300.obs; // 5 minutes in seconds
  var isSharedRideWaitingTimeEnded = false.obs;
  Timer? _sharedRideWaitingTimer;

  void startSharedRideWaitingTimer() {
    if (_sharedRideWaitingTimer != null && _sharedRideWaitingTimer!.isActive) {
      return; // Prevent multiple timers from running
    }

    isSharedRideWaitingTimeEnded.value = false; // Reset the flag

    _sharedRideWaitingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sharedRideWaitingTimeRemaining.value > 0) {
        sharedRideWaitingTimeRemaining.value--;
        log("Timer remaining: ${sharedRideWaitingTimeRemaining.value}",
            name: "Shared Ride Waiting Timer");
      } else {
        log("Timer canceled", name: "Shared Ride Waiting Timer");
        timer.cancel();
        isSharedRideWaitingTimeEnded.value = true; // Timer ended
      }
    });
  }

  void stopSharedRideWaitingTimer() {
    _sharedRideWaitingTimer?.cancel();
  }

  void restartSharedRideWaitingTimer() {
    stopSharedRideWaitingTimer();
    sharedRideWaitingTimeRemaining.value = 300;
    isSharedRideWaitingTimeEnded.value = false;
    startSharedRideWaitingTimer();
  }

  String get sharedRideWaitingFormattedTime {
    int minutes = sharedRideWaitingTimeRemaining.value ~/ 60;
    int seconds = sharedRideWaitingTimeRemaining.value % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  Future<void> createSharedRide() async {
    var url = ApiUrl.baseUrl + ApiUrl.bookSharedRide;

    var userToken = prefs.getString("userToken") ?? "";
    initiatingSharedRide.value = true;

    Map<String, dynamic> data = {
      "pickup_location": {
        "address": pickupSharedLocationEC.text,
        "lat": pickupSharedLat,
        "long": pickupSharedLong,
      },
      "destination": {
        "address": sharedDestinationEC.text,
        "lat": destinationSharedLat,
        "long": destinationSharedLong,
      },
      "payment_type": "wallet",
    };

    log("URL=> $url\nUSERTOKEN=>$userToken\nData=>$data");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken"
    };

    //HTTP Client Service
    http.Response? response =
        // await HttpClientService.postRequest(url, userToken, data);
        await HttpClientService.postRequest(url, userToken, data, headers);

    if (response == null) {
      initiatingSharedRide.value = false;
      return;
    }

    try {
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      log(
        "This is the responseJson: $responseJson\nResponse status code: ${response.statusCode}",
        name: "Book Shared Ride",
      );

      if (response.statusCode == 201) {
        ApiProcessorController.successSnack("${responseJson["message"]}");
        initiatingSharedRide.value = false;

        bookSharedRideWebSocketService = BookSharedRideWebSocketService(
          riderUUID: riderModel.value.riderUuid,
          authToken: userToken,
        );

        final bookSharedRideWebsocketIsConnected =
            await bookSharedRideWebSocketService!.connect();
        log("Shared Ride Websocket is connected: $bookSharedRideWebsocketIsConnected");

        if (bookSharedRideWebsocketIsConnected) {
          await closeHomePanel();
          sharedRidePanelIsVisible.value = true;
          // sharedRidePanelController.open();
          await Future.delayed(const Duration(seconds: 1));
          startSharedRideWaitingTimer();
        } else {
          log(responseJson.toString());
          initiatingSharedRide.value = false;
          bookSharedRideWebSocketService?.disconnect();
          bookSharedRideWebSocketService = null; // Cleanup
        }
      } else {
        initiatingSharedRide.value = false;
        ApiProcessorController.warningSnack("${responseJson["message"]}");
        log(responseJson.toString());
      }
    } catch (e) {
      initiatingSharedRide.value = false;
      log(e.toString());
    } finally {
      initiatingSharedRide.value = false;
    }
  }

  //!==== Schedule Trip =========================================================================>

  scheduleATrip() async {
    bool hasViewedScheduleTripIntro =
        prefs.getBool("viewedScheduleTripIntro") ?? false;
    if (hasViewedScheduleTripIntro) {
      // User has viewed intro already, navigate to the schedule trip screen
      await closeHomePanel();
      goToScheduleTripScreen();
      log("User has viewed");
    } else {
      closeHomePanel();
      showScheduleTripIntroDialog();
      log("User has not viewed");
    }
  }

  goToScheduleTripScreen() async {
    prefs.setBool("viewedScheduleTripIntro", true);

    Get.to(
      () => const ScheduleTripScreen(),
      transition: Transition.rightToLeft,
      routeName: "/schedule-trip",
      curve: Curves.easeInOut,
      fullscreenDialog: true,
      popGesture: true,
      preventDuplicates: true,
    );
  }

  showScheduleTripIntroDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          insetPadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          elevation: 50,
          child: const ScheduleTripIntroDialog(),
        );
      },
    );
  }

  List<Map<String, String>> scheduleTripIntroInfo = [
    {
      'icon': Assets.calendarOutlineIconSvg,
      'label': 'Choose a pick-up date within 30 days',
    },
    {
      'icon': Assets.clockIconSvg,
      'label': 'Choose a time at your convenience',
    },
    {
      'icon': Assets.routeIconSvg,
      'label': 'Choose a route you prefer',
    },
  ];

  //==== School Commutes =========================================================================>

  scheduleACommute() async {
    ApiProcessorController.warningSnack("School Commutes is coming soon");
    // bool hasViewedScheduleTripIntro =
    //     prefs.getBool("viewedSchoolCommuteIntro") ?? false;
    // if (hasViewedScheduleTripIntro) {
    //   // User has viewed intro already, navigate to the schedule trip screen
    //   await closeHomePanel();
    //   goToSchoolCommuteScreen();
    //   log("User has viewed");
    // } else {
    //   closeHomePanel();
    //   showSchoolCommuteIntroDialog();
    //   log("User has not viewed");
    // }
  }

  goToSchoolCommuteScreen() async {
    prefs.setBool("viewedSchoolCommuteIntro", true);

    Get.to(
      () => const SchoolCommuteScreen(),
      transition: Transition.rightToLeft,
      routeName: "/schedule-trip",
      curve: Curves.easeInOut,
      fullscreenDialog: true,
      popGesture: true,
      preventDuplicates: true,
    );
  }

  showSchoolCommuteIntroDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          insetPadding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          elevation: 50,
          child: const SchoolCommuteIntroDialog(),
        );
      },
    );
  }

  List<Map<String, String>> schoolCommuteIntroInfo = [
    {
      'icon': Assets.calendarOutlineIconSvg,
      'label': 'Schedule pick-up days',
    },
    {
      'icon': Assets.clockIconSvg,
      'label': 'Choose a pick-up/drop-off time at your convenience',
    },
    {
      'icon': Assets.routeIconSvg,
      'label': 'Choose a route you prefer',
    },
  ];

  //!==== Rent Ride =========================================================================>

  //================ Variables =================\\
  var rentRideFormKey = GlobalKey<FormState>();
  DateTime? lastSelectedRentRideDate;
  TimeOfDay? lastSelectedRentRidePickupTime;
  var rentRideChargePerMinute = "200".obs;
  var selectedVehicleImage = "".obs;
  var selectedVehicleName = "".obs;
  var selectedVehiclePlateNumber = "".obs;
  var selectedVehicleNumOfStars = 0.obs;
  String rentRidePickupLat = "";
  String rentRidePickupLong = "";
  List<GooglePlaceAutoCompletePredictionModel> rentRidePickupPlacePredictions =
      [];

  var rentRideFormattedTime = "".obs;
  var rentRideformattedDate = "".obs;

  //================ Models =================\\
  var rentRideVehicleModel = VehicleModel.fromJson(null).obs;
  var availableVehiclesReponseModel =
      AvailableVehiclesResponseModel.fromJson(null).obs;

  //================ Booleans =================\\
  var chooseAvailableVehicleTextFieldIsVisible = false.obs;
  var isRentRidePickupLocationTextFieldActive = false.obs;
  var rentRidePickupLocationTextFieldIsVisible = false.obs;
  var confirmRentRideBookingButtonIsEnabled = false.obs;
  var confirmRentRideBookingButtonIsLoading = false.obs;
  var isLoadingAvailableVehicles = false.obs;

  //================ Controllers =================\\
  var rentRideDateEC = TextEditingController();
  var rentRidePickupTimeEC = TextEditingController();
  var chooseAvailableVehicleEC = TextEditingController();
  var rentRidePickupLocationEC = TextEditingController();

  //================ Focus Nodes =================\\
  var rentRideDateFN = FocusNode();
  var rentRidePickupTimeFN = FocusNode();
  var chooseAvailableVehicleFN = FocusNode();
  var rentRidePickupLocationFN = FocusNode();

  void selectRentRideDate() async {
    var context = Get.context!;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: lastSelectedRentRideDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );

    if (selectedDate != null) {
      rentRideDateEC.text = DateFormat("dd/MM/yyyy").format(selectedDate);
      lastSelectedRentRideDate = selectedDate;
      rentRideformattedDate.value =
          DateFormat("yyyy-MM-dd").format(selectedDate);
    }
    log(
      "This is the scheduled Date: $rentRideformattedDate",
      name: "Rent a ride Date Picker",
    );
  }

  void selectRentRidePickupTime() async {
    TimeOfDay now = TimeOfDay.now();
    var context = Get.context!;

    var selectedTime = await showTimePicker(
      context: context,
      initialTime: lastSelectedRentRidePickupTime ?? now,
      initialEntryMode: TimePickerEntryMode.dial,
      cancelText: "Cancel",
      confirmText: "Confirm",
    );

    if (selectedTime != null) {
      final now = DateTime.now();
      rentRideFormattedTime.value = DateFormat("HH:mm").format(DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      ));
      final newFormattedTime = DateFormat("hh:mm a").format(DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      ));

      rentRidePickupTimeEC.text = newFormattedTime;
      lastSelectedRentRidePickupTime = selectedTime;
      rentRidePickupLocationTextFieldIsVisible.value =
          rentRidePickupTimeEC.text.isNotEmpty;
      // chooseAvailableVehicleTextFieldIsVisible.value = true;
    }

    log("Pickup Location Text Field is visible: ${rentRidePickupLocationTextFieldIsVisible.value}");
    log(
      "This is the scheduled time: ${rentRideFormattedTime.value}",
      name: "Rent ride Time picker",
    );
  }

  setRentRidePickupGoogleMapsLocation() async {
    final result = await Get.to(
      () => GoogleMaps(
        latitude: rentRidePickupLat.isNotEmpty
            ? double.tryParse(rentRidePickupLat)!
            : userPosition.value!.latitude,
        longitude: rentRidePickupLong.isNotEmpty
            ? double.tryParse(rentRidePickupLong)!
            : userPosition.value!.longitude,
      ),
      routeName: '/google-maps',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.downToUp,
      binding: BindingsBuilder(() => Get.lazyPut<GoogleMapsController>(
            () => GoogleMapsController(),
          )),
    );

    if (result != null) {
      final latitude = result["latitude"];
      final longitude = result["longitude"];
      final address = result["address"];

      rentRidePickupLocationEC.text = address;
      // rentRidePickupLocation.value = address;
      rentRidePickupLat = latitude;
      rentRidePickupLong = longitude;

      log(
        "This are the result details:\nAddress: ${rentRidePickupLocationEC.text}\nLatitude: $rentRidePickupLat\nLongitude: $rentRidePickupLong",
      );
      if (rentRidePickupLocationEC.text.isNotEmpty &&
          rentRidePickupLat.isNotEmpty &&
          rentRidePickupLong.isNotEmpty) {
        confirmRentRideBookingButtonIsEnabled.value = true;
      }
    }
  }

  void chooseAvailableVehicle() async {
    var loadedAvailableVehicles = await getAvailableVehicles();
    if (loadedAvailableVehicles) {
      Get.to(
        () => const ChooseAvailableVehicleScaffold(),
        transition: Transition.rightToLeft,
        routeName: "/choose-available-vehicle",
        curve: Curves.easeInOut,
        fullscreenDialog: true,
        popGesture: true,
        preventDuplicates: true,
      );
    }
  }

  Future<bool> getAvailableVehicles() async {
    var url = ApiUrl.baseUrl + ApiUrl.getAvailableVehicles;
    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");

    isLoadingAvailableVehicles.value = true;

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.getRequest(url, userToken);

    if (response == null) {
      return false;
    }

    log("Response body=> ${response.body}");
    try {
      if (response.statusCode == 200) {
        // Convert to json
        dynamic responseJson;

        responseJson = jsonDecode(response.body);

        availableVehiclesReponseModel.value =
            AvailableVehiclesResponseModel.fromJson(responseJson);

        log("Total number of vehicles: ${availableVehiclesReponseModel.value.data.total}");
        log("Number of vehicles on this page: ${availableVehiclesReponseModel.value.data.vehicles.length}");

        isLoadingAvailableVehicles.value = false;
        return true;
      } else {
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log("This is the error log: ${e.toString()}");
      return false;
    }
    isLoadingAvailableVehicles.value = false;
    return false;
  }

  List<Map<String, dynamic>> vehicleSpecificationsInfo(VehicleModel vehicle) =>
      [
        {
          'icon': Iconsax.battery_charging,
          'title': "Max. power",
          'subtitle': "200 hp",
          // 'subtitle': "${vehicle.specifications.maxPower}hp",
        },
        {
          'icon': Iconsax.speedometer,
          'title': "Max. speed",
          'subtitle': "250kph",
          // 'subtitle': "${vehicle.specifications.maxSpeed}kph",
        },
        {
          'icon': Iconsax.radar,
          'title': "0-60mph",
          // 'subtitle': "${vehicle.specifications.acceleration}sec",
          'subtitle': "2.4sec",
        },
      ];
  List<Map<String, dynamic>> vehicleFeaturesInfo(VehicleModel vehicle) => [
        {
          'title': "Model",
          'subtitle': vehicle.name,
        },
        {
          'title': "Capacity",
          'subtitle': "${vehicle.specifications.capacity} Seats",
        },
        {
          'title': "Color",
          'subtitle': "Red",
        },
        {
          'title': "Fuel type",
          'subtitle': vehicle.specifications.fuelType,
        },
        {
          'title': "Gear type",
          'subtitle': vehicle.specifications.gearType,
        },
      ];

  cancelSelectAvailableRide() async {
    Get.back();
    chooseAvailableVehicleEC.clear();
    confirmRentRideBookingButtonIsEnabled.value = false;
  }

  selectAvailableRide(VehicleModel vehicle) async {
    Get.close(2);
    chooseAvailableVehicleEC.text = vehicle.name;
    selectedVehicleName.value = chooseAvailableVehicleEC.text;
    selectedVehiclePlateNumber.value = vehicle.details.plateNumber;
    selectedVehicleImage.value = Assets.car3Png;
    rentRideChargePerMinute.value = vehicle.pricing.pricePerMinute.toString();
    // selectedVehicleImage.value = vehicle.image;
  }

  //================ OnTap and Onchanged =================\\

  Future<void> confirmRentRideBooking() async {
    if (rentRideFormKey.currentState!.validate()) {
      rentRideFormKey.currentState!.save();
      if (rentRideDateEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a date");
        return;
      } else if (rentRidePickupTimeEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a pick-up time");
        return;
      }
      // else if (chooseAvailableVehicleEC.text.isEmpty) {
      //   ApiProcessorController.errorSnack("Please select a vehicle");
      //   return;
      // }
      else if (rentRidePickupLocationEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a pickup location");
        return;
      } else if (rentRidePickupLat.isEmpty || rentRidePickupLong.isEmpty) {
        ApiProcessorController.errorSnack(
          "You must select a location from the options given",
        );
        return;
      }
      confirmRentRideBookingButtonIsLoading.value = true;
      var rentedRide = await rentRide();

      if (rentedRide) showBookingConfirmedModal();

      confirmRentRideBookingButtonIsLoading.value = false;
    }
  }

  Future<bool> rentRide() async {
    var url = ApiUrl.baseUrl + ApiUrl.rentRide;
    var userToken = prefs.getString("userToken");

    log(
      "URL=> $url\nUSERTOKEN=>$userToken",
      name: "Rent a ride URL and Token",
      time: DateTime.now(),
    );

    confirmRentRideBookingButtonIsLoading.value = true;

    var data = {
      "address": rentRidePickupLocationEC.text,
      "lat": rentRidePickupLat,
      "long": rentRidePickupLong,
      "schedule_date": rentRideformattedDate.value,
      "schedule_pickup_time": rentRideFormattedTime.value,
    };

    log(
      "Request body=> $data",
      name: "Rent a ride",
    );

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken"
    };

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.postRequest(url, userToken, data, headers);

    if (response == null) {
      confirmRentRideBookingButtonIsLoading.value = false;
      return false;
    }

    try {
      // Convert to json
      dynamic responseJson;
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseJson = jsonDecode(response.body);
        log("Response body=> $responseJson", name: "Rent a ride");

        confirmRentRideBookingButtonIsLoading.value = false;
        return true;
      } else {
        ApiProcessorController.errorSnack("Booking failed");
        log(
          "Response body=> $responseJson, Response Status code: ${response.statusCode}",
          name: "Rent a ride",
        );

        // log("An error occured, Response body: ${response.body}");
      }
    } catch (e, stackTrace) {
      log(
        e.toString(),
        name: "Rent a Ride",
        stackTrace: stackTrace,
      );
      return false;
    }
    confirmRentRideBookingButtonIsLoading.value = false;
    return false;
  }

  void showBookingConfirmedModal() async {
    final media = MediaQuery.of(Get.context!).size;

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
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
        return const RentRideBookingConfirmedModal();
      },
    );
  }

  doneRentingRide() {
    goToHomeScreen();
  }

  cancelRentRideBooking() async {
    Get.back();
    chooseAvailableVehicleEC.clear();
    confirmRentRideBookingButtonIsEnabled.value = false;

    showDialog(
      context: Get.context!,
      barrierColor: kBlackColor.withValues(),
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          alignment: Alignment.center,
          elevation: 50,
          child: const RentRideBookingCanceledDialog(),
        );
      },
    );
  }
}
