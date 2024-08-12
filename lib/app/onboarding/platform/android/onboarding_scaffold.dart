import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/onboarding/content/page_text_content.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/others/onboarding_controller.dart';
import '../../content/bottom_buttons.dart';
import '../../content/smooth_page_indicator.dart';

class OnboardingScaffold extends GetView<OnboardingController> {
  const OnboardingScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: myAppBar(
        colorScheme,
        media,
        toolbarHeight: 0,
        isLeadingVisible: false,
      ),
      body: GetBuilder<OnboardingController>(
        init: OnboardingController(),
        builder: (context) {
          return SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: controller.setIsLastPage,
                  controller: controller.pageController.value,
                  itemCount: controller.onboardContent.items.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Obx(
                          () => controller.currentPage.value + 1 ==
                                  controller.onboardContent.items.length
                              ? const SizedBox(height: 46)
                              : Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: controller.toLogin,
                                    child: Text(
                                      "Skip",
                                      style: defaultTextStyle(
                                        color: colorScheme.primary,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: media.height / 2.6,
                          child: SvgPicture.asset(
                            controller.onboardContent.items[index].image,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: media.width,
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color: colorScheme.surface,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: pageTextContent(index, controller),
                                ),
                                Obx(
                                  () => bottomButtons(media, controller),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 120,
                  left: (media.width / 2.3),
                  child: smoothPageIndicator(colorScheme, controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
