import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/home/views/ride_panel.dart';
import 'package:green_wheels/app/home/views/shared_ride_panel.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../views/home_google_map.dart';
import '../../views/home_panel_section.dart';

class HomeScreenScaffold extends GetView<HomeScreenController> {
  const HomeScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      key: controller.scaffoldKey,
      extendBody: true,
      appBar: AppBar(toolbarHeight: 0),
      body: Obx(
        () {
          return SafeArea(
            child: Stack(
              children: [
                SlidingUpPanel(
                  controller: controller.homePanelController,
                  maxHeight: size.height * .8,
                  backdropTapClosesPanel: true,
                  minHeight: size.height * .2,
                  backdropEnabled: true,
                  defaultPanelState: PanelState.CLOSED,
                  panelSnapping: false,
                  backdropColor: kTransparentColor,
                  backdropOpacity: 0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  body: homeGoogleMap(controller, colorScheme),
                  panel: homePanelSection(
                    colorScheme,
                    size,
                    context,
                    controller,
                  ),
                ),
                if (controller.ridePanelIsVisible.value)
                  SlidingUpPanel(
                    controller: controller.ridePanelController,
                    maxHeight: size.height * .8,
                    backdropTapClosesPanel: true,
                    minHeight: size.height * .2,
                    backdropEnabled: true,
                    defaultPanelState: PanelState.CLOSED,
                    panelSnapping: false,
                    backdropColor: kTransparentColor,
                    backdropOpacity: 0,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    panel: RidePanel(),
                  ),
                if (controller.sharedRidePanelIsVisible.value)
                  SlidingUpPanel(
                    controller: controller.sharedRidePanelController,
                    maxHeight: size.height * .8,
                    backdropTapClosesPanel: true,
                    minHeight: size.height * .2,
                    backdropEnabled: true,
                    defaultPanelState: PanelState.OPEN,
                    panelSnapping: false,
                    backdropColor: kTransparentColor,
                    backdropOpacity: 0,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    panel: SharedRidePanel(),
                  ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(
                    onPressed: controller.goToMenu,
                    icon: const Icon(Icons.menu),
                    color: colorScheme.secondary,
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
