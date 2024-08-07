import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/others/onboarding_controller.dart';
import '../../content/bottom_buttons.dart';
import '../../content/page_text_content.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: media.height / 2,
              width: media.width,
              child: PageView.builder(
                // onPageChanged: (index) => controller.setIsLastPage(index),
                controller: controller.imageController.value,
                itemCount: controller.onboardContent.value.items.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SvgPicture.asset(
                    controller.onboardContent.value.items[index].image,
                    height: media.height / 2,
                    width: media.width,
                  );
                },
              ),
            ),
            Obx(
              () => controller.currentPage.value + 1 ==
                      controller.onboardContent.value.items.length
                  ? const SizedBox()
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
            Positioned(
              bottom: 0,
              // right: 0,
              // left: 0,
              child: Container(
                height: media.height / 2.12,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        // onPageChanged: (index) =>
                        //     controller.setIsLastPage(index),
                        controller: controller.pageController.value,
                        itemCount: controller.onboardContent.value.items.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return pageTextContent(index, controller);
                        },
                      ),
                    ),
                    smoothPageIndicator(colorScheme, controller),
                    kSizedBox,
                    Obx(
                      () => bottomButtons(media, controller),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
