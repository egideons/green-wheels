import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../src/controllers/app/home_screen_controller.dart';

homeGoogleMap(HomeScreenController controller, ColorScheme colorScheme) {
  return Obx(
    () {
      final userPosition = controller.userPosition.value;
      // final locationPinIsVisible = controller.locationPinIsVisible.value;
      final routeIsVisible = controller.routeIsVisible.value;

      return userPosition == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  buildingsEnabled: false,
                  compassEnabled: false,
                  trafficEnabled: false,
                  mapToolbarEnabled: false,
                  minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                  tiltGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  fortyFiveDegreeImageryEnabled: true,
                  liteModeEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  cameraTargetBounds: CameraTargetBounds.unbounded,
                  rotateGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  onMapCreated: controller.onMapCreated,
                  // padding: const EdgeInsets.only(bottom: 90),
                  markers: Set<Marker>.of(controller.markers),
                  polylines: routeIsVisible
                      ? {
                          Polyline(
                            polylineId: const PolylineId("Travel route"),
                            points: controller.polylineCoordinates,
                            color: colorScheme.primary,
                            consumeTapEvents: true,
                            geodesic: true,
                            startCap: Cap.squareCap,
                            endCap: Cap.roundCap,
                            jointType: JointType.round,
                            width: 4,
                            visible: true,
                          ),
                        }
                      : {},
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      userPosition.latitude,
                      userPosition.longitude,
                    ),
                    zoom: 12,
                    tilt: 40,
                  ),
                ),
              ],
            );
    },
  );
}

                // if (locationPinIsVisible)
                //   Center(
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //         bottom: controller.locationPinBottomPadding.value,
                //       ),
                //       child: Image.asset(
                //         Assets.locationPin1Png,
                //         height: 50,
                //         width: 50,
                //       ),
                //     ),
                //   ),