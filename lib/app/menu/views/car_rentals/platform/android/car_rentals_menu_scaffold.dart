import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/controllers/menu/car_rentals_menu_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../../src/utils/components/my_app_bar.dart';
import '../../../../../../../../theme/colors.dart';
import '../../../../../../src/constants/consts.dart';
import '../../content/cancelled_car_rental_container.dart';
import '../../content/car_rental_menu_tabs.dart';
import '../../content/completed_car_rental_container.dart';
import '../../content/ongoing_car_rental_container.dart';

class CarRentalMenuScaffold extends GetView<CarRentalMenuController> {
  const CarRentalMenuScaffold({super.key});

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
        title: "Car rental",
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
        () => SafeArea(
          maintainBottomViewPadding: true,
          child: RefreshIndicator.adaptive(
            onRefresh: controller.onRefresh,
            color: colorScheme.secondary,
            backgroundColor: colorScheme.primary,
            child: Scrollbar(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // controller.isLoading.value
                  //     ? loadingIndicator(
                  //         media.width,
                  //         colorScheme: colorScheme.primary,
                  //       )
                  //     : const SizedBox(),
                  carRentalMenuTabs(colorScheme, controller),
                  GetBuilder<CarRentalMenuController>(
                    init: CarRentalMenuController(),
                    builder: (controller) {
                      return controller.selectedTabBar.value == 0
                          ? Expanded(
                              child: Obx(
                                () => Skeletonizer(
                                  enabled: controller.isLoading.value,
                                  child: buildOngoingCarRentalList(
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
                                      child: buildCompletedCarRentalList(
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
                                      child: buildCancelledCarRentalList(
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
        ),
      ),
    );
  }

  buildOngoingCarRentalList(ColorScheme colorScheme, Size media) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) => kHalfSizedBox,
      itemBuilder: (context, index) {
        return ongoingCarRentalContainer(
          colorScheme,
          media,
          vehicleImage: Assets.car3Png,
          vehicleName: "Mustang Shelby GT",
          numOfStars: 5,
          vehiclePlateNumber: "ABJ23 456",
          amount: controller.rentRideAmountPerHour.value,
          view: () {},
        );
      },
    );
  }

  buildCompletedCarRentalList(ColorScheme colorScheme, Size media) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) => kHalfSizedBox,
      itemBuilder: (context, index) {
        return completedCarRentalContainer(
          colorScheme,
          media,
          vehicleImage: Assets.car3Png,
          vehicleName: "Mustang Shelby GT",
          vehiclePlateNumber: "ABJ23 456",
          amount: controller.rentRideAmountPerHour.value,
        );
      },
    );
  }

  buildCancelledCarRentalList(ColorScheme colorScheme, Size media) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) => kHalfSizedBox,
      itemBuilder: (context, index) {
        return cancelledCarRentalContainer(
          colorScheme,
          media,
          vehicleImage: Assets.car3Png,
          vehicleName: "Mustang Shelby GT",
          numOfStars: 5,
          vehiclePlateNumber: "ABJ23 456",
          amount: controller.rentRideAmountPerHour.value,
        );
      },
    );
  }
}
