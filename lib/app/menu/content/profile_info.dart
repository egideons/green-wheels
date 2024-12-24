import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../src/constants/consts.dart';
import '../../../src/controllers/app/menu_screen_controller.dart';
import '../../../src/utils/components/circle_avatar_image.dart';
import '../../../theme/colors.dart';

profileInfo(
  ColorScheme colorScheme,
  Size media,
  MenuScreenController controller,
) {
  return Obx(() {
    return Skeletonizer(
      enabled: controller.isLoadingRiderProfile.value,
      effect: PulseEffect(
        from: Colors.grey.shade200,
        to: Colors.grey.shade300,
      ),
      child: Row(
        children: [
          Obx(() {
            return Center(
              child: Stack(
                children: [
                  controller.selectedProfileImage == null ||
                          controller.profilePicUploadIsCanceled.isTrue
                      ? circleAvatarImage(
                          colorScheme,
                          height: 120,
                          foregroundImage: controller.profileImageUrl.isEmpty
                              ? null
                              : NetworkImage(controller.profileImageUrl),
                          imageText:
                              controller.riderModel.value.fullName!.isEmpty
                                  ? ""
                                  : getNameInitials(
                                      controller.riderModel.value.fullName!,
                                    ),
                        )
                      : circleAvatarImage(
                          colorScheme,
                          height: 120,
                          foregroundImage: FileImage(
                            File(
                              controller.selectedProfileImage!.path,
                            ),
                          ),
                        ),
                  controller.selectedProfileImage == null ||
                          controller.profilePicIsUploaded.isTrue ||
                          controller.profilePicUploadIsCanceled.value
                      ? const SizedBox()
                      : AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          bottom: 0,
                          left: 0,
                          child: InkWell(
                            onTap: controller.cancelUpload,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: colorScheme.error,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: colorScheme.primary,
                                ),
                              ),
                              child: Icon(
                                Icons.close,
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    bottom: 0,
                    right: -0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: colorScheme.primary,
                        ),
                      ),
                      child: controller.isUploadingProfilePic.value
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: colorScheme.primary,
                              ),
                            )
                          : InkWell(
                              onTap: controller.selectedProfileImage == null ||
                                      controller.profilePicIsUploaded.isTrue ||
                                      controller
                                          .profilePicUploadIsCanceled.value
                                  ? controller.showUploadProfilePicModal
                                  : controller.uploadProfilePic,
                              borderRadius: BorderRadius.circular(20),
                              child: controller.selectedProfileImage == null ||
                                      controller.profilePicIsUploaded.isTrue ||
                                      controller
                                          .profilePicUploadIsCanceled.value
                                  ? SvgPicture.asset(
                                      Assets.cameraOutlineSvg,
                                      // ignore: deprecated_member_use
                                      color: colorScheme.primary,
                                    )
                                  : Icon(
                                      Icons.check,
                                      color: colorScheme.primary,
                                    ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: circleAvatarImage(
          //     colorScheme,
          //     height: media.height * .16,
          //   ),
          // ),
          kWidthSizedBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.riderModel.value.fullName ?? "",
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: controller.goToEditProfile,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    child: Text(
                      "Edit profile",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: colorScheme.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}
