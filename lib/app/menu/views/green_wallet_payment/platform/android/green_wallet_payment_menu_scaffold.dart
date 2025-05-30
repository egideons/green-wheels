import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/controllers/menu/green_wallet_payment_menu_controller.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../theme/colors.dart';
import '../../content/green_wallet_payment_menu_card.dart';
import '../../content/transaction_info_container.dart';

class GreenWalletPaymentMenuScaffold
    extends GetView<GreenWalletPaymentMenuController> {
  const GreenWalletPaymentMenuScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(colorScheme, media, title: "Green Wallet"),
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
          child: RefreshIndicator(
            onRefresh: controller.onRefresh,
            child: ListView(
              padding: const EdgeInsets.all(10),
              controller: controller.scrollController,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: media.width / 2.4,
                    child: AndroidElevatedButton(
                      title: "Fund Wallet",
                      isRowVisible: true,
                      fontSize: 12,
                      buttonIcon: Icons.chevron_right,
                      mainAxisAlignment: MainAxisAlignment.center,
                      onPressed: controller.goToFundGreenWallet,
                    ),
                  ),
                ),
                kSizedBox,
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Obx(
                        () => Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: greenWalletPaymentMenuCard(
                            media,
                            controller,
                            colorScheme,
                            amount: controller.hideBalance.value
                                ? "******"
                                : convertToCurrency(
                                    controller.walletBalance.value,
                                  ),
                            label: "Available balance",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Obx(
                        () => Skeletonizer(
                          enabled: controller.isLoading.value,
                          child: greenWalletPaymentMenuCard(
                            media,
                            controller,
                            colorScheme,
                            amount: controller.hideBalance.value
                                ? "******"
                                : convertToCurrency(
                                    controller.totalExpenses.value,
                                  ),
                            label: "Total expenses",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kHalfSizedBox,
                Obx(() {
                  return Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: 'Total Green Points earned: ',
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
                              : "${convertToCurrency("0")}",
                          style: defaultTextStyle(
                            color: colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                kHalfSizedBox,
                Obx(
                  () => TextButton(
                    onPressed: controller.changeVisibilityState,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          controller.hideBalance.value ? "Show" : "Hide",
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        kSmallWidthSizedBox,
                        Icon(
                          controller.hideBalance.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: kBlackColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
                kHalfSizedBox,
                Text(
                  "Transactions",
                  textAlign: TextAlign.start,
                  style: defaultTextStyle(
                    color: kTextBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                kSizedBox,
                ListView.separated(
                  itemCount: 0,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => kSizedBox,
                  itemBuilder: (context, index) {
                    return transactionsInfoContainer(
                      colorScheme,
                      controller,
                      amount: 10000,
                    );
                  },
                ),
                SizedBox(height: media.height * .6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
