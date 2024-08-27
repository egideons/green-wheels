import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:permission_handler/permission_handler.dart';
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

  //================ Boolean =================\\
  var isLocationPermissionGranted = false.obs;
  var floatingIconButtonIsVisible = false.obs;
  var hasPaid = false.obs;
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
    rideComplete.value = true;
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
  makePayment() async {
    Get.close(0);
    final media = MediaQuery.of(Get.context!).size;
    hasPaid.value = true;

    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
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
      if (feedbackMessageEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Field cannot be empty");
        return;
      }
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
