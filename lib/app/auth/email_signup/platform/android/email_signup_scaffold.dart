import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/controllers/auth/email_signup_controller.dart';
import '../../content/email_signup_form.dart';

class EmailSignupScaffold extends GetView<EmailSignupController> {
  const EmailSignupScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
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
              "Enter Email Address",
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
                child: emailSignupForm(colorScheme, media, controller),
              ),
            ),
            kSizedBox,
            Obx(() {
              return AndroidElevatedButton(
                title: "Sign Up",
                isLoading: controller.isLoading.value,
                disable: !controller.isChecked.value,
                onPressed: controller.signup,
              );
            }),
            kSizedBox,
          ],
        ),
      ),
    );
  }
}
