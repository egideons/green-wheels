import 'package:flutter/material.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/utils/buttons/android/android_elevated_button.dart';

scheduleTripTabBarView(HomeScreenController controller) {
  return Column(
    children: [
      kBigSizedBox,
      AndroidElevatedButton(
        title: "Schedule a Ride",
        onPressed: controller.scheduleATrip,
      ),
      kSizedBox,
      AndroidElevatedButton(
        title: "School Commutes",
        onPressed: controller.scheduleACommute,
      ),
    ],
  );
}
