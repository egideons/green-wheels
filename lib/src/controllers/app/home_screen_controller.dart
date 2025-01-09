import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/app/home/content/rent_ride/choose_available_vehicle_scaffold.dart';
import 'package:green_wheels/app/home/modals/book_ride_cancel_ride_fee_modal.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:green_wheels/src/models/ride/instant_ride_amount_response_model.dart';
import 'package:green_wheels/src/models/ride/rent_ride_vehicle_model.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:green_wheels/src/services/google_maps/autocomplete_prediction_model.dart';
import 'package:green_wheels/src/services/google_maps/location_service.dart';
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
import '../../../app/home/modals/book_ride_request_accepted_modal.dart';
import '../../../app/home/modals/book_ride_searching_for_driver_modal.dart';
import '../../../app/menu/screen/menu_screen.dart';
import '../../../app/ride/screen/ride_screen.dart';
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
    super.onClose();
  }

  //================ Variables =================\\
  var infoMessage = "".obs;
  var pinnedLocation = "".obs;
  var riderName = "Emmanuel Daniel".obs;
  Uint8List? markerImage;
  late LatLng draggedLatLng;
  var markers = <Marker>[].obs;
  var locationPinBottomPadding = 50.0.obs;

  final List<MarkerId> markerId = <MarkerId>[
    const MarkerId("0"),
  ];
  List<String>? markerTitle;
  List<String>? markerSnippet;
  final List<String> customMarkers = <String>[Assets.personLocationPng];
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var riderModel = RiderModel.fromJson(null).obs;

  late TabController tabBarController;
  var selectedTabBar = 0.obs;

  Rx<Position?> userPosition = Rx<Position?>(null);
  CameraPosition? cameraPosition;

  //================ Keys =================\\
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final bookRideFormKey = GlobalKey<FormState>();

  //================ Boolean =================\\
  var locationPinIsVisible = true.obs;
  var isRefreshing = false.obs;
  var isLocationPermissionGranted = false.obs;
  var showInfo = false.obs;
  var isPickupLocationTextFieldActive = false.obs;
  var isDestinationTextFieldActive = false.obs;
  var isStopLocationVisible = false.obs;
  var isStopLocationTextFieldActive = false.obs;
  var mapSuggestionIsSelected = false.obs;
  var routeIsVisible = false.obs;

  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

  var panelController = PanelController();

//================ Panel Functions =================\\
  togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  openPanel() => panelController.open();
  closePanel() => panelController.close();

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
    if (panelController.isPanelClosed) openPanel();
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

  initFunctions() async {
    infoMessage.value =
        "Please note that every vehicle has a security camera for safety reasons.";
    await Future.delayed(const Duration(seconds: 3));
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
      ApiProcessorController.errorSnack(
        "Please enable location services",
      );
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
    await getAndGoToUserCurrentLocation();

    await loadCustomMarkers();

    destinationEC.clear();
  }

  Future<Position> getAndGoToUserCurrentLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    userPosition.value = userLocation;

    LatLng latLngPosition =
        LatLng(userLocation.latitude, userLocation.longitude);
    cameraPosition = CameraPosition(target: latLngPosition, zoom: 18);

    newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition!),
    );

    pickupLat = userLocation.latitude.toString();
    pickupLong = userLocation.longitude.toString();

    log("User Position: $userLocation");
    log("Pickup Location: Latitude: $pickupLat, Longitude: $pickupLong");

    getPlaceMark(latLngPosition);

    await Future.delayed(const Duration(seconds: 2));
    pickupLocationEC.text = pinnedLocation.value;

    return userLocation;
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

  Future<void> loadCustomMarkers() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    userPosition.value = userLocation;

    List<LatLng> latLng = <LatLng>[
      LatLng(userLocation.latitude, userLocation.longitude),
    ];
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
  }
//========================================================== Locate a place =============================================================\\

  Future<void> locatePlace(
    Map<String, dynamic> place,
  ) async {
    double lat;
    double lng;

    lat = place['geometry']['location']['lat'];
    lng = place['geometry']['location']['lng'];

    goToSpecifiedLocation(LatLng(lat, lng), 18);

    // log("${LatLng(lat, lng)}");

    // _markers.add(
    //   Marker(
    //     markerId: const MarkerId("1"),
    //     icon: BitmapDescriptor.defaultMarker,
    //     position: LatLng(lat, lng),
    //     infoWindow: InfoWindow(
    //       title: _searchEC.text,
    //       snippet: "Pinned Location",
    //     ),
    //   ),
    // );
  }

  void searchPlaceFunc(String? location) async {
    locationPinIsVisible.value = false;

    var place = await LocationService().getPlace(location!);
    await Future.delayed(const Duration(milliseconds: 100));
    locatePlace(place);
  }

//============================================== Go to specified location by LatLng ==================================================\\
  Future goToSpecifiedLocation(LatLng position, double zoom) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom),
      ),
    );
    await getPlaceMark(position);
  }

//========================================================== Get PlaceMark Address and LatLng =============================================================\\

  Future getPlaceMark(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addressStr =
        "${address.name} ${address.street}, ${address.locality}, ${address.country}";
    pinnedLocation.value = addressStr;

    log("LatLng: ${LatLng(position.latitude, position.longitude)}");
    log("AddressStr: $addressStr");
    log("PinnedLocation: $addressStr");
  }

  onCameraIdle() async {
    routeIsVisible.value = false;
    getPlaceMark(draggedLatLng);

    await Future.delayed(const Duration(seconds: 1));
    destinationLat = draggedLatLng.latitude.toString();
    destinationLong = draggedLatLng.longitude.toString();

    if (destinationLat!.isNotEmpty && destinationLong!.isNotEmpty) {
      destinationEC.text = pinnedLocation.value;
    }
    // log("Destination on Camera Idle: ${destinationEC.text}");
    // log("Destination Lat on Camera Idle: $destinationLat");
    // log("Destination Long on Camera Idle: $destinationLong");

    if (pickupLocationEC.text.isNotEmpty && destinationEC.text.isNotEmpty) {
      await getRideAmount(
        destination: destinationEC.text,
        destinationLat: destinationLat,
        destinationLong: destinationLong,
        pickup: pickupLocationEC.text,
        pickupLat: pickupLat,
        pickupLong: pickupLong,
      );

      await Future.delayed(const Duration(milliseconds: 1200));
      routeIsVisible.value = true;
    }
  }

  onCameraMove(CameraPosition cameraPosition) {
    locationPinIsVisible.value = true;
    draggedLatLng = cameraPosition.target;

    log("Dragged LatLng on Camera Move: $draggedLatLng");
  }

  void onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  //!============ Book Instant Ride Section ==========================================================>

  //================ Variables =================\\
  String? pickupLat;
  String? pickupLong;
  String? destinationLat;
  String? destinationLong;
  List<GooglePlaceAutoCompletePredictionModel> pickupPlacePredictions = [];
  List<GooglePlaceAutoCompletePredictionModel> destinationPlacePredictions = [];

  //================ Models =================\\
  var instantRideAmountResponseModel =
      InstantRideAmountResponseModel.fromJson(null).obs;
  var instantRideData = InstantRideData.fromJson(null).obs;
  var priceBreakdown = PriceBreakdown.fromJson(null).obs;

  //================ Controllers =================\\
  var pickupLocation = "".obs;
  var stopLocation1 = "".obs;
  var destinationLocation = "".obs;
  final pickupLocationEC = TextEditingController();
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

  Timer? bookRideTimer;

  var progress = .0.obs;
  var totalInstantRideTime = "".obs;
  var bookDriverTimerFinished = false.obs;
  var bookDriverFound = false.obs;
  var driverHasArrived = false.obs;

  //================ OnTap and Onchanged =================\\
  void selectPickupSuggestion(index) async {
    final newLocation = pickupPlacePredictions[index].description;
    List location = await parseLatLng(newLocation);
    pickupLat = location[0];
    pickupLong = location[1];
    await Future.delayed(const Duration(milliseconds: 300));
    pickupLocationEC.text = newLocation;
    log("Pickup Location: ${pickupLocationEC.text}, $pickupLat, $pickupLong");
    searchPlaceFunc(destinationEC.text);
    FocusManager.instance.primaryFocus?.nextFocus();
  }

  void selectStopLocationSuggestion() async {
    stop1LocationEC.text = stopLocation1.value;
    // FocusManager.instance.primaryFocus?.unfocus();
    FocusManager.instance.primaryFocus?.nextFocus();
  }

//! Calculate Ride Amount and Select Destination Suggestion
  void selectDestinationSuggestion(index) async {
    routeIsVisible.value = false;

    final newLocation = destinationPlacePredictions[index].description;

    List location = await parseLatLng(newLocation);
    destinationLat = location[0];
    destinationLong = location[1];
    await Future.delayed(const Duration(milliseconds: 100));
    destinationEC.text = newLocation;
    FocusManager.instance.primaryFocus?.nextFocus();
    log("Destination: ${destinationEC.text}, $destinationLat, $destinationLong");

    if (pickupLocationEC.text.isNotEmpty && destinationEC.text.isNotEmpty) {
      // searchPlaceFunc(destinationEC.text);
      getPolyPoints(
        destinationLat: double.tryParse(destinationLat!)!,
        destinationLong: double.tryParse(destinationLong!)!,
        pickupLat: double.tryParse(pickupLat!)!,
        pickupLong: double.tryParse(pickupLong!)!,
        polylineCoordinates: polylineCoordinates,
      );

      await getRideAmount(
        destination: destinationEC.text,
        destinationLat: destinationLat,
        destinationLong: destinationLong,
        pickup: pickupLocationEC.text,
        pickupLat: pickupLat,
        pickupLong: pickupLong,
      );

      await Future.delayed(const Duration(milliseconds: 500));
      routeIsVisible.value = true;
    }
  }

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

    Map<String, dynamic> data = {
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

    log("URL=> $url\nUSERTOKEN=>$userToken\n$data");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken"
    };

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.postRequest(url, userToken, data, headers);

    if (response == null) {
      return;
    }

    try {
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      // log("Response Json=> $responseJson");

      if (response.statusCode == 200) {
        instantRideAmountResponseModel.value =
            InstantRideAmountResponseModel.fromJson(responseJson);
        instantRideData.value = instantRideAmountResponseModel.value.data;
        priceBreakdown.value =
            instantRideAmountResponseModel.value.data.priceBreakdown;

        calculateReadableTravelTime(
          priceBreakdown.value.distanceInMeters,
          totalInstantRideTime.value,
        );

        await Future.delayed(const Duration(milliseconds: 300));

        mapSuggestionIsSelected.value = true;

        // FocusScope.of(Get.context!).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      } else {
        ApiProcessorController.errorSnack("An error occured");
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  bookInstantRide() async {
    var url = ApiUrl.baseUrl + ApiUrl.bookInstantRide;

    var userToken = prefs.getString("userToken");

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

    log("URL=> $url\nUSERTOKEN=>$userToken\n$data");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $userToken"
    };

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.postRequest(url, userToken, data, headers);

    if (response == null) {
      return;
    }

    try {
      dynamic responseJson;

      responseJson = jsonDecode(response.body);

      log("This is the responseJson: $responseJson");

      if (response.statusCode == 200) {
        ApiProcessorController.successSnack("${responseJson["message"]}");
        showSearchingForDriverModalSheet();
      } else {
        ApiProcessorController.errorSnack(
          "${responseJson["message"]}\nThe required amount: ${responseJson["data"]["required_amount"]}\n Deficit: ${responseJson["data"]["deficit"]}",
        );
        log(responseJson.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void destinationOnTap() async {
    isStopLocationVisible.value = true;
    mapSuggestionIsSelected.value = false;
  }

  pickupLocationOnChanged(String value) {
    mapSuggestionIsSelected.value = false;

    // Check if the text field is empty
    if (value.isEmpty) {
      isPickupLocationTextFieldActive.value = false;
      isDestinationTextFieldActive.value = false;
    } else {
      // if (stop1LocationEC.text.isEmpty) {
      //   isDestinationTextFieldActive.value = false;
      //   isStopLocationTextFieldActive.value = false;
      //   isPickupLocationTextFieldActive.value = true;
      // } else {
      // isStopLocationTextFieldActive.value = true;
      googlePlaceAutoComplete(value, pickupPlacePredictions);
      update();

      isPickupLocationTextFieldActive.value = true;
      isDestinationTextFieldActive.value = false;
      // }
    }
  }

  destinationOnChanged(String value) {
    mapSuggestionIsSelected.value = false;

    // Check if the text field is empty
    if (value.isEmpty) {
      isDestinationTextFieldActive.value = false;
    } else {
      // if (stop1LocationEC.text.isEmpty) {
      //   isStopLocationTextFieldActive.value = false;
      //   isPickupLocationTextFieldActive.value = false;
      //   isDestinationTextFieldActive.value = true;
      // } else {
      googlePlaceAutoComplete(
        value,
        destinationPlacePredictions,
      );
      update();
      // isStopLocationTextFieldActive.value = true;
      isDestinationTextFieldActive.value = true;
      isPickupLocationTextFieldActive.value = false;
      // }
    }
  }

  stopLocationOnChanged(String value) {
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
    // await Future.delayed(const Duration(seconds: 1));
  }

  //============== Progress Indicatior =================\\
  // Method to update the progress
  void updateProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      progress.value = value;
      log("Progress: ${progress.value}");
    }
  }

// Start the progress simulation with a Timer
  void instantRideAwaitDriverResponse() {
    progress.value = 0.0;
    driverHasArrived.value = false;

    bookRideTimer = Timer.periodic(const Duration(seconds: 1), (bookRideTimer) {
      if (progress.value < 0.9) {
        updateProgress(progress.value + 0.1);
      } else if (progress.value > 0.4 && progress.value < 0.5) {
        updateProgress(progress.value);
        bookDriverTimerFinished.value = true;
        bookDriverFound.value = true;

        log("Driver found: ${bookDriverFound.value}");
        cancelProgress();
      } else {
        // Directly set progress to 1.0 on the last step
        updateProgress(1.0);
        bookDriverTimerFinished.value = true;
        bookDriverFound.value = true;

        log("Timer finished: ${bookDriverTimerFinished.value}");
        log("Driver found: ${bookDriverFound.value}");
        cancelProgress();
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

    await closePanel();

    instantRideAwaitDriverResponse();

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

  void showBookRideRequestAcceptedModal() async {
    Get.close(0);
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

  runDriverHasArrived() async {
    driverHasArrived.value = true;
    await Future.delayed(const Duration(seconds: 3));

    await startTrip();
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

  startTrip() async {
    Get.close(0);
    await Future.delayed(const Duration(milliseconds: 1000));
    Get.to(
      () => const RideScreen(),
      routeName: "/ride",
      arguments: {
        "riderName": riderName.value,
        "rideAmount": instantRideData.value.amount,
        "rideTime": totalInstantRideTime.value,
        "pickupLocation": pickupLocationEC.text,
        "destination": destinationEC.text,
        "pickupLat": pickupLat,
        "pickupLong": pickupLong,
        "destinationLat": destinationLat,
        "destinationLong": destinationLong,
      },
      curve: Curves.easeInOut,
      fullscreenDialog: true,
      popGesture: true,
      preventDuplicates: false,
      transition: Get.defaultTransition,
    );
  }

  //!==== Schedule Trip =========================================================================>

  scheduleATrip() async {
    bool hasViewedScheduleTripIntro =
        prefs.getBool("viewedScheduleTripIntro") ?? false;
    if (hasViewedScheduleTripIntro) {
      // User has viewed intro already, navigate to the schedule trip screen
      await closePanel();
      goToScheduleTripScreen();
      log("User has viewed");
    } else {
      closePanel();
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
    //   await closePanel();
    //   goToSchoolCommuteScreen();
    //   log("User has viewed");
    // } else {
    //   closePanel();
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

  //==== Rent Ride =========================================================================>

  //================ Variables =================\\
  var rentRideFormKey = GlobalKey<FormState>();
  DateTime? lastSelectedRentRideDate;
  TimeOfDay? lastSelectedRentRidePickupTime;
  var rentRideAmountPerHour = 1500.obs;
  var selectedVehicleImage = "".obs;
  var selectedVehicleName = "".obs;
  var selectedVehiclePlateNumber = "".obs;
  var selectedVehicleNumOfStars = 0.obs;

  var rentRideAvailableVehicles = [
    const RentRideVehicleModel(
      vehicleName: "BMW Cabrio",
      vehicleImage: Assets.car1Png,
      vehicleGearType: "Automatic",
      vehicleFuelType: "Electric",
      model: "Cabrio",
      vehiclePlateNumber: "ABJ23 456",
      numOfSeats: 4,
      acceleration: 3.0,
      maxHorsePower: 2000,
      maxSpeed: 200,
      capacity: 600,
      numOfstars: 4,
      numOfReviews: 50,
      rating: 4.5,
    ),
    const RentRideVehicleModel(
      vehicleName: "Mustang Shelby GT",
      vehicleImage: Assets.car3Png,
      vehicleGearType: "Automatic",
      vehicleFuelType: "Electric",
      model: "GT 500",
      vehiclePlateNumber: "ABJ23 456",
      numOfSeats: 4,
      acceleration: 2.3,
      maxHorsePower: 2500,
      maxSpeed: 230,
      capacity: 760,
      numOfReviews: 53,
      numOfstars: 4,
      rating: 4.9,
    ),
    const RentRideVehicleModel(
      vehicleName: "BMW i8",
      vehicleImage: Assets.car2Png,
      vehicleGearType: "Automatic",
      vehicleFuelType: "Electric",
      model: "I-Series",
      vehiclePlateNumber: "ABJ23 456",
      numOfSeats: 2,
      acceleration: 2.2,
      maxHorsePower: 2600,
      maxSpeed: 260,
      capacity: 760,
      numOfReviews: 60,
      numOfstars: 4,
      rating: 4.9,
    ),
    const RentRideVehicleModel(
      vehicleName: "Jaguar Silber",
      vehicleImage: Assets.car3Png,
      vehicleGearType: "Automatic",
      vehicleFuelType: "Electric",
      model: "Silber",
      vehiclePlateNumber: "ABJ23 456",
      numOfSeats: 4,
      acceleration: 2.0,
      maxHorsePower: 2800,
      maxSpeed: 240,
      capacity: 800,
      numOfReviews: 81,
      numOfstars: 4,
      rating: 4.8,
    ),
  ];

  //================ Booleans =================\\
  var chooseAvailableVehicleTextFieldIsVisible = false.obs;
  var confirmRentRideBookingButtonIsEnabled = false.obs;
  var confirmRentRideBookingButtonIsLoading = false.obs;

  //================ Controllers =================\\
  var rentRideDateEC = TextEditingController();
  var rentRidePickupTimeEC = TextEditingController();
  var chooseAvailableVehicleEC = TextEditingController();

  //================ Focus Nodes =================\\
  var rentRideDateFN = FocusNode();
  var rentRidePickupTimeFN = FocusNode();
  var chooseAvailableVehicleFN = FocusNode();

  void selectRentRideDate() async {
    DateTime today = DateTime.now();

    final selectedDate = await showBoardDateTimePickerForDate(
        context: Get.context!,
        enableDrag: false,
        showDragHandle: false,
        initialDate: lastSelectedRentRideDate ?? today,
        minimumDate: DateTime.now(),
        maximumDate: DateTime(2101),
        isDismissible: true,
        useSafeArea: true,
        onChanged: (dateTime) {
          rentRideDateEC.text = DateFormat("dd/MM/yyyy").format(dateTime);
        },
        options: const BoardDateTimeOptions(
          inputable: true,
          showDateButton: true,
          startDayOfWeek: DateTime.sunday,
        ));

    if (selectedDate != null) {
      rentRideDateEC.text = DateFormat("dd/MM/yyyy").format(selectedDate);
    }
  }

  void selectRentRidePickupTime() async {
    TimeOfDay now = TimeOfDay.now();

    var selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: lastSelectedRentRidePickupTime ?? now,
      cancelText: "Cancel",
      confirmText: "Confirm",
    );

    if (selectedTime != null) {
      final now = DateTime.now();
      final formattedTime = DateFormat("hh:mm a").format(DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      ));
      rentRidePickupTimeEC.text = formattedTime;
      lastSelectedRentRidePickupTime = selectedTime;
      chooseAvailableVehicleTextFieldIsVisible.value = true;
    }
  }

  void chooseAvailableVehicle() async {
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

  List<Map<String, dynamic>> vehicleSpecificationsInfo(
    RentRideVehicleModel vehicle,
  ) =>
      [
        {
          'icon': Iconsax.battery_charging,
          'title': "Max. power",
          'subtitle': "${vehicle.maxHorsePower}hp",
        },
        {
          'icon': Iconsax.speedometer,
          'title': "Max. speed",
          'subtitle': "${vehicle.maxSpeed}kph",
        },
        {
          'icon': Iconsax.radar,
          'title': "0-60mph",
          'subtitle': "${vehicle.acceleration}sec",
        },
      ];
  List<Map<String, dynamic>> vehicleFeaturesInfo(
    RentRideVehicleModel vehicle,
  ) =>
      [
        {
          'title': "Model",
          'subtitle': vehicle.model,
        },
        {
          'title': "Capacity",
          'subtitle': "${vehicle.capacity}hp",
        },
        {
          'title': "Color",
          'subtitle': "${vehicle.acceleration}sec",
        },
        {
          'title': "Fuel type",
          'subtitle': vehicle.vehicleFuelType,
        },
        {
          'title': "Gear type",
          'subtitle': vehicle.vehicleGearType,
        },
      ];

  cancelSelectAvailableRide() async {
    Get.back();
    chooseAvailableVehicleEC.clear();
    confirmRentRideBookingButtonIsEnabled.value = false;
  }

  selectAvailableRide(RentRideVehicleModel vehicle) async {
    Get.close(2);
    chooseAvailableVehicleEC.text = vehicle.vehicleName;
    confirmRentRideBookingButtonIsEnabled.value = true;
    selectedVehicleName.value = chooseAvailableVehicleEC.text;
    selectedVehiclePlateNumber.value = vehicle.vehiclePlateNumber;
    selectedVehicleNumOfStars.value = vehicle.numOfstars;
    selectedVehicleImage.value = vehicle.vehicleImage;
  }

  Future<void> confirmRentRideBooking() async {
    if (rentRideFormKey.currentState!.validate()) {
      rentRideFormKey.currentState!.save();
      if (rentRideDateEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a date");
        return;
      } else if (rentRidePickupTimeEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a pick-up time");
        return;
      } else if (chooseAvailableVehicleEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a vehicle");
        return;
      }
      confirmRentRideBookingButtonIsLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      confirmRentRideBookingButtonIsLoading.value = false;

      showBookingConfirmedModal();
    }
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
