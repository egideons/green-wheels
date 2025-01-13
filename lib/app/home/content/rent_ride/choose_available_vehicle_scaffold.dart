import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/home/content/rent_ride/available_vehicle_details_scaffold.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import 'available_car_container.dart';

class ChooseAvailableVehicleScaffold extends GetView<HomeScreenController> {
  const ChooseAvailableVehicleScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: myAppBar(
        colorScheme,
        media,
        title: "Available cars for ride",
        titleFontSize: 22,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: Obx(() {
            var vehicles =
                controller.availableVehiclesReponseModel.value.data.vehicles;
            return ListView.separated(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: vehicles.length,
              separatorBuilder: (context, index) => kSizedBox,
              itemBuilder: (context, index) {
                var vehicle = vehicles[index];
                return FadeInRight(
                  child: Skeletonizer(
                    enabled: controller.isLoadingAvailableVehicles.value,
                    child: availableCarContainer(
                      vehicleName: vehicle.name,
                      vehicleImage: Assets.car3Png,
                      vehicleFuelType: vehicle.specifications.fuelType,
                      vehicleGearType: vehicle.specifications.gearType,
                      numOfSeats: vehicle.specifications.capacity,
                      goToAvailableVehicleDetails: () {
                        Get.to(
                          () =>
                              AvailableVehicleDetailsScaffold(vehicle: vehicle),
                          transition: Transition.rightToLeft,
                          routeName: "/available-vehicle-details",
                          curve: Curves.easeInOut,
                          fullscreenDialog: true,
                          popGesture: true,
                          preventDuplicates: true,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
