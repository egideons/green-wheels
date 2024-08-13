import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/components/drag_handle.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';

class HomeScreenScaffold extends GetView<HomeScreenController> {
  const HomeScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      key: controller.scaffoldKey,
      body: GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return SafeArea(
            child: Stack(
              children: [
                SlidingUpPanel(
                  maxHeight: media.height,
                  backdropTapClosesPanel: true,
                  backdropEnabled: true,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  body: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      zoom: 14,
                    ),
                    mapType: MapType.normal,
                    onMapCreated: controller.onMapCreated,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                  ),
                  panel: Container(
                    width: media.width,
                    decoration: ShapeDecoration(
                      color: colorScheme.primary,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: ShapeDecoration(
                              color: colorScheme.primary,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outlined,
                                  color: colorScheme.surface,
                                  size: 32,
                                ),
                                kSmallWidthSizedBox,
                                Flexible(
                                  child: Text(
                                    'Please note that every vehicle has a security camera for safety reasons',
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colorScheme.surface,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: ShapeDecoration(
                                color: colorScheme.surface,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32),
                                    topRight: Radius.circular(32),
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  dragHandle(media),
                                  kSmallSizedBox,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(
                    onPressed: () {},
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
