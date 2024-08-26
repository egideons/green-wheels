import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/auth/auth_controller.dart';
import '../../content/splash_screen_content.dart';

class StartupSplashAndroidScaffold extends GetView<AuthController> {
  const StartupSplashAndroidScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: splashScreenContent(colorScheme),
        ),
      ),
    );
  }
}
