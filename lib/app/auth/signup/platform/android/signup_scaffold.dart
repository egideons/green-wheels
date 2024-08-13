import 'package:flutter/gestures.dart';
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
        builder: (controller) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(),
            body: SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: kDefaultPadding * 4),
                  Text(
                    "Enter Mobile Number",
                    textAlign: TextAlign.start,
                    style: defaultTextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: kTextBlackColor,
                    ),
                  ),
                  kSizedBox,
                  Obx(
                    () => Form(
                      key: controller.formKey,
                      child: signupForm(colorScheme, media, controller),
                    ),
                  ),
                  Obx(() {
                    return AndroidElevatedButton(
                      title: "Sign Up",
                      disable: controller.isChecked.value ? false : true,
                      isLoading: controller.isLoading.value,
                      onPressed: controller.login,
                    );
                  }),
                  kSizedBox,
                  Center(
                    child: RichText(
                      maxLines: 10,
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: defaultTextStyle(
                          color: kDisabledTextColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            mouseCursor: SystemMouseCursors.click,
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.toLogin,
                            style: defaultTextStyle(
                              color: kPrimaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
