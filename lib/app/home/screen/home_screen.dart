import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/app/home_screen_controller.dart';
import '../platform/android/home_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(HomeScreenController());

    if (Platform.isIOS) {
      return GestureDetector(
        onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
        // child: const HomeScreenCupertinoScaffold(),
      );
    }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const HomeScreenScaffold(),
    );
  }
}
