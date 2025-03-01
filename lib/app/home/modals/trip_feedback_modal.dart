import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/app/home_screen_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/containers/text_form_field_container.dart';
import 'package:green_wheels/src/utils/textformfields/android/android_textformfield.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/consts.dart';

class TripFeedbackModal extends GetView<HomeScreenController> {
  const TripFeedbackModal({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: controller.feedbackTextFieldIsActive.value
            ? media.height
            : media.height / 1.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Please rate your trip and the driver",
                textAlign: TextAlign.center,
                maxLines: 4,
                style: defaultTextStyle(
                  fontSize: 20,
                  letterSpacing: .4,
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kHalfSizedBox,
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                        onPressed: () {
                          controller.rateRide(media, index);
                        },
                        color: kStarColor,
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        icon: Icon(
                          index < controller.rating.value
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: index < controller.rating.value ? 40 : 36,
                        )),
                  ),
                );
              }),
              kHalfSizedBox,
              Obx(() {
                return controller.hasRated.value
                    ? AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: defaultTextStyle(
                          fontSize: 28,
                          letterSpacing: .4,
                          color: controller.rating.value == 5
                              ? colorScheme.primary
                              : controller.rating.value == 4
                                  ? kSuccessColor
                                  : controller.rating.value == 3
                                      ? kSuccessColor.withValues()
                                      : controller.rating.value == 2
                                          ? kStarColor
                                          : colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Text(
                          controller.rating.value == 5
                              ? "Excellent"
                              : controller.rating.value == 4
                                  ? "Very good"
                                  : controller.rating.value == 3
                                      ? "Good"
                                      : controller.rating.value == 2
                                          ? "Poor"
                                          : "Bad",
                          textAlign: TextAlign.center,
                          maxLines: 4,
                        ),
                      )
                    : const SizedBox();
              }),
              kSizedBox,
              Form(
                key: controller.formKey,
                child: formFieldContainer(
                  colorScheme,
                  media,
                  containerHeight: 160,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: AndroidTextFormField(
                      controller: controller.feedbackMessageEC,
                      textInputAction: TextInputAction.newline,
                      hintText: "Write your text...",
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      focusNode: controller.feedbackMessageFN,
                      onTap: controller.activateFeedbackTextField,
                      onTapOutside: controller.deactivateFeedbackTextField,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              kBigSizedBox,
              Obx(() {
                return AndroidElevatedButton(
                  title: "Submit",
                  disable: !controller.hasRated.value,
                  isLoading: controller.submittingRequest.value,
                  onPressed: controller.submitFeedback,
                );
              }),
              kBigSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}
