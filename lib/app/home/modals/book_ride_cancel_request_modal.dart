import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/containers/text_form_field_container.dart';
import 'package:green_wheels/src/utils/textformfields/android/android_textformfield.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/constants/consts.dart';

class BookRideCancelRequest extends GetView<HomeScreenController> {
  const BookRideCancelRequest({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: media.width,
      decoration: ShapeDecoration(
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Column(
        children: [
          kSmallSizedBox,
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Get.close(0);
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: kBlackColor,
                size: 32,
              ),
            ),
          ),
          kSizedBox,
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cancel Request",
                    textAlign: TextAlign.start,
                    style: defaultTextStyle(
                      fontSize: 25,
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  kSizedBox,
                  Text(
                    "Please select the reason for cancellation",
                    textAlign: TextAlign.start,
                    style: defaultTextStyle(
                      fontSize: 16,
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  kSizedBox,
                  Obx(
                    () {
                      return Form(
                        key: controller.cancelRequestFormKey,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    width: 1.4,
                                    color: controller
                                            .cancelRequestReasonIsSelected[0]
                                        ? kBlackColor
                                        : kDisabledColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  controller.toggleSelection(0);
                                },
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                title: Text(
                                  "Waited for a long time",
                                  style: defaultTextStyle(
                                    fontSize: 16,
                                    color: controller
                                            .cancelRequestReasonIsSelected[0]
                                        ? kTextBlackColor
                                        : kDisabledTextColor,
                                    fontWeight: controller
                                            .cancelRequestReasonIsSelected[0]
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: controller
                                      .cancelRequestReasonIsSelected[0],
                                  activeColor: colorScheme.primary,
                                  checkColor: colorScheme.secondary,
                                  side: const BorderSide(color: kDisabledColor),
                                  onChanged: (value) =>
                                      controller.toggleSelection(0),
                                ),
                              ),
                            ),
                            kHalfSizedBox,
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    width: 1.4,
                                    color: controller
                                            .cancelRequestReasonIsSelected[1]
                                        ? kBlackColor
                                        : kDisabledColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  controller.toggleSelection(1);
                                },
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                title: Text(
                                  "Unable to contact the driver",
                                  style: defaultTextStyle(
                                    fontSize: 16,
                                    color: controller
                                            .cancelRequestReasonIsSelected[1]
                                        ? kTextBlackColor
                                        : kDisabledTextColor,
                                    fontWeight: controller
                                            .cancelRequestReasonIsSelected[1]
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: controller
                                      .cancelRequestReasonIsSelected[1],
                                  activeColor: colorScheme.primary,
                                  checkColor: colorScheme.secondary,
                                  side: const BorderSide(color: kDisabledColor),
                                  onChanged: (bool? value) {
                                    controller.toggleSelection(1);
                                  },
                                ),
                              ),
                            ),
                            kHalfSizedBox,
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    width: 1.4,
                                    color: controller
                                            .cancelRequestReasonIsSelected[2]
                                        ? kBlackColor
                                        : kDisabledColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  controller.toggleSelection(2);
                                },
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                title: Text(
                                  "Wrong location inputted",
                                  style: defaultTextStyle(
                                    fontSize: 16,
                                    color: controller
                                            .cancelRequestReasonIsSelected[2]
                                        ? kTextBlackColor
                                        : kDisabledTextColor,
                                    fontWeight: controller
                                            .cancelRequestReasonIsSelected[2]
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: controller
                                      .cancelRequestReasonIsSelected[2],
                                  activeColor: colorScheme.primary,
                                  checkColor: colorScheme.secondary,
                                  side: const BorderSide(color: kDisabledColor),
                                  onChanged: (bool? value) {
                                    controller.toggleSelection(2);
                                  },
                                ),
                              ),
                            ),
                            kHalfSizedBox,
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    width: 1.4,
                                    color: controller
                                            .cancelRequestReasonIsSelected[3]
                                        ? kBlackColor
                                        : kDisabledColor,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  controller.toggleSelection(3);
                                },
                                contentPadding: const EdgeInsets.all(0),
                                dense: true,
                                title: Text(
                                  "Other",
                                  style: defaultTextStyle(
                                    fontSize: 16,
                                    color: controller
                                            .cancelRequestReasonIsSelected[3]
                                        ? kTextBlackColor
                                        : kDisabledTextColor,
                                    fontWeight: controller
                                            .cancelRequestReasonIsSelected[3]
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: controller
                                      .cancelRequestReasonIsSelected[3],
                                  activeColor: colorScheme.primary,
                                  checkColor: colorScheme.secondary,
                                  side: const BorderSide(color: kDisabledColor),
                                  onChanged: (bool? value) {
                                    controller.toggleSelection(3);
                                  },
                                ),
                              ),
                            ),
                            kSizedBox,
                            if (controller.cancelRequestReasonIsSelected[3])
                              formFieldContainer(
                                colorScheme,
                                media,
                                containerHeight: 160,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: AndroidTextFormField(
                                    controller: controller.otherOptionEC,
                                    focusNode: controller.otherOptionFN,
                                    validator: (value) {
                                      return null;
                                    },
                                    onChanged: controller.otherOptionOnchanged,
                                    hintText: "Please specify",
                                    textInputAction: TextInputAction.newline,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                              )
                            else
                              const SizedBox()
                          ],
                        ),
                      );
                    },
                  ),
                  kSizedBox,
                  Obx(() {
                    return AndroidElevatedButton(
                      title: "Submit",
                      disable:
                          !controller.cancelRequestSubmitButtonIsEnabled.value,
                      onPressed: controller.submitCancelRequestReason,
                    );
                  }),
                  SizedBox(height: media.height * .5)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
