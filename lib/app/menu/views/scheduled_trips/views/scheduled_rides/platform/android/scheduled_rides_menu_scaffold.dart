import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../src/constants/consts.dart';
import '../../../../../../../../src/controllers/menu/scheduled_rides_menu_controller.dart';
import '../../../../../../../../src/utils/components/loading_indicator.dart';
import '../../../../../../../../src/utils/components/my_app_bar.dart';
import '../../../../../../../../src/utils/components/scheduled_trips_container.dart';
import '../../../../../../../../theme/colors.dart';
import '../../content/cancelled_scheduled_ride_container.dart';
import '../../content/completed_scheduled_ride_container.dart';
import '../../content/pending_scheduled_ride_container.dart';
import '../../content/scheduled_rides_tabs.dart';

class ScheduledRidesMenuScaffold extends GetView<ScheduledRidesMenuController> {
  const ScheduledRidesMenuScaffold({super.key});

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
        title: "Scheduled Rides",
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: scheduledRidesTabs(colorScheme, controller),
                    ),
                    Expanded(
                      child: ListView(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.all(kDefaultPadding),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Container(
                            child: controller.isLoading.value
                                ? const SizedBox()
                                : controller.selectedTabBar.value == 0
                                    ? ListView.separated(
                                        itemCount: 10,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            kHalfSizedBox,
                                        itemBuilder: (context, index) {
                                          return scheduledTripContainer(
                                            colorScheme,
                                            child:
                                                pendingScheduledRideContainer(
                                              colorScheme,
                                              media,
                                              driverName: "John Kennedy",
                                              vehicleName: "Mustang Shelby GT",
                                              pickup: "Festac Shopping Mall",
                                              amount: 8000,
                                              destination:
                                                  "Holy Family Catholic church, 22 road, Festac Town",
                                              viewPendingScheduledRide: () {},
                                            ),
                                          );
                                        },
                                      )
                                    : controller.selectedTabBar.value == 1
                                        ? ListView.separated(
                                            itemCount: 10,
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    kHalfSizedBox,
                                            itemBuilder: (context, index) {
                                              return scheduledTripContainer(
                                                colorScheme,
                                                child:
                                                    completedScheduledRideContainer(
                                                  colorScheme,
                                                  media,
                                                  driverName: "John Kennedy",
                                                  vehicleName:
                                                      "Mustang Shelby GT",
                                                  pickup:
                                                      "Festac Shopping Mall",
                                                  amount: 8000,
                                                  destination:
                                                      "Holy Family Catholic church, 22 road, Festac Town",
                                                  viewPendingScheduledRide:
                                                      () {},
                                                ),
                                              );
                                            },
                                          )
                                        : ListView.separated(
                                            itemCount: 10,
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    kHalfSizedBox,
                                            itemBuilder: (context, index) {
                                              return scheduledTripContainer(
                                                colorScheme,
                                                child:
                                                    cancelledScheduledRideContainer(
                                                  colorScheme,
                                                  media,
                                                  driverName: "John Kennedy",
                                                  vehicleName:
                                                      "Mustang Shelby GT",
                                                  pickup:
                                                      "Festac Shopping Mall",
                                                  amount: 8000,
                                                  destination:
                                                      "Holy Family Catholic church, 22 road, Festac Town",
                                                  viewPendingScheduledRide:
                                                      () {},
                                                ),
                                              );
                                            },
                                          ),
                          ),
                        ],
                      ),
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
}
