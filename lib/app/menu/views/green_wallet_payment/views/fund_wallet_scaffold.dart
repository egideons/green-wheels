import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/auth/success_screen_controller.dart';
import 'package:green_wheels/src/controllers/menu/green_wallet_payment_menu_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:green_wheels/src/utils/textformfields/android/android_textformfield.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../theme/colors.dart';
import '../../../../../src/utils/containers/text_form_field_container.dart';

class FundWalletMenuScaffold extends GetView<GreenWalletPaymentMenuController> {
  const FundWalletMenuScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    Get.put(SuccessScreenController());
    // bool isProccessing = true;
    return GestureDetector(
      // onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      // absorbing: false,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: myAppBar(colorScheme, media, title: "Fund Wallet"),
        floatingActionButton: Obx(
          () => controller.isScrollToTopBtnVisible.value
              ? FloatingActionButton.small(
                  onPressed: controller.scrollToTop,
                  backgroundColor: colorScheme.primary,
                  foregroundColor: kLightBackgroundColor,
                  child: const Icon(Icons.keyboard_arrow_up),
                )
              : const SizedBox(),
        ),
        body: SafeArea(
          child: Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(10),
              controller: controller.scrollController,
              children: [
                Obx(
                  () => Form(
                    key: controller.fundWalletFormkey,
                    child: formFieldContainer(
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
                              color: kFrameBackgroundColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(6),
                              ),
                            ),
                            child: const Icon(
                              Iconsax.wallet_add,
                              color: kBlackColor,
                            ),
                          ),
                          kHalfWidthSizedBox,
                          Expanded(
                            child: AndroidTextFormField(
                              readOnly: controller.isLoading.value,
                              controller: controller.amountEC,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: controller.onFieldSubmitted,
                              focusNode: controller.amountFN,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.number,
                              hintText: "Enter amount",
                              validator: (value) {
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kSizedBox,
                Obx(
                  () => AndroidElevatedButton(
                    title: "Proceed",
                    isLoading: controller.isFunding.value,
                    onPressed: controller.fundWalletWithPayStack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
