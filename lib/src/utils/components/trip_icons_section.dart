import 'package:flutter/material.dart';

tripIconsSection(ColorScheme colorScheme, controller) {
  // return Obx(
  //   () {
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
      Container(
        height: 30,
        width: 1,
        color: colorScheme.primary,
      ),
      // controller.isStopLocationVisible.value
      //     ? Container(
      //         width: 32,
      //         height: 32,
      //         decoration: ShapeDecoration(
      //           shape: const CircleBorder(),
      //           color: controller.isStopLocationTextFieldActive.value
      //               ? colorScheme.primary
      //               : colorScheme.inversePrimary,
      //         ),
      //         child: Center(
      //           child: Icon(
      //             Icons.circle,
      //             color: colorScheme.surface,
      //             size: 16,
      //           ),
      //         ),
      //       )
      //     : const SizedBox(),
      // controller.isStopLocationVisible.value
      //     ? Container(
      //         height: 30,
      //         width: 1,
      //         color: colorScheme.primary,
      //       )
      //     : const SizedBox(),
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
    // ,
//   );
// }
