import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/menu/ride_history_menu_controller.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../src/constants/consts.dart';
import '../../../../../../theme/colors.dart';
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
            child: Obx(() {
              return Column(
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
                                  child: ListView.separated(
                                    itemCount: 10,
                                    controller: controller.scrollController,
                                    padding: const EdgeInsets.all(10),
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        kSizedBox,
                                    itemBuilder: (context, index) {
                                      return rideHistoryDetail(
                                        colorScheme,
                                        driverName: "John Kennedy",
                                        vehicleName: "Mustang Shelby GT",
                                        isCompleted: true,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Obx(
                                () => Skeletonizer(
                                  enabled: controller.isLoading.value,
                                  child: ListView.separated(
                                    itemCount: 10,
                                    controller: controller.scrollController,
                                    padding: const EdgeInsets.all(10),
                                    physics: const BouncingScrollPhysics(),
                                    separatorBuilder: (context, index) =>
                                        kSizedBox,
                                    itemBuilder: (context, index) {
                                      return rideHistoryDetail(
                                        colorScheme,
                                        driverName: "John Kennedy",
                                        vehicleName: "Mustang Shelby GT",
                                        isCompleted: false,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                  kSizedBox,
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  rideHistoryDetail(
    ColorScheme colorScheme, {
    String? driverName,
    String? vehicleName,
    bool? isCompleted,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: kFrameBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            width: .8,
            color: colorScheme.primary,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driverName ?? "",
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                vehicleName ?? "",
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            isCompleted ?? true ? "Done" : "Cancelled",
            style: defaultTextStyle(
              color: isCompleted ?? true ? kSuccessColor : kErrorColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
