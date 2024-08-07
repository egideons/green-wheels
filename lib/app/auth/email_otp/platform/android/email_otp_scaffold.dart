import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../src/controllers/auth/email_otp_controller.dart';
import '../../../../../src/utils/buttons/android/android_elevated_button.dart';
import '../../content/email_otp_page_header.dart';
import '../../content/otp_form.dart';
import '../../content/resend_code.dart';

class EmailOTPScaffold extends GetView<EmailOTPController> {
  final String? userEmail;

  const EmailOTPScaffold({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    //Large screens or Mobile Landscape mode
    // if (deviceType(media.width) > 1) {
    // return Scaffold(
    //   backgroundColor: colorScheme.surface,
    //   body: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       SizedBox(
    //         width: media.width / 2.2,
    //         child: Wrap(
    //           alignment: WrapAlignment.center,
    //           children: [
    //             Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 SvgPicture.asset(
    //                   Assets.otpSvg,
    //                   fit: BoxFit.cover,
    //                   height: deviceType(media.width) > 2
    //                       ? media.height * .4
    //                       : media.height * .2,
    //                 ),
    //                 kSizedBox,
    //                 emailOTPPageHeader(
    //                   colorScheme: colorScheme,
    //                   media: media,
    //                   title: "OTP verification",
    //                   subtitle:
    //                       "Enter the 4-digit verification code we sent to ",
    //                   email: "$userEmail",
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       kHalfWidthSizedBox,

    //       //OTP Form
    //       Expanded(
    //         child: SingleChildScrollView(
    //           child: Container(
    //             padding: const EdgeInsets.all(20),
    //             margin: const EdgeInsets.only(right: 10),
    //             decoration: BoxDecoration(
    //               color: colorScheme.surface,
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                 width: 1,
    //                 color: colorScheme.inversePrimary,
    //               ),
    //             ),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.max,
    //               children: [
    //                 const SizedBox(height: kDefaultPadding * 4),
    //                 Form(
    //                   key: controller.formKey,
    //                   autovalidateMode: AutovalidateMode.onUserInteraction,
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       SizedBox(
    //                         width: media.width * .08,
    //                         child: AndroidTextFormField(
    //                           controller: controller.pin1EC,
    //                           focusNode: controller.pin1FN,
    //                           textInputAction: TextInputAction.next,
    //                           textCapitalization: TextCapitalization.none,
    //                           keyboardType: TextInputType.number,
    //                           inputBorder: const UnderlineInputBorder(),
    //                           enabledBorder: const UnderlineInputBorder(),
    //                           focusedBorder: const UnderlineInputBorder(),
    //                           onChanged: (value) {
    //                             controller.pin1Onchanged(value, context);
    //                           },
    //                           inputFormatters: [
    //                             LengthLimitingTextInputFormatter(1),
    //                             FilteringTextInputFormatter.digitsOnly,
    //                           ],
    //                           validator: (value) {
    //                             return null;
    //                           },
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: media.width * .08,
    //                         child: AndroidTextFormField(
    //                           controller: controller.pin2EC,
    //                           focusNode: controller.pin2FN,
    //                           textInputAction: TextInputAction.next,
    //                           textCapitalization: TextCapitalization.none,
    //                           keyboardType: TextInputType.number,
    //                           inputBorder: const UnderlineInputBorder(),
    //                           enabledBorder: const UnderlineInputBorder(),
    //                           focusedBorder: const UnderlineInputBorder(),
    //                           inputFormatters: [
    //                             LengthLimitingTextInputFormatter(1),
    //                             FilteringTextInputFormatter.digitsOnly,
    //                           ],
    //                           onChanged: (value) {
    //                             controller.pin2Onchanged(value, context);
    //                           },
    //                           validator: (value) {
    //                             return null;
    //                           },
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: media.width * .08,
    //                         child: AndroidTextFormField(
    //                           controller: controller.pin3EC,
    //                           focusNode: controller.pin3FN,
    //                           textInputAction: TextInputAction.next,
    //                           textCapitalization: TextCapitalization.none,
    //                           keyboardType: TextInputType.number,
    //                           inputBorder: const UnderlineInputBorder(),
    //                           enabledBorder: const UnderlineInputBorder(),
    //                           focusedBorder: const UnderlineInputBorder(),
    //                           inputFormatters: [
    //                             LengthLimitingTextInputFormatter(1),
    //                             FilteringTextInputFormatter.digitsOnly,
    //                           ],
    //                           onChanged: (value) {
    //                             controller.pin3Onchanged(value, context);
    //                           },
    //                           validator: (value) {
    //                             return null;
    //                           },
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: media.width * .08,
    //                         child: AndroidTextFormField(
    //                           controller: controller.pin4EC,
    //                           focusNode: controller.pin4FN,
    //                           textInputAction: TextInputAction.done,
    //                           textCapitalization: TextCapitalization.none,
    //                           keyboardType: TextInputType.number,
    //                           inputBorder: const UnderlineInputBorder(),
    //                           enabledBorder: const UnderlineInputBorder(),
    //                           focusedBorder: const UnderlineInputBorder(),
    //                           onFieldSubmitted: controller.onSubmitted,
    //                           inputFormatters: [
    //                             LengthLimitingTextInputFormatter(1),
    //                             FilteringTextInputFormatter.digitsOnly,
    //                           ],
    //                           onChanged: (value) {
    //                             controller.pin4Onchanged(value, context);
    //                           },
    //                           validator: (value) {
    //                             return null;
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(height: kDefaultPadding * 2),
    //                 GetBuilder<EmailOTPController>(
    //                   builder: (controller) {
    //                     return AndroidElevatedButton(
    //                       title: "Verify",
    //                       isLoading:
    //                           controller.isLoading.value ? true : false,
    //                       disable:
    //                           controller.formIsValid.value ? false : true,
    //                       onPressed: controller.submitOTP,
    //                     );
    //                   },
    //                 ),
    //                 const SizedBox(height: kDefaultPadding * 2),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Obx(
    //                       () => InkWell(
    //                         onTap: controller.timerComplete.isTrue
    //                             ? controller.requestOTP
    //                             : null,
    //                         child: AnimatedDefaultTextStyle(
    //                           duration: const Duration(milliseconds: 300),
    //                           curve: Curves.easeIn,
    //                           style: defaultTextStyle(
    //                             fontSize: 15.0,
    //                             color: controller.timerComplete.isTrue
    //                                 ? kSuccessColor
    //                                 : kErrorColor,
    //                             decoration: TextDecoration.underline,
    //                             fontWeight: FontWeight.w600,
    //                           ),
    //                           textAlign: TextAlign.center,
    //                           child: const Text("Resend code"),
    //                         ),
    //                       ),
    //                     ),
    //                     kHalfWidthSizedBox,
    //                     Obx(
    //                       () => controller.timerComplete.isTrue
    //                           ? const SizedBox()
    //                           : Text(
    //                               "in ${controller.formatTime(controller.secondsRemaining.value)}s",
    //                               textAlign: TextAlign.center,
    //                               style: defaultTextStyle(
    //                                 fontSize: 15.0,
    //                                 color: colorScheme.primary,
    //                                 fontWeight: FontWeight.w400,
    //                               ),
    //                             ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: kDefaultPadding * 4),
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    // }

    //Portrait mode for Mobile Screens
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(colorScheme, media),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // SvgPicture.asset(
            //   Assets.otpSvg,
            //   fit: BoxFit.fitHeight,
            //   height: media.height * .2,
            // ),
            kSizedBox,
            emailOTPPageHeader(
              colorScheme: colorScheme,
              media: media,
              title: "OTP",
              subtitle:
                  "A verification code was sent to the Email address provided. Please input code.",
              email: "$userEmail",
            ),
            const SizedBox(height: kDefaultPadding * 2),
            Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: otpForm(media, controller, context),
            ),
            kSizedBox,
            resendCode(colorScheme, controller),
            const SizedBox(height: kDefaultPadding * 2),
            GetBuilder<EmailOTPController>(
              builder: (controller) {
                return AndroidElevatedButton(
                  title: "Continue",
                  isLoading: controller.isLoading.value ? true : false,
                  disable: controller.formIsValid.value ? false : true,
                  onPressed: controller.submitOTP,
                );
              },
            ),
            const SizedBox(height: kDefaultPadding * 2),

            kSizedBox,
          ],
        ),
      ),
    );
  }
}
