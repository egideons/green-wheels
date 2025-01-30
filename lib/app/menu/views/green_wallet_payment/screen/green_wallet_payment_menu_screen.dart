import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../src/controllers/menu/green_wallet_payment_menu_controller.dart';
import '../platform/android/green_wallet_payment_menu_scaffold.dart';

class GreenWalletPaymentMenuScreen extends StatelessWidget {
  const GreenWalletPaymentMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(GreenWalletPaymentMenuController());

    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    //     // child: const MenuScreenCupertinoScaffold(),
    //   );
    // }
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: const GreenWalletPaymentMenuScaffold(),
    );
  }
}
