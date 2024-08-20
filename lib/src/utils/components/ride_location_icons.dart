import 'package:flutter/material.dart';

rideLocationsIcons(
  ColorScheme colorScheme, {
  bool? stopLocationIsVisible = false,
}) {
  return Column(
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: colorScheme.primary,
        ),
        child: Center(
          child: Icon(
            Icons.circle,
            color: colorScheme.surface,
            size: 16,
          ),
        ),
      ),
      stopLocationIsVisible == true
          ? Container(
              height: 28,
              width: 1,
              color: colorScheme.primary,
            )
          : const SizedBox(),
      stopLocationIsVisible == true
          ? Container(
              width: 32,
              height: 32,
              decoration: ShapeDecoration(
                  shape: const CircleBorder(), color: colorScheme.primary),
              child: Icon(
                Icons.location_on_outlined,
                color: colorScheme.secondary,
                size: 16,
              ),
            )
          : const SizedBox(),
      Container(
        height: 28,
        width: 1,
        color: colorScheme.primary,
      ),
      Container(
        width: 32,
        height: 32,
        decoration: ShapeDecoration(
            shape: const CircleBorder(), color: colorScheme.primary),
        child: Icon(
          Icons.location_on_outlined,
          color: colorScheme.secondary,
          size: 16,
        ),
      ),
    ],
  );
}
