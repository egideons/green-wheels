import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/src/controllers/app/google_maps_controller.dart';
import 'package:place_picker_google/place_picker_google.dart';

class GoogleMaps extends GetView<GoogleMapsController> {
  const GoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    // var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Obx(
        () {
          final userPosition = controller.userPosition.value;
          final locationPinIsVisible = controller.locationPinIsVisible.value;
          final pinnedLocation = controller.pinnedLocation.value;
          if (userPosition == null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return PlacePicker(
              apiKey: controller.googlePlacesApiKey ?? "",
              onPlacePicked: (LocationResult result) {
                debugPrint("Place picked: ${result.formattedAddress}");
              },
              initialLocation: LatLng(
                userPosition.latitude,
                userPosition.longitude,
              ),
              searchInputConfig: const SearchInputConfig(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                autofocus: false,
                textDirection: TextDirection.ltr,
              ),
              searchInputDecorationConfig: const SearchInputDecorationConfig(
                hintText: "Search for a building, street or ...",
              ),
            );
            // return Stack(
            //   children: [
            //     GoogleMap(
            //       mapType: MapType.normal,
            //       buildingsEnabled: false,
            //       compassEnabled: false,
            //       trafficEnabled: false,
            //       mapToolbarEnabled: false,
            //       minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            //       tiltGesturesEnabled: true,
            //       zoomControlsEnabled: false,
            //       zoomGesturesEnabled: true,
            //       fortyFiveDegreeImageryEnabled: true,
            //       myLocationButtonEnabled: true,
            //       liteModeEnabled: false,
            //       myLocationEnabled: true,
            //       cameraTargetBounds: CameraTargetBounds.unbounded,
            //       rotateGesturesEnabled: true,
            //       scrollGesturesEnabled: true,
            //       onMapCreated: controller.onMapCreated,
            //       padding: EdgeInsets.only(
            //         top: 40,
            //         bottom: pinnedLocation.isNotEmpty ? 100 : 0,
            //       ),
            //       onCameraIdle: controller.onCameraIdle,
            //       onCameraMove: controller.onCameraMove,
            //       initialCameraPosition: CameraPosition(
            //         target: LatLng(
            //           userPosition.latitude,
            //           userPosition.longitude,
            //         ),
            //         zoom: 16,
            //       ),
            //     ),
            //     if (locationPinIsVisible)
            //       Center(
            //         child: Padding(
            //           padding: EdgeInsets.only(
            //             bottom: controller.locationPinBottomPadding.value,
            //           ),
            //           child: Image.asset(
            //             Assets.locationPin1Png,
            //             height: 50,
            //             width: 50,
            //           ),
            //         ),
            //       ),
            //     if (pinnedLocation.isNotEmpty)
            //       AnimatedPositioned(
            //         bottom: 0,
            //         left: 0,
            //         right: 0,
            //         duration: Duration(milliseconds: 800),
            //         curve: Curves.bounceIn,
            //         child: AnimatedContainer(
            //           duration: Duration(milliseconds: 500),
            //           curve: Curves.bounceIn,
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 10,
            //             vertical: 20,
            //           ),
            //           decoration: ShapeDecoration(
            //             color: colorScheme.surface,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(
            //                 controller.pinnedLocation.value,
            //                 textAlign: TextAlign.center,
            //                 style: defaultTextStyle(
            //                   color: kTextBlackColor,
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //               ),
            //               kHalfSizedBox,
            //               AndroidElevatedButton(
            //                 title: "Save",
            //                 onPressed: controller.save,
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //   ],
            // );
          }
        },
      ),
    );
  }
}
