import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/school_commute/modals/school_commute_ride_request_accepted_modal.dart';
import 'package:green_wheels/app/school_commute/modals/school_commute_search_driver_modal.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:intl/intl.dart';

import '../../../app/school_commute/content/school_commute_request_canceled_dialog.dart';
import '../../../app/school_commute/modals/school_commute_cancel_request_modal.dart';
import '../../../app/school_commute/modals/school_commute_select_route_modal.dart';
import '../../../app/splash/loading/screen/loading_screen.dart';
import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import '../others/loading_controller.dart';

class SchoolCommuteController extends GetxController {
  static SchoolCommuteController get instance {
    return Get.find<SchoolCommuteController>();
  }

  //================ Global =================\\
  var scheduleTripFormKey = GlobalKey<FormState>();
  var scheduleTripRouteFormKey = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? lastSelectedPickupTime;
  TimeOfDay? lastSelectedDropOffTime;
  Rx<double> rideAmount = 8000.0.obs;
  var paymentType = "Green Wallet".obs;

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
  var selectedPickupTimeEC = TextEditingController();
  var selectedDropOffTimeEC = TextEditingController();
  var selectedRouteEC = TextEditingController();

  final pickupLocationEC =
      TextEditingController(text: "Pin Plaza, 1st Avenue, Festac");
  final stop1LocationEC = TextEditingController();
  final stop2LocationEC = TextEditingController();
  final stop3LocationEC = TextEditingController();
  final destinationEC = TextEditingController();

  //================ Focus Nodes =================\\
  var selectedDateFN = FocusNode();
  var selectedPickupTimeFN = FocusNode();
  var selectedDropOffTimeFN = FocusNode();
  var selectedRouteFN = FocusNode();
  final pickupLocationFN = FocusNode();
  final stop1LocationFN = FocusNode();
  final stop2LocationFN = FocusNode();
  final stop3LocationFN = FocusNode();
  final destinationFN = FocusNode();

//================ Select Data, Time and Route =================\\
  void selectDateFunc() async {
    // DateTime today = DateTime.now();
    // DateTime tomorrow = today.add(const Duration(days: 1));

    // final selectedDate = await showBoardDateTimeMultiPicker(
    //     context: Get.context!,
    //     enableDrag: false,
    //     showDragHandle: false,
    //     pickerType: DateTimePickerType.date,
    //     startDate: startDate ?? today,
    //     endDate: endDate ?? tomorrow,
    //     minimumDate: DateTime.now(),
    //     maximumDate: DateTime(2101),
    //     isDismissible: true,
    //     useSafeArea: true,
    //     onChanged: (dateTime) {
    //       selectedDateEC.text =
    //           "${DateFormat("dd/MM/yyyy").format(dateTime.start)} - ${DateFormat("dd/MM/yyyy").format(dateTime.end)}";

    //       startDate = dateTime.start;
    //       endDate = dateTime.end;
    //     },
    //     options: const BoardDateTimeOptions(
    //       inputable: true,
    //       showDateButton: true,
    //       startDayOfWeek: DateTime.sunday,
    //     ));

    // if (selectedDate != null) {
    //   selectedDateEC.text =
    //       "${DateFormat("dd/MM/yyyy").format(selectedDate.start)} - ${DateFormat("dd/MM/yyyy").format(selectedDate.end)}";
    //   startDate = selectedDate.start;
    //   endDate = selectedDate.end;
    // }
  }

  void selectPickupTimeFunc() async {
    TimeOfDay now = TimeOfDay.now();

    var selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: lastSelectedPickupTime ?? now,
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
      selectedPickupTimeEC.text = formattedTime;
      lastSelectedPickupTime = selectedTime;
    }
  }

  void selectDropOffTimeFunc() async {
    TimeOfDay now = TimeOfDay.now();

    var selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: lastSelectedDropOffTime ?? now,
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
      selectedDropOffTimeEC.text = formattedTime;
      lastSelectedDropOffTime = selectedTime;
    }
  }

  void showSelectRouteModal() async {
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
          child: const SchoolCommuteSelectRouteModal(),
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
      } else if (selectedPickupTimeEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a pick-up time");
        return;
      } else if (selectedDropOffTimeEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please select a drop-off time");
        return;
      }
      await Future.delayed(const Duration(milliseconds: 800));
      await showSearchingForDriverModalSheet();
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
        return const SchoolCommuteSearchDriverModal();
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
        return const SchoolCommuteRideRequestAcceptedModal();
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
          child: const SchoolCommuteCancelRequestModal(),
        );
      },
    );
  }

  showScheduleTripRequestCanceledDialog() {
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
          child: const SchoolCommuteRequestCanceledDialog(),
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
