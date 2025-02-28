import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/services/google_maps/location_service.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../app/ride/content/trip_completed_modal.dart';
import '../../../app/ride/content/trip_feedback_appreciation_dialog.dart';
import '../../../app/ride/content/trip_feedback_modal.dart';
import '../../../app/ride/content/trip_payment_successful_modal.dart';
import '../../../app/splash/loading/screen/loading_screen.dart';
import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import '../others/loading_controller.dart';

class RideController extends GetxController {
  static RideController get instance {
    return Get.find<RideController>();
  }

  @override
  void onInit() {
    initFunctions();
    super.onInit();
  }

  //================ Variables =================\\
  var rideInfo = "Trip has started".obs;
  var driverName = Get.arguments?["driverName"] ?? "";
  var driverRating = Get.arguments?["driverRating"] ?? 0;
  var rideAmount = Get.arguments?["rideAmount"] ?? 0.0;
  var rideTime = Get.arguments?["rideTime"] ?? 0;
  var pickupLocation = Get.arguments?["pickupLocation"] ?? "";
  var destination = Get.arguments?["destination"] ?? "";
  var pickupLat = Get.arguments?["pickupLat"] ?? "";
  var pickupLong = Get.arguments?["pickupLong"] ?? "";
  var destinationLat = Get.arguments?["destinationLat"] ?? "";
  var destinationLong = Get.arguments?["destinationLong"] ?? "";
  var paymentType = Get.arguments?["paymentType"] ?? "";

  Uint8List? markerImage;
  late LatLng draggedLatLng;
  var markers = <Marker>[].obs;

  Rx<Position?> userPosition = Rx<Position?>(null);
  CameraPosition? cameraPosition;

  final List<MarkerId> markerId = <MarkerId>[
    const MarkerId("0"),
    const MarkerId("1"),
    const MarkerId("2"),
  ];
  List<String> markerTitle = ["Me", "Driver", "Destination"];
  List<String>? markerSnippet;
  final List<String> customMarkers = <String>[
    Assets.personLocationPng,
    Assets.vehiclePng,
    Assets.locationPin1Png,
  ];
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;

  //================ Boolean =================\\
  var isLocationPermissionGranted = false.obs;
  var floatingIconButtonIsVisible = false.obs;
  var hasPaid = false.obs;
  var rideInProgress = false.obs;
  var rideComplete = false.obs;

  //================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;
  var homePanelController = PanelController();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  //======================================== Init Function =========================================//
  initFunctions() async {
    rideInfo.value = "Trip has started";
    markerSnippet = ["My Location", "Driver's Location", destination];
  }

  var routeIsVisible = false.obs;

  showRoute() async {
    getPolyPoints(
      destinationLat: double.tryParse(destinationLat!)!,
      destinationLong: double.tryParse(destinationLong!)!,
      pickupLat: double.tryParse(pickupLat!)!,
      pickupLong: double.tryParse(pickupLong!)!,
      polylineCoordinates: polylineCoordinates,
      alternatives: true,
    );
    await Future.delayed(const Duration(seconds: 1));
    routeIsVisible.value = true;
  }

  hideRoute() {
    routeIsVisible.value = false;
    polylineCoordinates.clear();
  }

  void onMapCreated(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  //======================================= Google Maps ================================================\\

  //============================== Get bytes from assets =================================\\

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

  //========================== Get Location Markers =============================\\

  Future<void> loadCustomMarkers() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    userPosition.value = userLocation;

    List<LatLng> latLng = <LatLng>[
      LatLng(userLocation.latitude, userLocation.longitude),
      LatLng(userLocation.latitude, userLocation.longitude),
      LatLng(destinationLat, destinationLong),
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
            title: markerTitle[i],
            snippet: markerSnippet?[i],
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

  var updateTrigger = 0.obs;

  void searchPlaceFunc(String? location) async {
    var place = await LocationService().getPlace(location!);

    await Future.delayed(const Duration(milliseconds: 100));
    locatePlace(place);
  }

//================================== Go to specified location by LatLng ======================================\\
  Future goToSpecifiedLocation(LatLng position, double zoom) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom),
      ),
    );
    await getPlaceMark(position);
  }

//============================================== Get PlaceMark Address and LatLng =================================================\\

  Future getPlaceMark(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addressStr =
        "${address.name} ${address.street}, ${address.locality}, ${address.country}";
    // pinnedLocation.value = addressStr;

    log("LatLng: ${LatLng(position.latitude, position.longitude)}");
    log("AddressStr: $addressStr");
    log("PinnedLocation: $addressStr");
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
    hasRated.value = false;

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
        return const TripCompletedModal();
      },
    );
  }

  //=============== Payment Section ================\\
  showPaymentSuccessfulModal() async {
    Get.close(0);
    final media = MediaQuery.of(Get.context!).size;
    hasPaid.value = true;

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
        return const TripPaymentSuccessfulModal();
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
    hasRated.value = false;
    rating.value = 0.0;
    feedbackMessageEC.text.isEmpty ? null : feedbackMessageEC.clear();

    Get.close(0);
    final media = MediaQuery.of(Get.context!).size;

    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      showDragHandle: true,
      context: Get.context!,
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
      await Future.delayed(const Duration(seconds: 3));
      submittingRequest.value = false;
      showTripFeedbackAppreciationDialog();
    }
  }

  showTripFeedbackAppreciationDialog() {
    Get.close(0);
    showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          alignment: Alignment.center,
          elevation: 50,
          child: const TripFeedbackAppreciationDialog(),
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
}
