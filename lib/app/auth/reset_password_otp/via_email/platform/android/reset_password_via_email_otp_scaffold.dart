import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/auth/reset_password_via_email_otp_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';

import '../../../../../../src/constants/consts.dart';
import '../../../../../../theme/colors.dart';
import '../../content/otp_form.dart';
import '../../content/reset_password_via_email_otp_page_header.dart';

class ResetPasswordViaEmailOTPScaffold
    extends GetView<ResetPasswordViaEmailOTPController> {
  const ResetPasswordViaEmailOTPScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    var resetPasswordViaEmailController =
        ResetPasswordViaEmailOTPController.instance;

    //Large screens or Mobile Landscape mode
    // if (deviceType(media.width) > 1) {
    //   return Scaffold(
    //     backgroundColor: colorScheme.surface,
    //     appBar: AppBar(
    //       backgroundColor: colorScheme.surface,
    //       toolbarHeight: 32,
    //       leading: IconButton(
    //         onPressed: () {
    //           Get.back();
    //         },
    //         icon: Icon(
    //           Iconsax.arrow_left_2,
    //           color: colorScheme.primary,
    //         ),
    //       ),
    //     ),
    //     body: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         SizedBox(
    //           width: media.width / 2.2,
    //           child: Wrap(
    //             alignment: WrapAlignment.center,
    //             children: [
    //               Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   SvgPicture.asset(
    //                     Assets.otpSvg,
    //                     fit: BoxFit.cover,
    //                     height: deviceType(media.width) > 2
    //                         ? media.height * .4
    //                         : media.height * .2,
    //                   ),
    //                   kSizedBox,
    //                   resetPasswordViaEmailOTPPageHeader(
    //                     colorScheme: colorScheme,
    //                     media: media,
    //                     title: "OTP Verification",
    //                     subtitle: "Enter the 4-digit OTP sent to your email",
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         kHalfWidthSizedBox,

    //         //OTP Form
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: Container(
    //               padding: const EdgeInsets.all(20),
    //               margin: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                 color: colorScheme.surface,
    //                 borderRadius: BorderRadius.circular(12),
    //                 border: Border.all(
    //                   width: 1,
    //                   color: colorScheme.inversePrimary,
    //                 ),
    //               ),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   const SizedBox(height: kDefaultPadding * 4),
    //                   Form(
    //                     key: resetPasswordViaEmailController.formKey,
    //                     autovalidateMode: AutovalidateMode.onUserInteraction,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: [
    //                         SizedBox(
    //                           width: media.width * .08,
    //                           child: AndroidTextFormField(
    //                             controller:
    //                                 resetPasswordViaEmailController.pin1EC,
    //                             focusNode:
    //                                 resetPasswordViaEmailController.pin1FN,
    //                             textInputAction: TextInputAction.next,
    //                             textCapitalization: TextCapitalization.none,
    //                             keyboardType: TextInputType.number,
    //                             inputBorder: const UnderlineInputBorder(),
    //                             enabledBorder: const UnderlineInputBorder(),
    //                             focusedBorder: const UnderlineInputBorder(),
    //                             onChanged: (value) {
    //                               resetPasswordViaEmailController.pin1Onchanged(
    //                                   value, context);
    //                             },
    //                             inputFormatters: [
    //                               LengthLimitingTextInputFormatter(1),
    //                               FilteringTextInputFormatter.digitsOnly,
    //                             ],
    //                             validator: (value) {
    //                               return null;
    //                             },
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: media.width * .08,
    //                           child: AndroidTextFormField(
    //                             controller:
    //                                 resetPasswordViaEmailController.pin2EC,
    //                             focusNode:
    //                                 resetPasswordViaEmailController.pin2FN,
    //                             textInputAction: TextInputAction.next,
    //                             textCapitalization: TextCapitalization.none,
    //                             keyboardType: TextInputType.number,
    //                             inputBorder: const UnderlineInputBorder(),
    //                             enabledBorder: const UnderlineInputBorder(),
    //                             focusedBorder: const UnderlineInputBorder(),
    //                             inputFormatters: [
    //                               LengthLimitingTextInputFormatter(1),
    //                               FilteringTextInputFormatter.digitsOnly,
    //                             ],
    //                             onChanged: (value) {
    //                               resetPasswordViaEmailController.pin2Onchanged(
    //                                   value, context);
    //                             },
    //                             validator: (value) {
    //                               return null;
    //                             },
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: media.width * .08,
    //                           child: AndroidTextFormField(
    //                             controller:
    //                                 resetPasswordViaEmailController.pin3EC,
    //                             focusNode:
    //                                 resetPasswordViaEmailController.pin3FN,
    //                             textInputAction: TextInputAction.next,
    //                             textCapitalization: TextCapitalization.none,
    //                             keyboardType: TextInputType.number,
    //                             inputBorder: const UnderlineInputBorder(),
    //                             enabledBorder: const UnderlineInputBorder(),
    //                             focusedBorder: const UnderlineInputBorder(),
    //                             inputFormatters: [
    //                               LengthLimitingTextInputFormatter(1),
    //                               FilteringTextInputFormatter.digitsOnly,
    //                             ],
    //                             onChanged: (value) {
    //                               resetPasswordViaEmailController.pin3Onchanged(
    //                                   value, context);
    //                             },
    //                             validator: (value) {
    //                               return null;
    //                             },
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: media.width * .08,
    //                           child: AndroidTextFormField(
    //                             controller:
    //                                 resetPasswordViaEmailController.pin4EC,
    //                             focusNode:
    //                                 resetPasswordViaEmailController.pin4FN,
    //                             textInputAction: TextInputAction.done,
    //                             textCapitalization: TextCapitalization.none,
    //                             keyboardType: TextInputType.number,
    //                             inputBorder: const UnderlineInputBorder(),
    //                             enabledBorder: const UnderlineInputBorder(),
    //                             focusedBorder: const UnderlineInputBorder(),
    //                             onFieldSubmitted:
    //                                 resetPasswordViaEmailController.onSubmitted,
    //                             inputFormatters: [
    //                               LengthLimitingTextInputFormatter(1),
    //                               FilteringTextInputFormatter.digitsOnly,
    //                             ],
    //                             onChanged: (value) {
    //                               resetPasswordViaEmailController.pin4Onchanged(
    //                                   value, context);
    //                             },
    //                             validator: (value) {
    //                               return null;
    //                             },
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(height: kDefaultPadding * 2),
    //                   GetBuilder<ResetPasswordViaEmailOTPController>(
    //                     builder: (controller) {
    //                       return AndroidElevatedButton(
    //                         title: "Verify",
    //                         isLoading:
    //                             resetPasswordViaEmailController.isLoading.value
    //                                 ? true
    //                                 : false,
    //                         disable: resetPasswordViaEmailController
    //                                 .formIsValid.value
    //                             ? false
    //                             : true,
    //                         onPressed:
    //                             resetPasswordViaEmailController.submitOTP,
    //                       );
    //                     },
    //                   ),
    //                   const SizedBox(height: kDefaultPadding * 2),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       Obx(
    //                         () => InkWell(
    //                           onTap: resetPasswordViaEmailController
    //                                   .timerComplete.isTrue
    //                               ? resetPasswordViaEmailController.requestOTP
    //                               : null,
    //                           child: AnimatedDefaultTextStyle(
    //                             duration: const Duration(milliseconds: 300),
    //                             curve: Curves.easeIn,
    //                             style: defaultTextStyle(
    //                               fontSize: 15.0,
    //                               color: resetPasswordViaEmailController
    //                                       .timerComplete.isTrue
    //                                   ? kSuccessColor
    //                                   : kErrorColor,
    //                               decoration: TextDecoration.underline,
    //                               fontWeight: FontWeight.w600,
    //                             ),
    //                             textAlign: TextAlign.center,
    //                             child: const Text("Resend code"),
    //                           ),
    //                         ),
    //                       ),
    //                       kHalfWidthSizedBox,
    //                       Obx(
    //                         () => resetPasswordViaEmailController
    //                                 .timerComplete.isTrue
    //                             ? const SizedBox()
    //                             : Text(
    //                                 "in ${resetPasswordViaEmailController.formatTime(resetPasswordViaEmailController.secondsRemaining.value)}s",
    //                                 textAlign: TextAlign.center,
    //                                 style: defaultTextStyle(
    //                                   fontSize: 15.0,
    //                                   color: colorScheme.primary,
    //                                   fontWeight: FontWeight.w400,
    //                                 ),
    //                               ),
    //                       ),
    //                     ],
    //                   ),
    //                   kSizedBox,
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    //Portrait mode for Mobile Screens
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(colorScheme, media),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // SvgPicture.asset(
          //   Assets.otpSvg,
          //   fit: BoxFit.fitHeight,
          //   height: media.height * .2,
          // ),
          resetPasswordViaEmailOTPPageHeader(
            media: media,
            title: "Reset Password",
            subtitle:
                "A verification code was sent to the Email Address provided. Please input code.",
          ),
          const SizedBox(height: kDefaultPadding * 2),
          Form(
            key: resetPasswordViaEmailController.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: otpForm(media, context, controller),
          ),
          kSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive code?",
                style: defaultTextStyle(
                  fontSize: 15.0,
                  color: colorScheme.inversePrimary,
                ),
              ),
              kHalfWidthSizedBox,
              Obx(
                () => InkWell(
                  onTap: resetPasswordViaEmailController.timerComplete.isTrue
                      ? resetPasswordViaEmailController.requestOTP
                      : null,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    style: defaultTextStyle(
                      fontSize: 15.0,
                      color:
                          resetPasswordViaEmailController.timerComplete.isTrue
                              ? colorScheme.primary
                              : kErrorColor,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                    child: const Text("Resend code"),
                  ),
                ),
              ),
              kHalfWidthSizedBox,
              // Obx(
              //   () => resetPasswordViaEmailController.timerComplete.isTrue
              //       ? const SizedBox()
              //       : Text(
              //           "in ${resetPasswordViaEmailController.formatTime(resetPasswordViaEmailController.secondsRemaining.value)}s",
              //           textAlign: TextAlign.center,
              //           style: defaultTextStyle(
              //             fontSize: 15.0,
              //             color: colorScheme.primary,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              // ),
            ],
          ),
          kSizedBox,
          const SizedBox(height: kDefaultPadding * 2),
          GetBuilder<ResetPasswordViaEmailOTPController>(
            builder: (controller) {
              return AndroidElevatedButton(
                title: "Continue",
                isLoading: resetPasswordViaEmailController.isLoading.value
                    ? true
                    : false,
                disable: resetPasswordViaEmailController.formIsValid.value
                    ? false
                    : true,
                onPressed: resetPasswordViaEmailController.submitOTP,
              );
            },
          ),
          const SizedBox(height: kDefaultPadding * 2),
        ],
      ),
    );
  }
}
