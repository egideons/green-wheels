import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/auth/signup_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../content/signup_form.dart';

class SignupScaffold extends GetView<SignupController> {
  const SignupScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<SignupController>(
        init: SignupController(),
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
                    "Enter Mobile Number",
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
                      child: signupForm(colorScheme, media, loginController),
                    ),
                  ),
                  kSizedBox,
                  AndroidElevatedButton(
                    title: "Sign In",
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
