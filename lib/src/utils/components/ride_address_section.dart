import 'package:flutter/material.dart';

import '../../constants/consts.dart';
import 'ride_location_icons.dart';
import 'ride_locations.dart';

rideAddressSection(
  ColorScheme colorScheme, {
  String? pickup,
  String? destination,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      rideLocationsIcons(colorScheme),
      kHalfWidthSizedBox,
      rideLocations(
        pickup: pickup ?? "",
        destination: destination ?? "",
      ),
    ],
  );
}
