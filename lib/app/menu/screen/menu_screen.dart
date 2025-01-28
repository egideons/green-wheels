import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/app/menu_screen_controller.dart';
import '../platform/android/menu_screen_scaffold.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(MenuScreenController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const MenuScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const MenuScreenScaffold(),
    );
  }
}
