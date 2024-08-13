import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/controllers/auth/login_controller.dart';
import '../../content/login_form.dart';

class LoginScaffold extends GetView<LoginController> {
  const LoginScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: myAppBar(colorScheme, media),
            body: SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: kDefaultPadding * 4),
                  const Text(
                    "Enter Mobile Number",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: kTextBlackColor,
                    ),
                  ),
                  kSizedBox,
                  Obx(
                    () => Form(
                      key: controller.formKey,
                      child: loginForm(colorScheme, media, controller),
                    ),
                  ),
                  kSizedBox,
                  AndroidElevatedButton(
                    title: "Sign In",
                    isLoading: controller.isLoading.value,
                    onPressed: controller.login,
                  ),
                  kSizedBox,
                ],
              ),
            ),
          );
        });
  }
}
