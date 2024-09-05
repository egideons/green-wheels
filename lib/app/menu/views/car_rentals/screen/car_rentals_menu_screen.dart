import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/menu/car_rentals_menu_controller.dart';
import '../platform/android/car_rentals_menu_scaffold.dart';

class CarRentalMenuScreen extends StatelessWidget {
  const CarRentalMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(CarRentalMenuController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const HomeScreenCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const CarRentalMenuScaffold(),
    );
  }
}
