import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/auth/phone_signup_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../content/phone_signup_form.dart';

class PhoneSignupScaffold extends GetView<PhoneSignupController> {
  const PhoneSignupScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<PhoneSignupController>(
      init: PhoneSignupController(),
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
                    child: phoneSignupForm(colorScheme, media, controller),
                  ),
                ),
                Obx(() {
                  return AndroidElevatedButton(
                    title: "Sign Up",
                    disable: controller.isChecked.value ? false : true,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.signup,
                  );
                }),
                kSizedBox,
                Center(
                  child: RichText(
                    maxLines: 10,
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: defaultTextStyle(
                        color: colorScheme.inversePrimary,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          mouseCursor: SystemMouseCursors.click,
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.toPhoneLogin,
                          style: defaultTextStyle(
                            color: colorScheme.primary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                Obx(
                  () {
                    return AndroidElevatedButton(
                      title: "Continue with Email",
                      isLoading: controller.isLoading.value,
                      onPressed: controller.toEmailSignup,
                    );
                  },
                ),
                kSizedBox,
              ],
            ),
          ),
        );
      },
    );
  }
}
