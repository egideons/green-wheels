import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/auth/login_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../content/login_form.dart';

class LoginScaffold extends GetView<LoginController> {
  const LoginScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginController) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(),
            body: SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: kDefaultPadding * 4),
                  const Text(
                    'Sign in with Email Address',
                    textAlign: TextAlign.center,
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
                      child: loginForm(colorScheme, media, loginController),
                    ),
                  ),
                  kSizedBox,
                  // const MobileInput(),
                  // kSizedBox,
                  AndroidElevatedButton(
                    title: "Sign In",
                    disable: loginController.formIsValid.isTrue ? false : true,
                    isLoading: loginController.isLoading.value,
                    onPressed: loginController.login,
                  ),
                  kSizedBox,
                ],
              ),
            ),
          );
        });
  }
}
