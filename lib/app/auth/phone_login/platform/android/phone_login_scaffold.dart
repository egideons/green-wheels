import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/controllers/auth/phone_login_controller.dart';
import '../../content/login_form.dart';

class PhoneLoginScaffold extends GetView<PhoneLoginController> {
  const PhoneLoginScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<PhoneLoginController>(
        init: PhoneLoginController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            color: colorScheme.primary,
                            height: 1,
                          ),
                        ),
                        kWidthSizedBox,
                        Text(
                          "OR",
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                            fontSize: 14.0,
                            color: colorScheme.primary,
                          ),
                        ),
                        kWidthSizedBox,
                        Flexible(
                          child: Container(
                            color: colorScheme.primary,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kSizedBox,
                  AndroidElevatedButton(
                    title: "Continue with Email",
                    onPressed: controller.toEmailLogin,
                  ),
                  kSizedBox,
                ],
              ),
            ),
          );
        });
  }
}
