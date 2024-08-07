import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../theme/colors.dart';
import '../../constants/consts.dart';
import '../buttons/android/android_elevated_button.dart';
import '../buttons/ios/cupertino_elevated_button.dart';

class AppErrorWidget extends StatelessWidget {
  final Function()? onPressed;
  const AppErrorWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    if (Platform.isAndroid) {
      Material(
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Iconsax.warning_2,
                size: 200,
                color: kWarningColor,
              ),
              kSizedBox,
              kSizedBox,
              const Text(
                'Oops..something unexpected happened.',
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kSizedBox,
              AndroidElevatedButton(
                onPressed: onPressed ??
                    () {
                      Get.close(0);
                    },
                title: "Go back",
              ),
            ],
          ),
        ),
      );
    }
    return Material(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.warning_2,
              size: 200,
              color: kWarningColor,
            ),
            kSizedBox,
            kSizedBox,
            const Text(
              'Oops..something unexpected happened.',
              maxLines: 4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            kSizedBox,
            CupertinoElevatedButton(
              onPressed: onPressed ??
                  () {
                    Get.close(0);
                  },
              title: "Go back",
            ),
          ],
        ),
      ),
    );
  }
}
