import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../src/controllers/menu/scheduled_rides_menu_controller.dart';
import '../platform/android/scheduled_rides_menu_scaffold.dart';

class ScheduledRidesMenuScreen extends StatelessWidget {
  const ScheduledRidesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(ScheduledRidesMenuController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const MenuScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const ScheduledRidesMenuScaffold(),
    );
  }
}
