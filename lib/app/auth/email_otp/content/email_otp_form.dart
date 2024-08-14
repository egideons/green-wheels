import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../src/controllers/auth/email_otp_controller.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

emailOTPForm(Size media, EmailOTPController controller, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: controller.pin1EC,
          focusNode: controller.pin1FN,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.number,
          inputBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          onChanged: (value) {
            controller.pin1Onchanged(value, context);
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            return null;
          },
        ),
      ),
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: controller.pin2EC,
          focusNode: controller.pin2FN,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.number,
          inputBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            controller.pin2Onchanged(value, context);
          },
          validator: (value) {
            return null;
          },
        ),
      ),
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: controller.pin3EC,
          focusNode: controller.pin3FN,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.number,
          inputBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            controller.pin3Onchanged(value, context);
          },
          validator: (value) {
            return null;
          },
        ),
      ),
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: controller.pin4EC,
          focusNode: controller.pin4FN,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.number,
          inputBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kBlackColor, width: 3),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            controller.pin4Onchanged(value, context);
          },
          validator: (value) {
            return null;
          },
        ),
      ),
    ],
  );
}
