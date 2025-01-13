import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/menu/ride_history_menu_controller.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../src/constants/consts.dart';
import '../../content/ride_history_detail.dart';
import '../../content/ride_history_menu_tabs.dart';

class RideHistoryMenuScaffold extends GetView<RideHistoryMenuController> {
  const RideHistoryMenuScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(
        colorScheme,
        media,
        automaticallyImplyLeading: false,
        title: "Ride History",
        titleFontSize: 18,
        centerTitle: false,
      ),
      floatingActionButton: Obx(
        () => controller.isScrollToTopBtnVisible.value
            ? FloatingActionButton.small(
                onPressed: controller.scrollToTop,
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.surface,
                child: const Icon(Icons.keyboard_arrow_up),
              )
            : const SizedBox(),
      ),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: controller.onRefresh,
          color: colorScheme.secondary,
          backgroundColor: colorScheme.primary,
          child: Scrollbar(
            child: Obx(
              () => Column(
                children: [
                  rideHistoryMenuTabs(colorScheme, controller),
                  GetBuilder<RideHistoryMenuController>(
                    init: RideHistoryMenuController(),
                    builder: (controller) {
                      return controller.selectedTabBar.value == 0
                          ? Expanded(
                              child: Obx(
                                () => Skeletonizer(
                                  enabled: controller.isLoading.value,
                                  child: buildCompletedRideHistoryMenuList(
                                      controller, colorScheme),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Obx(
                                () => Skeletonizer(
                                  enabled: controller.isLoading.value,
                                  child: buildCancelledRideHistoryMenuList(
                                      controller, colorScheme),
                                ),
                              ),
                            );
                    },
                  ),
                  kSizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildCancelledRideHistoryMenuList(
    RideHistoryMenuController controller,
    ColorScheme colorScheme,
  ) {
    return ListView.separated(
      itemCount: 0,
      controller: controller.scrollController,
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => kSizedBox,
      itemBuilder: (context, index) {
        return rideHistoryDetail(
          colorScheme,
          driverName: "John Kennedy",
          vehicleName: "Mustang Shelby GT",
          isCompleted: false,
        );
      },
    );
  }

  buildCompletedRideHistoryMenuList(
    RideHistoryMenuController controller,
    ColorScheme colorScheme,
  ) {
    return ListView.separated(
      itemCount: 0,
      controller: controller.scrollController,
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => kSizedBox,
      itemBuilder: (context, index) {
        return rideHistoryDetail(
          colorScheme,
          driverName: "John Kennedy",
          vehicleName: "Mustang Shelby GT",
          isCompleted: true,
        );
      },
    );
  }
}
