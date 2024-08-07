import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../src/controllers/auth/auth_controller.dart';

class StartupSplashAndroidScaffold extends GetView<AuthController> {
  const StartupSplashAndroidScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(Assets.appIconLightBg),
                  ),
                ),
              ),
              const SizedBox(
                height: kDefaultPadding * 2,
              ),
              LoadingAnimationWidget.staggeredDotsWave(
                color: colorScheme.secondary,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
