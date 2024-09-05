import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/menu/views/car_rentals/content/car_rental_container.dart';
import 'package:green_wheels/src/controllers/menu/car_rentals_menu_controller.dart';

import '../../../../../../../../src/utils/components/my_app_bar.dart';
import '../../../../../../../../theme/colors.dart';
import '../../content/car_rental_menu_tabs.dart';

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
                  // GetBuilder<CarRentalMenuController>(
                  //   init: CarRentalMenuController(),
                  //   builder: (controller) {
                  //     return controller.selectedTabBar.value == 0
                  //         ? Expanded(
                  //             child: Obx(
                  //               () => Skeletonizer(
                  //                 enabled: controller.isLoading.value,
                  //                 child: buildOngoingCarRentalList(
                  //                   colorScheme,
                  //                   media,
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //         : controller.selectedTabBar.value == 1
                  //             ? Expanded(
                  //                 child: Obx(
                  //                   () => Skeletonizer(
                  //                     enabled: controller.isLoading.value,
                  //                     child: buildCompletedCarRentalList(
                  //                       colorScheme,
                  //                       media,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               )
                  //             : Expanded(
                  //                 child: Obx(
                  //                   () => Skeletonizer(
                  //                     enabled: controller.isLoading.value,
                  //                     child: buildCancelledCarRentalList(
                  //                       colorScheme,
                  //                       media,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //   },
                  // ),
                carRentalContainer(colorScheme,child: )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
