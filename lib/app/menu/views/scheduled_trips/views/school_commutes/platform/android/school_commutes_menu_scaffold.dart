import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../src/constants/consts.dart';
import '../../../../../../../../src/controllers/menu/school_commutes_menu_controller.dart';
import '../../../../../../../../src/utils/components/loading_indicator.dart';
import '../../../../../../../../src/utils/components/my_app_bar.dart';
import '../../../../../../../../src/utils/components/scheduled_trips_container.dart';
import '../../../../../../../../theme/colors.dart';
import '../../content/cancelled_school_commute_container.dart';
import '../../content/completed_school_commute_container.dart';
import '../../content/pending_school_commute_container.dart';
import '../../content/school_commutes_tabs.dart';

class SchoolCommutesMenuScaffold extends GetView<SchoolCommutesMenuController> {
  const SchoolCommutesMenuScaffold({super.key});

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
        title: "School commutes",
      ),
      floatingActionButton: Obx(
        () => controller.isScrollToTopBtnVisible.value
            ? FloatingActionButton.small(
                onPressed: controller.scrollToTop,
                backgroundColor: colorScheme.primary,
                foregroundColor: kLightBackgroundColor,
                child: const Icon(Icons.keyboard_arrow_up),
              )
            : const SizedBox(),
      ),
      body: Obx(
        () {
          return SafeArea(
            maintainBottomViewPadding: true,
            child: RefreshIndicator.adaptive(
              onRefresh: controller.onRefresh,
              color: colorScheme.secondary,
              backgroundColor: colorScheme.primary,
              child: Scrollbar(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isLoading.value
                        ? loadingIndicator(
                            media.width,
                            colorScheme: colorScheme.primary,
                          )
                        : const SizedBox(),
                    schoolCommutesTabs(colorScheme, controller),
                    GetBuilder<SchoolCommutesMenuController>(
                      init: SchoolCommutesMenuController(),
                      builder: (controller) {
                        return controller.selectedTabBar.value == 0
                            ? Expanded(
                                child: Obx(
                                  () => Skeletonizer(
                                    enabled: controller.isLoading.value,
                                    child: buildPendingSchoolCommuteList(
                                      colorScheme,
                                      media,
                                    ),
                                  ),
                                ),
                              )
                            : controller.selectedTabBar.value == 1
                                ? Expanded(
                                    child: Obx(
                                      () => Skeletonizer(
                                        enabled: controller.isLoading.value,
                                        child: buildCompletedSchoolCommuteList(
                                          colorScheme,
                                          media,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Obx(
                                      () => Skeletonizer(
                                        enabled: controller.isLoading.value,
                                        child: buildCancelledSchoolCommuteList(
                                          colorScheme,
                                          media,
                                        ),
                                      ),
                                    ),
                                  );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  buildPendingSchoolCommuteList(ColorScheme colorScheme, Size media) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) => kHalfSizedBox,
      itemBuilder: (context, index) {
        return scheduledTripContainer(
          colorScheme,
          child: pendingSchoolCommuteContainer(
            colorScheme,
            media,
            driverName: "John Kennedy",
            vehicleName: "Mustang Shelby GT",
            pickup: "Festac Shopping Mall",
            amount: 8000,
            destination: "Holy Family Catholic church, 22 road, Festac Town",
            viewPendingScheduledRide: () {},
          ),
        );
      },
    );
  }

  buildCompletedSchoolCommuteList(ColorScheme colorScheme, Size media) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10),
      controller: controller.scrollController,
      separatorBuilder: (context, index) => kHalfSizedBox,
      itemBuilder: (context, index) {
        return scheduledTripContainer(
          colorScheme,
          child: completedSchoolCommuteContainer(
            colorScheme,
            media,
            driverName: "John Kennedy",
            vehicleName: "Mustang Shelby GT",
            pickup: "Festac Shopping Mall",
            amount: 8000,
            destination: "Holy Family Catholic church, 22 road, Festac Town",
            viewPendingScheduledRide: () {},
          ),
        );
      },
    );
  }

  buildCancelledSchoolCommuteList(ColorScheme colorScheme, Size media) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) => kHalfSizedBox,
      itemBuilder: (context, index) {
        return scheduledTripContainer(
          colorScheme,
          child: cancelledSchoolCommuteContainer(
            colorScheme,
            media,
            driverName: "John Kennedy",
            vehicleName: "Mustang Shelby GT",
            pickup: "Festac Shopping Mall",
            amount: 8000,
            destination: "Holy Family Catholic church, 22 road, Festac Town",
            viewPendingScheduledRide: () {},
          ),
        );
      },
    );
  }
}
