import 'package:flutter/material.dart';
import 'package:green_wheels/src/controllers/menu/green_wallet_payment_menu_controller.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../theme/colors.dart';

greenWalletPaymentMenuCard(
  Size media,
  GreenWalletPaymentMenuController controller,
  ColorScheme colorScheme, {
  String? amount,
  String? label,
}) {
  return Container(
    height: media.height * .16,
    width: media.width / 2.4,
    decoration: ShapeDecoration(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: .8,
          color: colorScheme.primary,
        ),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text.rich(
          textAlign: TextAlign.end,
          TextSpan(
            text: '$nairaSign ',
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 18,
              fontFamily: "",
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: controller.hideBalance.value
                    ? "******"
                    : "${convertToCurrency(amount!)}",
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        kSizedBox,
        Text(
          label ?? "",
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
