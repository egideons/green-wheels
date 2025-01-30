import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/menu/ride_history_menu_controller.dart';
import '../platform/android/ride_history_menu_scaffold.dart';

class RideHistoryMenuScreen extends StatelessWidget {
  const RideHistoryMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(RideHistoryMenuController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const MenuScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const RideHistoryMenuScaffold(),
    );
  }
}
