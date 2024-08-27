import 'package:flutter/material.dart';
import 'package:green_wheels/src/utils/components/default_info_container.dart';

import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/home_screen_controller.dart';
import '../../../../src/utils/buttons/android/android_elevated_button.dart';
import '../../../../src/utils/components/amount_charge_section.dart';
import '../../../../src/utils/components/payment_type_section.dart';

searchForDriverSection(
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      defaultInfoContainer(
        padding: const EdgeInsets.all(10),
        child: amounChargeSection(colorScheme, amount: 2000),
      ),
      kHalfSizedBox,
      defaultInfoContainer(
        padding: const EdgeInsets.all(10),
        child: paymentTypeSection(colorScheme),
      ),
      kSizedBox,
      AndroidElevatedButton(
        title: "Search for Driver",
        onPressed: controller.showSearchingForDriverModalSheet,
      )
    ],
  );
}
