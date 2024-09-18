import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../src/constants/consts.dart';
import '../../../../../../src/controllers/menu/scheduled_trips_menu_controller.dart';
import '../../../../../../src/utils/components/my_app_bar.dart';
import '../../../../../../src/utils/components/profile_option.dart';

class ScheduledTripsMenuScaffold extends GetView<ScheduledTripsMenuController> {
  const ScheduledTripsMenuScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(
        colorScheme,
        media,
        centerTitle: false,
        title: "Scheduled trips",
        // titleFontSize: 18,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            profileOption(
              colorScheme,
              nav: controller.goToScheduledRides,
              title: "Scheduled rides",
            ),
            kSizedBox,
            profileOption(
              colorScheme,
              nav: controller.goToSchoolCommutes,
              title: "School commutes",
            ),
          ],
        ),
      ),
    );
  }
}
