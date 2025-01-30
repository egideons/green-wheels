import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../src/controllers/app/school_commute_controller.dart';
import '../platform/android/school_commute_scaffold.dart';

class SchoolCommuteScreen extends StatelessWidget {
  const SchoolCommuteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(SchoolCommuteController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const MenuScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const SchoolCommuteScaffold(),
    );
  }
}
