import 'dart:async';
import 'dart:developer';

import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/main.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../app/schedule_trip/content/schedule_trip_request_canceled_dialog.dart';
import '../../../app/schedule_trip/modals/schedule_trip_cancel_request_modal.dart';
import '../../../app/schedule_trip/modals/schedule_trip_ride_request_accepted_modal.dart';
import '../../../app/schedule_trip/modals/schedule_trip_search_driver_modal.dart';
import '../../../app/schedule_trip/modals/select_route_modal.dart';
import '../../../app/splash/loading/screen/loading_screen.dart';
import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import '../others/loading_controller.dart';

class ScheduleTripController extends GetxController {
  static ScheduleTripController get instance {
    return Get.find<ScheduleTripController>();
  }

  //================ Global =================\\
  var scheduleTripFormKey = GlobalKey<FormState>();
  var scheduleTripRouteFormKey = GlobalKey<FormState>();
  DateTime? lastSelectedDate;
  TimeOfDay? lastSelectedTime;
  Rx<double> rideAmount = 8000.0.obs;

  //================ Variables =================\\
  var pickupLocation = "123 Main Street, Lagos".obs;
  var destination = "456 Marina Road, Lagos".obs;
  String? scheduledPickupTime;
  String? scheduledPickupDate;

  //================ Booleans =================\\
  var isPickupLocationTextFieldActive = false.obs;
  var isDestinationTextFieldActive = false.obs;
  var isStopLocationVisible = false.obs;
  var isStopLocationTextFieldActive = false.obs;
  var mapSuggestionIsSelected = false.obs;
  var confirmBookingButtonIsEnabled = false.obs;

  //================ Controllers =================\\
  var scrollController = ScrollController();
  var selectedDateEC = TextEditingController();
  var selectedTimeEC = TextEditingController();
  var selectedRouteEC = TextEditingController();

  final pickupLocationEC =
      TextEditingController(text: "123 Main Street, Lagos");
  final stop1LocationEC = TextEditingController();
  final stop2LocationEC = TextEditingController();
  final stop3LocationEC = TextEditingController();
  final destinationEC = TextEditingController();

  //================ Focus Nodes =================\\
  var selectedDateFN = FocusNode();
  var selectedTimeFN = FocusNode();
  var selectedRouteFN = FocusNode();
  final pickupLocationFN = FocusNode();
  final stop1LocationFN = FocusNode();
  final stop2LocationFN = FocusNode();
  final stop3LocationFN = FocusNode();
  final destinationFN = FocusNode();

//================ OnTap and Onchanged =================\\
  void selectDateFunc() async {
    DateTime today = DateTime.now();

    final selectedDate = await showBoardDateTimePicker(
      context: Get.context!,
      enableDrag: false,
      showDragHandle: false,
      pickerType: DateTimePickerType.date,
      initialDate: lastSelectedDate ?? today,
      minimumDate: today,
      maximumDate: DateTime(2101),
      isDismissible: true,
      useSafeArea: true,
      onChanged: (dateTime) {
        selectedDateEC.text = DateFormat("dd/MM/yyyy").format(dateTime);
        scheduledPickupDate = DateFormat('yyyy-MM-dd').format(dateTime);
        lastSelectedDate = dateTime;
      },
      options: const BoardDateTimeOptions(
        inputable: true,
        showDateButton: true,
        startDayOfWeek: DateTime.sunday,
      ),
    );

    if (selectedDate != null) {
      selectedDateEC.text = DateFormat("dd/MM/yyyy").format(selectedDate);
      scheduledPickupDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      lastSelectedDate = selectedDate;
    }
    log("This is the scheduled Datte: $scheduledPickupDate");
  }

  void selectTimeFunc() async {
    TimeOfDay now = TimeOfDay.now();

    var selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: lastSelectedTime ?? now,
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

      // Format time in 24-hour format
      scheduledPickupTime = DateFormat("HH:mm").format(DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      ));

      log("This is the scheduled time: $scheduledPickupTime");

      selectedTimeEC.text = formattedTime;
      lastSelectedTime = selectedTime;
    }
  }

  void showScheduleTripSelectRouteModal() async {
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
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: const ScheduleTripSelectRouteModal(),
        );
      },
    );
  }

  void selectPickupSuggestion() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void selectStopLocationSuggestion() async {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void selectDestinationSuggestion() async {
    mapSuggestionIsSelected.value = true;
    destinationEC.text = destination.value;
    // FocusScope.of(Get.context!).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
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

  destinationOnChanged(String value) {
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

  void submitRouteForm() {
    if (stop1LocationEC.text.isNotEmpty) {
      selectedRouteEC.text =
          "${pickupLocationEC.text} to ${stop1LocationEC.text} to ${destinationEC.text}";
      confirmBookingButtonIsEnabled.value = true;
    } else {
      selectedRouteEC.text =
          "${pickupLocationEC.text} to ${destinationEC.text}";
      confirmBookingButtonIsEnabled.value = true;
    }
    Get.close(0);
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
  void simulateBookRideDriverSearchProgress() {
    progress.value = 0.0;

    bookRideTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (progress.value < 0.9) {
        updateProgress(progress.value + 0.1);
      } else {
        // Directly set progress to 1.0 on the last step
        updateProgress(1.0);
        scheduleDriverTimerFinished.value = true;
        scheduleDriverFound.value = true;
        update();
        log("Timer finished: ${scheduleDriverTimerFinished.value}");
        log("Driver found: ${scheduleDriverFound.value}");
        cancelProgress();
      }
    });
  }

  // Cancel the progress simulation
  void cancelProgress() {
    bookRideTimer?.cancel();
  }

  //================ Confirm Booking =================//
  confirmBooking() async {
    if (scheduleTripFormKey.currentState!.validate()) {
      scheduleTripFormKey.currentState!.save();
      if (selectedDateEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a date");
        return;
      } else if (selectedTimeEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a time");
        return;
      }

      var url = ApiUrl.baseUrl + ApiUrl.scheduleRide;

      var userToken = prefs.getString("userToken");

      Map<String, dynamic> data = {
        "pickup_location": {
          "address": pickupLocationEC.text,
          "lat": 40.7829,
          "long": -73.9654
        },
        "destination": {
          "address": destinationEC.text,
          "lat": 40.7061,
          "long": -73.9969
        },
        "schedule_pickup_time": scheduledPickupTime,
        "schedule_date": scheduledPickupDate,
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
        // dynamic responseJson;

        // responseJson = jsonDecode(response.body);
        if (response.statusCode == 200) {
          await Future.delayed(const Duration(milliseconds: 800));
          await showSearchingForDriverModalSheet();
        } else {
          ApiProcessorController.errorSnack(
              "An error occured in scheduling your ride.\nPlease try again later");
          log("An error occured: ${response.body}");
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Timer? bookRideTimer;
  var progress = .0.obs;
  var scheduleDriverTimerFinished = false.obs;
  var scheduleDriverFound = false.obs;
  var driverHasArrived = false.obs;

  showSearchingForDriverModalSheet() async {
    final media = MediaQuery.of(Get.context!).size;

    simulateBookRideDriverSearchProgress();

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
        return const ScheduleTripSearchDriverModal();
      },
    );
  }

  void showScheduleRideRequestAcceptedModal() async {
    Get.close(0);
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
        return const ScheduleTripRideRequestAcceptedModal();
      },
    );
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

      await showScheduleTripRequestCanceledDialog();
    }
  }

  void showScheduleTripCancelRequestModal() async {
    final media = MediaQuery.of(Get.context!).size;

    // Get.close(0);

    if (scheduleDriverFound.value == true ||
        scheduleDriverTimerFinished.value == true) {
      progress.value = 0.0;
      scheduleDriverTimerFinished.value = false;
      scheduleDriverFound.value = false;
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: Get.context!,
      useSafeArea: true,
      isDismissible: false,
      constraints:
          BoxConstraints(maxHeight: media.height, minWidth: media.width),
      builder: (context) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: const ScheduleTripCancelRequestModal(),
        );
      },
    );
  }

  showScheduleTripRequestCanceledDialog() {
    showDialog(
      context: Get.context!,
      barrierColor: kBlackColor.withOpacity(.8),
      builder: (context) {
        return Dialog(
          insetAnimationCurve: Curves.easeIn,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          alignment: Alignment.center,
          elevation: 50,
          child: const ScheduleTripRequestCanceledDialog(),
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
