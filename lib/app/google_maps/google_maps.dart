import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/app/google_maps_controller.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:place_picker_google/place_picker_google.dart';

class GoogleMaps extends GetView<GoogleMapsController> {
  final double? latitude;
  final double? longitude;
  const GoogleMaps({this.latitude, this.longitude, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final userPosition = controller.userPosition.value;
          if (userPosition == null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return PlacePicker(
              apiKey: controller.googlePlacesApiKey ?? "",
              onMapCreated: controller.onMapCreated,
              onPlacePicked: controller.onPlacePicked,
              enableNearbyPlaces: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              usePinPointingSearch: true,
              showSearchInput: true,
              autocompletePlacesSearchRadius: userPosition.latitude,
              pinPointingDebounceDuration: 2,
              initialLocation: LatLng(
                (latitude != null && latitude.toString().isNotEmpty)
                    ? latitude!
                    : userPosition.latitude,
                (longitude != null && longitude.toString().isNotEmpty)
                    ? longitude!
                    : userPosition.longitude,
              ),
              nearbyPlaceItemStyle: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              nearbyPlaceStyle: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              selectedLocationNameStyle: defaultTextStyle(
                color: kTextBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              selectedFormattedAddressStyle: defaultTextStyle(
                color: kTextGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              searchInputConfig: SearchInputConfig(
                autofocus: false,
                showCursor: true,
                textAlignVertical: TextAlignVertical.center,
                textDirection: TextDirection.ltr,
                padding: EdgeInsets.all(10),
                textCapitalization: TextCapitalization.words,
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              searchInputDecorationConfig: SearchInputDecorationConfig(
                hintText: "Search for a building, street or ...",
                contentPadding: const EdgeInsets.all(10),
                hintStyle: defaultTextStyle(
                  color: kTextGreyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
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
