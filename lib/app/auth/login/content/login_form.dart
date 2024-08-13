import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/auth/login_controller.dart';
import '../../../../src/utils/containers/text_form_field_container.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

loginForm(ColorScheme colorScheme, Size media, LoginController controller) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
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
                color: kGreenLightColor,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(6),
                ),
              ),
              child: const Icon(
                Iconsax.call,
                color: kBlackColor,
              ),
            ),
            kHalfWidthSizedBox,
            Text(
              "+234",
              textAlign: TextAlign.start,
              style: defaultTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextBlackColor,
              ),
            ),
            kHalfWidthSizedBox,
            Expanded(
              child: AndroidTextFormField(
                readOnly: controller.isLoading.value,
                controller: controller.phoneNumberEC,
                focusNode: controller.phoneNumberFN,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.phone,
                hintText: "Mobile Number",
                onFieldSubmitted: controller.onSubmitted,
                validator: (value) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      kSizedBox,
      // formFieldContainer(
      //   colorScheme,
      //   media,
      //   containerHeight: media.height * .08,
      //   padding: const EdgeInsets.all(0),
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Container(
      //         height: 60,
      //         width: 60,
      //         decoration: const BoxDecoration(
      //           color: kGreenLightColor,
      //           borderRadius: BorderRadius.horizontal(
      //             left: Radius.circular(6),
      //           ),
      //         ),
      //         child: const Icon(
      //           Iconsax.lock,
      //           color: kBlackColor,
      //         ),
      //       ),
      //       kHalfWidthSizedBox,
      //       Expanded(
      //         child: AndroidTextFormField(
      //           readOnly: controller.isLoading.value,
      //           controller: controller.passwordEC,
      //           focusNode: controller.passwordFN,
      //           textInputAction: TextInputAction.done,
      //           textCapitalization: TextCapitalization.none,
      //           keyboardType: TextInputType.visiblePassword,
      //           obscureText: controller.passwordIsHidden.value,
      //           hintText: "Password",
      //           onChanged: controller.passwordOnChanged,
      //           onFieldSubmitted: controller.onSubmitted,
      //           validator: (value) {
      //             return null;
      //           },
      //         ),
      //       ),
      //       InkWell(
      //         borderRadius: BorderRadius.circular(20),
      //         onTap: () {
      //           controller.passwordIsHidden.value =
      //               !controller.passwordIsHidden.value;
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Icon(
      //             color: colorScheme.inversePrimary,
      //             size: 20,
      //             controller.passwordIsHidden.value
      //                 ? Iconsax.eye
      //                 : Iconsax.eye_slash,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      // kHalfSizedBox,
      // Align(
      //   alignment: Alignment.centerRight,
      //   child: RichText(
      //     textAlign: TextAlign.end,
      //     maxLines: 1,
      //     softWrap: true,
      //     text: TextSpan(
      //       text: "Forgot Password?",
      //       style: defaultTextStyle(
      //         color: kTextBlackColor,
      //         fontSize: 14,
      //         fontWeight: FontWeight.w400,
      //       ),
      //       recognizer: TapGestureRecognizer()
      //         ..onTap = controller.isLoading.value
      //             ? null
      //             : controller.navigateToForgotPassword,
      //     ),
      //   ),
      // ),

      // const LineWithOR(),
    ],
  );
}
