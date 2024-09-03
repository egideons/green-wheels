import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';

class AvailableVehicleDetailsScaffold extends GetView<HomeScreenController> {
  const AvailableVehicleDetailsScaffold({
    required this.vehicleImage,
    required this.vehicleGearType,
    required this.vehicleFuelType,
    required this.vehicleName,
    required this.numOfSeats,
    required this.model,
    required this.maxHorsePower,
    required this.maxSpeed,
    required this.capacity,
    required this.numOfReviews,
    required this.acceleration,
    required this.rating,
    super.key,
  });

  final String vehicleName,
      vehicleImage,
      vehicleGearType,
      vehicleFuelType,
      model;
  final int numOfSeats, maxHorsePower, maxSpeed, capacity, numOfReviews;
  final double acceleration, rating;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: myAppBar(
        colorScheme,
        media,
        title: vehicleName,
        titleFontSize: 22,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: const [],
          ),
        ),
      ),
    );
  }
}
