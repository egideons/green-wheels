import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../src/controllers/auth/provide_name_controller.dart';
import '../../content/provide_name_form.dart';

class ProvideNameScaffold extends GetView<ProvideNameController> {
  final bool? isEmailSignup;
  const ProvideNameScaffold({super.key, this.isEmailSignup});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<ProvideNameController>(
      init: ProvideNameController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar:
              myAppBar(colorScheme, media, title: "", leadingIsVisible: false),
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: kDefaultPadding * 4),
                Text(
                  "How would you like to be addressed?",
                  textAlign: TextAlign.start,
                  maxLines: 10,
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
                    child: provideNameForm(colorScheme, media, controller),
                  ),
                ),
                kBigSizedBox,
                Obx(
                  () {
                    return AndroidElevatedButton(
                      title: "Continue",
                      isLoading: controller.isLoading.value,
                      disable: controller.formIsValid.value ? false : true,
                      onPressed: isEmailSignup == true
                          ? controller.toProvidePhone
                          : controller.toHomeScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
