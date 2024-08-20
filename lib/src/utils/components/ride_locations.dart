import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';

rideLocations({
  String? pickup,
  String? destination,
  String? stopLocation,
  bool? stopLocationIsVisible = false,
}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 2),
        Text(
          pickup ?? "",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: defaultTextStyle(
            color: kBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        stopLocationIsVisible == true
            ? const SizedBox(height: 36)
            : const SizedBox(),
        stopLocationIsVisible == true
            ? Text(
                stopLocation ?? "",
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle(
                  color: kBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            : const SizedBox(),
        stopLocationIsVisible == true
            ? const SizedBox(height: 30)
            : const SizedBox(height: 26),
        Text(
          destination ?? "",
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: defaultTextStyle(
            color: kDarkBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
