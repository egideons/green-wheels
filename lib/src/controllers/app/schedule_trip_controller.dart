import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/others/api_processor_controller.dart';
import 'package:intl/intl.dart';

import '../../../app/schedule_trip/modals/select_route_modal.dart';

class ScheduleTripController extends GetxController {
  static ScheduleTripController get instance {
    return Get.find<ScheduleTripController>();
  }

  //================ Global =================\\
  var scheduleTripFormKey = GlobalKey<FormState>();
  var scheduleTripRouteFormKey = GlobalKey<FormState>();
  DateTime? lastSelectedDate;
  TimeOfDay? lastSelectedTime;

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
      TextEditingController(text: "Pin Plaza, 1st Avenue, Festac");
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
    var selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: lastSelectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      currentDate: DateTime.now(),
      cancelText: "Cancel",
      confirmText: "Confirm",
    );

    if (selectedDate != null) {
      selectedDateEC.text = DateFormat("dd/MM/yyyy").format(selectedDate);
      lastSelectedDate = selectedDate;
    }
  }

  void selectTimeFunc() async {
    var selectedTime = await showTimePicker(
      context: Get.context!,
      initialTime: lastSelectedTime ?? TimeOfDay.now(),
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
      selectedTimeEC.text = formattedTime;
      lastSelectedTime = selectedTime;
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
          child: const SelectRouteModal(),
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

  void submitRouteForm() {
    if (stop1LocationEC.text.isNotEmpty) {
      selectedRouteEC.text =
          "${pickupLocationEC.text} - ${stop1LocationEC.text} - ${destinationEC.text}";
    } else {
      selectedRouteEC.text = "${pickupLocationEC.text} - ${destinationEC.text}";
    }
    Get.close(0);
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
    }
  }
}
