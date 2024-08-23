import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/textformfields/android/android_textformfield.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/ride_controller.dart';
import '../../../src/utils/components/responsive_constants.dart';

class TripFeedbackModal extends GetView<RideController> {
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding),
        ),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              height: controller.pageChanged.value
                  ? deviceType(media.width) > 3 && deviceType(media.width) < 5
                      ? media.height * 0.75
                      : deviceType(media.width) > 2
                          ? media.height * 0.58
                          : media.height * 0.5
                  : deviceType(media.width) > 3 && deviceType(media.width) < 5
                      ? media.height * 0.35
                      : deviceType(media.width) > 2
                          ? media.height * 0.25
                          : media.height * 0.45,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: PageView(
                controller: controller.ratingPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildThanksNote(colorScheme),
                  controller.submittingRequest.value
                      ? Center(
                          child: CircularProgressIndicator(
                              color: colorScheme.primary),
                        )
                      : _causeOfRating(
                          controller.myMessageEC,
                          (value) {
                            if (value == null || value == "") {
                              return "Field cannot be left empty";
                            }
                            return null;
                          },
                          controller.myMessageFN,
                          controller.formKey,
                        ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: controller.pageChanged.value == false
                      ? kGreyColor
                      : colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(kDefaultPadding),
                    bottomRight: Radius.circular(kDefaultPadding),
                  ),
                ),
                child: controller.pageChanged.value == false
                    ? const MaterialButton(
                        enableFeedback: true,
                        onPressed: null,
                        disabledElevation: 0.0,
                        disabledColor: kGreyColor,
                        disabledTextColor: kTextBlackColor,
                        mouseCursor: SystemMouseCursors.click,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(kDefaultPadding),
                            bottomRight: Radius.circular(kDefaultPadding),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      )
                    : MaterialButton(
                        enableFeedback: true,
                        onPressed: () {},
                        mouseCursor: SystemMouseCursors.click,
                        color: colorScheme.primary,
                        height: 50,
                        focusElevation: kDefaultPadding,
                        focusColor: colorScheme.primary,
                        hoverElevation: 10.0,
                        hoverColor: colorScheme.primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(kDefaultPadding),
                            bottomRight: Radius.circular(kDefaultPadding),
                          ),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                      ),
              ),
            ),
            AnimatedPositioned(
              top: deviceType(media.width) > 3 && deviceType(media.width) < 5
                  ? controller.starPosition3
                  : deviceType(media.width) > 2
                      ? controller.starPosition2
                      : controller.starPosition,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => IconButton(
                    onPressed: () {
                      controller.ratingPageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );

                      // setState(
                      //   () {
                      //     _starPosition = deviceType(media.width) > 2 &&
                      //             deviceType(media.width) < 5
                      //         ? 1
                      //         : 10;
                      //     _rating = index + 1;
                      //     controller.pageChanged.value = true;
                      //   },
                      // );
                    },
                    color: kStarColor,
                    icon: index < controller.rating
                        ? const Icon(Icons.star, size: 30)
                        : const Icon(Icons.star_outline, size: 26),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_buildThanksNote(ColorScheme colorScheme) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "We'd love to get your feedback",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      kHalfSizedBox,
      const Text(
        "Rate this product",
      ),
    ],
  );
}

_causeOfRating(
  final TextEditingController controller,
  final FormFieldValidator validator,
  final FocusNode focusNode,
  final Key formKey,
) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Visibility(
        visible: true,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        maintainInteractivity: true,
        maintainSemantics: true,
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              kSizedBox,
              kSizedBox,
              const SizedBox(height: 20, child: Text("What could be better?")),
              kHalfSizedBox,
              SizedBox(
                height: 250,
                child: AndroidTextFormField(
                  controller: controller,
                  validator: validator,
                  textInputAction: TextInputAction.newline,
                  focusNode: focusNode,
                  hintText: "Enter your review (required)",
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  maxLength: 1000,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              kSizedBox,
              kSizedBox,
            ],
          ),
        ),
      ),
    ],
  );
}
