// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../src/controllers/auth/success_screen_controller.dart';
import '../../../../../src/utils/components/my_app_bar.dart';

class SuccessScreenScaffold extends GetView<SuccessScreenController> {
  final Function()? loadScreen;
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  const SuccessScreenScaffold({
    this.title,
    this.subtitleWidget,
    this.subtitle,
    super.key,
    this.loadScreen,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: myAppBar(colorScheme, media, leadingIsVisible: false),
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          children: [
            kSizedBox,
            kSizedBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.greenCheckIconPng,
                  width: 170,
                ),
                kSizedBox,
                Text(
                  title ?? 'Successful!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: kDarkBlackColor,
                  ),
                ),
                kSizedBox,
                subtitleWidget ?? const SizedBox(),
                Text(
                  subtitle ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 20,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: kTextBlackColor,
                  ),
                ),
                kSizedBox,
                kSizedBox,
                AndroidElevatedButton(
                  onPressed: loadScreen,
                  title: "Continue",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
