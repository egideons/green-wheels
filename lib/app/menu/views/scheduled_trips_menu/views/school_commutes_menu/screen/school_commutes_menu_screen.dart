import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../src/controllers/menu/school_commutes_menu_controller.dart';
import '../platform/android/school_commutes_menu_scaffold.dart';

class SchoolCommutesMenuScreen extends StatelessWidget {
  const SchoolCommutesMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(SchoolCommutesMenuController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const MenuScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const SchoolCommutesMenuScaffold(),
    );
  }
}
