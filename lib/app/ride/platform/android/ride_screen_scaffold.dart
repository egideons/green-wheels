import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../src/controllers/app/ride_controller.dart';
import '../../../../theme/colors.dart';
import '../../content/ride_google_maps.dart';
import '../../content/ride_panel_section.dart';

class RideScreenScaffold extends GetView<RideController> {
  const RideScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      drawer: const Drawer(),
      body: GetBuilder<RideController>(
        init: RideController(),
        builder: (controller) {
          return SafeArea(
            child: SlidingUpPanel(
              controller: controller.panelController,
              maxHeight: media.height * .52,
              backdropTapClosesPanel: true,
              minHeight: media.height * .26,
              backdropEnabled: true,
              panelSnapping: false,
              backdropColor: kTransparentColor,
              backdropOpacity: 0,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              body:
                  // controller.userPosition == null
                  //     ? Center(
                  //         child: CircularProgressIndicator(
                  //           color: colorScheme.primary,
                  //         ),
                  //       )
                  //     :
                  rideGoogleMap(controller),
              panelBuilder: (sc) {
                return ridePanelSection(
                  colorScheme,
                  media,
                  context,
                  controller,
                );
              },
              // panel: ridePanelSection(colorScheme, media, context, controller),
            ),
          );
        },
      ),
    );
  }
}
