import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../src/controllers/auth/email_otp_controller.dart';
import '../../../../src/utils/textformfields/android/android_textformfield.dart';
import '../../../../theme/colors.dart';

otpForm(Size media, EmailOTPController otpController, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: otpController.pin1EC,
          focusNode: otpController.pin1FN,
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
            otpController.pin1Onchanged(value, context);
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
          controller: otpController.pin2EC,
          focusNode: otpController.pin2FN,
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
            otpController.pin2Onchanged(value, context);
          },
          validator: (value) {
            return null;
          },
        ),
      ),
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: otpController.pin3EC,
          focusNode: otpController.pin3FN,
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
            otpController.pin3Onchanged(value, context);
          },
          validator: (value) {
            return null;
          },
        ),
      ),
      SizedBox(
        width: media.width * 0.18,
        child: AndroidTextFormField(
          controller: otpController.pin4EC,
          focusNode: otpController.pin4FN,
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
          onFieldSubmitted: otpController.onSubmitted,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            otpController.pin4Onchanged(value, context);
          },
          validator: (value) {
            return null;
          },
        ),
      ),
    ],
  );
}
