import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/menu/green_wallet_payment_menu_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../src/constants/consts.dart';
import '../../../../../theme/colors.dart';

transactionsInfoContainer(
    ColorScheme colorScheme, GreenWalletPaymentMenuController controller,
    {int? amount}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: kFrameBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: .8,
          color: colorScheme.primary,
        ),
      ),
    ),
    child: Row(
      children: [
        const Icon(Iconsax.send, color: kErrorColor),
        kWidthSizedBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nathaniel Ukpong",
                textAlign: TextAlign.start,
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "Mustang Shelby GT",
                textAlign: TextAlign.start,
                style: defaultTextStyle(
                  color: kTextBlackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Text.rich(
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
                      ? "***********"
                      : intFormattedText(amount ?? 0),
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
