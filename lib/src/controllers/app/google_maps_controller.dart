import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';

class GoogleMapsController extends GetxController {
  static GoogleMapsController get instance {
    return Get.find<GoogleMapsController>();
  }

  @override
  void onInit() {
    initFunctions();
    super.onInit();
  }

  //!================ Variables =================\\
  var locationPinBottomPadding = 50.0.obs;
  Rx<Position?> userPosition = Rx<Position?>(null);
  CameraPosition? cameraPosition;
  String? pickedUpLat;
  String? pickedUpLong;
  var pinnedLocation = "".obs;
  Uint8List? markerImage;
  late LatLng draggedLatLng;
  var googlePlacesApiKey = dotenv.env['GooglePlacesAPIKey'];

  //!================ Controllers =================\\
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

  //!================ Booleans =================\\
  var locationPinIsVisible = true.obs;
  var routeIsVisible = false.obs;

  //!================ Functions =================\\
  Future<void> initFunctions() async {
    await loadMapData();
  }

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
  }

  Future<Position> getAndGoToUserCurrentLocation() async {
    Position userLocation = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    userPosition.value = userLocation;

    LatLng latLngPosition =
        LatLng(userLocation.latitude, userLocation.longitude);
    cameraPosition = CameraPosition(target: latLngPosition, zoom: 16);

    newGoogleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition!),
    );

    pickedUpLat = userLocation.latitude.toString();
    pickedUpLong = userLocation.longitude.toString();

    log("User Position: $userLocation");
    log("Pickup Location: Latitude: $pickedUpLat, Longitude: $pickedUpLong");

    getPlaceMark(latLngPosition);

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

  Future getPlaceMark(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addressStr =
        "${address.name} ${address.street}, ${address.locality}, ${address.country}";
    pinnedLocation.value = addressStr;

    // log("LatLng: ${LatLng(position.latitude, position.longitude)}");
    log("AddressStr: $addressStr");
    log("PinnedLocation: $addressStr");
  }

  onCameraMove(CameraPosition cameraPosition) {
    draggedLatLng = cameraPosition.target;

    // locationPinIsVisible.value = true;
    // log("Dragged LatLng on Camera Move: $draggedLatLng");
  }

  onCameraIdle() async {
    routeIsVisible.value = false;
    getPlaceMark(draggedLatLng);

    await Future.delayed(const Duration(seconds: 1));
    pickedUpLat = draggedLatLng.latitude.toString();
    pickedUpLong = draggedLatLng.longitude.toString();

    log("Pinned Locaiton on Camera Idle: ${pinnedLocation.value}");
    log("Picked up Latitude Lat on Camera Idle: $pickedUpLat");
    log("Picked up Longitude on Camera Idle: $pickedUpLong");
  }

  void onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  void save() async {
    final result = {
      "address": pinnedLocation.value,
      "latitude": pickedUpLat,
      "longitude": pickedUpLong,
    };
    Get.back(result: result);
  }
}
