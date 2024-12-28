import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../views/home_google_map.dart';
import '../../views/home_panel_section.dart';

class HomeScreenScaffold extends GetView<HomeScreenController> {
  const HomeScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      key: controller.scaffoldKey,
      extendBody: true,
      appBar: AppBar(toolbarHeight: 0),
      body: GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return SafeArea(
            child:
                // controller.userPosition == null
                //     ? const Center(
                //         child: CircularProgressIndicator.adaptive(),
                //       )
                // :
                Stack(
              children: [
                SlidingUpPanel(
                  controller: controller.panelController,
                  maxHeight: media.height,
                  backdropTapClosesPanel: true,
                  minHeight: media.height * .26,
                  backdropEnabled: true,
                  defaultPanelState: PanelState.CLOSED,
                  panelSnapping: false,
                  backdropColor: kTransparentColor,
                  backdropOpacity: 0,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  body: homeGoogleMap(controller),
                  // panelBuilder: (sc) {
                  //   return homePanelSection(
                  //     colorScheme,
                  //     media,
                  //     context,
                  //     // sc,
                  //   );
                  // },
                  panel: homePanelSection(
                    colorScheme,
                    media,
                    context,
                    controller,
                  ),
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
