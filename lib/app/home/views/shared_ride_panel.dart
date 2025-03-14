import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';

class SharedRidePanel extends GetView<HomeScreenController> {
  const SharedRidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      child: Container(),
      //  Obx(() {
      //   if (controller.rideStarted.value) {
      //     return rideSection(media, colorScheme);
      //   } else {
      //     return rideRequestPanel(media, colorScheme);
      //   }
      // }),
    );
  }
}
