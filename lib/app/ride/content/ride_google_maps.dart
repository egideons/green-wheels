import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../src/controllers/app/ride_controller.dart';

rideGoogleMap(RideController controller, ColorScheme colorScheme) {
  return Obx(() {
    return controller.routeIsVisible.value
        ? GoogleMap(
            mapType: MapType.hybrid,
            compassEnabled: false,
            mapToolbarEnabled: false,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            fortyFiveDegreeImageryEnabled: true,
            myLocationButtonEnabled: true,
            liteModeEnabled: false,
            myLocationEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            onMapCreated: controller.onMapCreated,
            padding: const EdgeInsets.only(bottom: 90),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.tryParse(controller.pickupLat)!,
                double.tryParse(controller.pickupLong)!,
              ),
              zoom: 17.4,
              tilt: 40,
            ),
            markers: Set<Marker>.of(controller.markers),
            polylines: {
                Polyline(
                  polylineId: const PolylineId("Travel route"),
                  points: controller.polylineCoordinates,
                  color: colorScheme.primary,
                  consumeTapEvents: true,
                  geodesic: true,
                  width: 5,
                  visible: true,
                ),
              })
        : GoogleMap(
            mapType: MapType.normal,
            compassEnabled: false,
            mapToolbarEnabled: false,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            tiltGesturesEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            fortyFiveDegreeImageryEnabled: true,
            myLocationButtonEnabled: true,
            liteModeEnabled: false,
            myLocationEnabled: true,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            onMapCreated: controller.onMapCreated,
            padding: const EdgeInsets.only(bottom: 90),
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.tryParse(controller.pickupLat)!,
                double.tryParse(controller.pickupLong)!,
              ),
              zoom: 17.4,
              tilt: 40,
            ),
            markers: Set<Marker>.of(controller.markers),
            polylines: {
                Polyline(
                  polylineId: const PolylineId("Travel route"),
                  points: controller.polylineCoordinates,
                  color: colorScheme.primary,
                  consumeTapEvents: true,
                  geodesic: true,
                  width: 5,
                  visible: true,
                ),
              });
  });
}
