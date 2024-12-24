import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/menu/edit_profile_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/src/utils/containers/text_form_field_container.dart';
import 'package:green_wheels/src/utils/textformfields/android/android_textformfield.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EditProfileScaffold extends GetView<EditProfileController> {
  const EditProfileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(
        colorScheme,
        media,
        actions: [],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: FadeInRight(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                Obx(() {
                  return Skeletonizer(
                    enabled: controller.isLoading.value,
                    effect: PulseEffect(
                      from: Colors.grey.shade200,
                      to: Colors.grey.shade300,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            textAlign: TextAlign.start,
                            style: defaultTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: kTextBlackColor,
                            ),
                          ),
                          kSizedBox,
                          formFieldContainer(
                            colorScheme,
                            media,
                            containerHeight: media.height * .08,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: kFrameBackgroundColor,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Icon(
                                    Iconsax.user,
                                    color: kBlackColor,
                                  ),
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: AndroidTextFormField(
                                    readOnly: controller.isLoading.value,
                                    controller: controller.fullNameEC,
                                    focusNode: controller.fullNameFN,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    hintText: "Enter Full Name",
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Text(
                            "Country",
                            textAlign: TextAlign.start,
                            style: defaultTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: kTextBlackColor,
                            ),
                          ),
                          kSizedBox,
                          formFieldContainer(
                            colorScheme,
                            media,
                            containerHeight: media.height * .08,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: kFrameBackgroundColor,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Icon(
                                    Iconsax.flag,
                                    color: kBlackColor,
                                  ),
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: AndroidTextFormField(
                                    readOnly: controller.isLoading.value,
                                    controller: controller.countryEC,
                                    focusNode: controller.countryFN,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    hintText: "Enter country",
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Text(
                            "State",
                            textAlign: TextAlign.start,
                            style: defaultTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: kTextBlackColor,
                            ),
                          ),
                          kSizedBox,
                          formFieldContainer(
                            colorScheme,
                            media,
                            containerHeight: media.height * .08,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: kFrameBackgroundColor,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Icon(
                                    Iconsax.map,
                                    color: kBlackColor,
                                  ),
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: AndroidTextFormField(
                                    readOnly: controller.isLoading.value,
                                    controller: controller.stateEC,
                                    focusNode: controller.stateFN,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    hintText: "Enter state",
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Text(
                            "City",
                            textAlign: TextAlign.start,
                            style: defaultTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: kTextBlackColor,
                            ),
                          ),
                          kSizedBox,
                          formFieldContainer(
                            colorScheme,
                            media,
                            containerHeight: media.height * .08,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: kFrameBackgroundColor,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Icon(
                                    Iconsax.buildings,
                                    color: kBlackColor,
                                  ),
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: AndroidTextFormField(
                                    readOnly: controller.isLoading.value,
                                    controller: controller.cityEC,
                                    focusNode: controller.cityFN,
                                    textInputAction: TextInputAction.done,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    hintText: "Enter city",
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kSizedBox,
                          Text(
                            "Street",
                            textAlign: TextAlign.start,
                            style: defaultTextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: kTextBlackColor,
                            ),
                          ),
                          kSizedBox,
                          formFieldContainer(
                            colorScheme,
                            media,
                            containerHeight: media.height * .08,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    color: kFrameBackgroundColor,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(6),
                                    ),
                                  ),
                                  child: const Icon(
                                    Iconsax.location,
                                    color: kBlackColor,
                                  ),
                                ),
                                kHalfWidthSizedBox,
                                Expanded(
                                  child: AndroidTextFormField(
                                    readOnly: controller.isLoading.value,
                                    controller: controller.streetEC,
                                    focusNode: controller.streetFN,
                                    textInputAction: TextInputAction.done,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    hintText: "Enter street",
                                    onFieldSubmitted:
                                        controller.onFieldSubmitted,
                                    validator: (value) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kBigSizedBox,
                          AndroidElevatedButton(
                            title: "Submit",
                            isLoading: controller.isSubmitting.value,
                            onPressed: controller.submitForm,
                          ),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
