import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/containers/text_form_field_container.dart';
import 'package:green_wheels/src/utils/textformfields/android/android_textformfield.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../src/constants/consts.dart';

class BookRideCancelRideFeeModal extends GetView<HomeScreenController> {
  const BookRideCancelRideFeeModal({super.key});

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
                    "Cancel Ride",
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
                  Text(
                    "Note:You will be charged 10% of the ride fare",
                    maxLines: 4,
                    textAlign: TextAlign.start,
                    style: defaultTextStyle(
                      fontSize: 12,
                      color: kErrorColor,
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
                            Column(
                              children: List.generate(
                                controller.cancelRequestReasons.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          width: 1.4,
                                          color: controller
                                                      .cancelRequestReasonIsSelected[
                                                  index]
                                              ? kBlackColor
                                              : kDisabledColor,
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        controller.toggleSelection(index);
                                      },
                                      contentPadding: const EdgeInsets.all(0),
                                      dense: true,
                                      title: Text(
                                        controller.cancelRequestReasons[index],
                                        style: defaultTextStyle(
                                          fontSize: 16,
                                          color: controller
                                                      .cancelRequestReasonIsSelected[
                                                  index]
                                              ? kTextBlackColor
                                              : kDisabledTextColor,
                                          fontWeight: controller
                                                      .cancelRequestReasonIsSelected[
                                                  index]
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                        ),
                                      ),
                                      leading: Checkbox(
                                        value: controller
                                                .cancelRequestReasonIsSelected[
                                            index],
                                        activeColor: colorScheme.primary,
                                        checkColor: colorScheme.secondary,
                                        side: const BorderSide(
                                            color: kDisabledColor),
                                        onChanged: (value) =>
                                            controller.toggleSelection(index),
                                      ),
                                    ),
                                  ),
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
                  kSizedBox,
                  Obx(() {
                    return AndroidElevatedButton(
                      title: "Submit",
                      disable:
                          !controller.cancelRequestSubmitButtonIsEnabled.value,
                      onPressed: controller.submitCancelRideReason,
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
