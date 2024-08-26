import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/others/loading_controller.dart';
import '../../content/loading_screen_content.dart';

class LoadingScreenScaffold extends GetView<LoadingController> {
  final void Function()? loadData;
  const LoadingScreenScaffold({super.key, this.loadData});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    Timer(Duration.zero, loadData ?? () {});

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: loadingScreenContent(media, colorScheme),
        ),
      ),
    );
  }
}
