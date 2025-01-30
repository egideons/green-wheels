import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/app/schedule_trip_controller.dart';
import '../platform/android/schedule_trip_scaffold.dart';

class ScheduleTripScreen extends StatelessWidget {
  const ScheduleTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(ScheduleTripController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const HomeScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const ScheduleTripScaffold(),
    );
  }
}
