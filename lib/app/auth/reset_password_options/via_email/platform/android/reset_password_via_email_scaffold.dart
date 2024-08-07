import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/theme/colors.dart';

import '../../../../../../src/constants/consts.dart';
import '../../../../../../src/controllers/auth/reset_password_via_email_controller.dart';
import '../../../../../../src/utils/buttons/android/android_elevated_button.dart';
import '../../../content/reset_password_option_header.dart';
import '../../content/email_form.dart';

class ResetPasswordViaEmailScaffold
    extends GetView<ResetPasswordViaEmailController> {
  const ResetPasswordViaEmailScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    //Mobile Landscape mode or larger screens
    // if (deviceType(media.width) > 1) {
    //   return Scaffold(
    //     backgroundColor: colorScheme.surface,
    //     appBar: AppBar(
    //       backgroundColor: colorScheme.surface,
    //       toolbarHeight: 36,
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
    //                     Assets.passwordSvg,
    //                     fit: BoxFit.fitHeight,
    //                     height: deviceType(media.width) > 2
    //                         ? media.height * .4
    //                         : media.height * .2,
    //                   ),
    //                   kSizedBox,
    //                   resetPasswordOptionHeader(
    //                     colorScheme,
    //                     controller,
    //                     registeredOption: "email",
    //                     resetOption: "SMS",
    //                     resetVia: controller.navigateToSMS,
    //                   ),
    //                   kSizedBox,
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         kHalfWidthSizedBox,

    //         //Form
    //         Expanded(
    //           child: SingleChildScrollView(
    //             child: Container(
    //               padding: const EdgeInsets.all(20),
    //               margin: const EdgeInsets.only(right: 10),
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
    //                   Obx(
    //                     () {
    //                       return Form(
    //                         key: controller.formKey,
    //                         autovalidateMode:
    //                             AutovalidateMode.onUserInteraction,
    //                         child: Column(
    //                           children: [
    //                             formFieldContainer(
    //                               colorScheme,
    //                               media,
    //                               containerHeight: media.height * .08,
    //                               child: AndroidTextFormField(
    //                                 readOnly: controller
    //                                     .isLoading.value,
    //                                 controller:
    //                                     controller.emailEC,
    //                                 focusNode:
    //                                     controller.emailFN,
    //                                 textInputAction: TextInputAction.done,
    //                                 textCapitalization: TextCapitalization.none,
    //                                 keyboardType: TextInputType.emailAddress,
    //                                 hintText: "Email",
    //                                 onFieldSubmitted:
    //                                     controller
    //                                         .onSubmitted,
    //                                 onChanged: controller
    //                                     .emailOnChanged,
    //                                 validator: (value) {
    //                                   return null;
    //                                 },
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   const SizedBox(height: kDefaultPadding * 2),
    //                   GetBuilder<ResetPasswordViaEmailController>(
    //                     init: ResetPasswordViaEmailController(),
    //                     builder: (context) {
    //                       return AndroidElevatedButton(
    //                         title: "Send code",
    //                         disable: controller
    //                                 .formIsValid.isTrue
    //                             ? false
    //                             : true,
    //                         isLoading:
    //                             controller.isLoading.value,
    //                         onPressed:
    //                             controller.submitEmail,
    //                       );
    //                     },
    //                   ),
    //                   const SizedBox(height: kDefaultPadding * 2),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    //Mobile Portrait mode
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(colorScheme, media),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // SvgPicture.asset(
            //   Assets.passwordSvg,
            //   fit: BoxFit.fitHeight,
            //   height: media.height * .24,
            // ),
            resetPasswordOptionHeader(
              colorScheme,
              controller,
              registeredOption: "email",
            ),
            kSizedBox,
            Obx(
              () => emailForm(colorScheme, media, controller),
            ),
            kSizedBox,
            Text(
              "A verification code will be sent to your Email Address",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              style: defaultTextStyle(
                fontSize: 16,
                color: kTextBlackColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: kDefaultPadding * 2),
            GetBuilder<ResetPasswordViaEmailController>(
              init: ResetPasswordViaEmailController(),
              builder: (context) {
                return AndroidElevatedButton(
                  title: "Send code",
                  disable: controller.formIsValid.isTrue ? false : true,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.submitEmail,
                );
              },
            ),
            const SizedBox(height: kDefaultPadding * 2),
          ],
        ),
      ),
    );
  }
}
