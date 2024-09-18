import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/menu/scheduled_trips_menu_controller.dart';
import '../platform/android/scheduled_trips_menu_scaffold.dart';

class ScheduledTripsMenuScreen extends StatelessWidget {
  const ScheduledTripsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(ScheduledTripsMenuController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const HomeScreenCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const ScheduledTripsMenuScaffold(),
    );
  }
}
