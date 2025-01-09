import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';
import 'package:get/get.dart';
import 'package:green_wheels/app/menu/views/green_wallet_payment/views/fund_wallet_scaffold.dart';
import 'package:green_wheels/app/splash/success/screen/success_screen.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/constants/keys.dart';
import 'package:green_wheels/src/controllers/auth/success_screen_controller.dart';
import 'package:green_wheels/src/models/rider/get_rider_profile_response_model.dart';
import 'package:green_wheels/src/models/rider/rider_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../others/api_processor_controller.dart';

class GreenWalletPaymentMenuController extends GetxController {
  static GreenWalletPaymentMenuController get instance {
    return Get.find<GreenWalletPaymentMenuController>();
  }

  @override
  void onInit() async {
    super.onInit();
    loadVisibilityState();
    amountEC.clear();
    scrollController.addListener(_scrollListener);
    amountFN.requestFocus();
    amountEC.addListener(formatAmount);

    await getRiderProfile();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
    amountEC.removeListener(formatAmount);
    amountEC.dispose();
  }

  //================ Variables =================\\
  var walletBalance = Get.arguments?["wallet_balance"] ?? "";

  //================ Models =================\\
  var getRiderProfileResponseModel =
      GetRiderProfileResponseModel.fromJson(null).obs;
  var riderModel = RiderModel.fromJson(null).obs;

  //================ controllers =================\\
  var scrollController = ScrollController();

  //================ Booleans =================\\
  var isLoading = false.obs;
  var isScrollToTopBtnVisible = false.obs;
  var hideBalance = false.obs;

  //================ Handle refresh ================\\

  Future<void> onRefresh() async {
    isLoading.value = true;
    update();

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    update();
  }

  //================ Scroll to Top =================//
  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  //================ Scroll Listener =================//

  void _scrollListener() {
    //========= Show action button ========//
    if (scrollController.position.pixels >= 150) {
      isScrollToTopBtnVisible.value = true;
      update();
    }
    //========= Hide action button ========//
    else if (scrollController.position.pixels < 150) {
      isScrollToTopBtnVisible.value = false;
      update();
    }
  }

  goToFundGreenWallet() async {
    Get.to(
      () => const FundWalletMenuScaffold(),
      transition: Transition.rightToLeft,
      routeName: "/fund-wallet",
      curve: Curves.easeInOut,
      fullscreenDialog: true,
      popGesture: true,
      preventDuplicates: true,
    );
    // await Get.toNamed(Routes.fundWalletMenu, preventDuplicates: true);
  }

  late final List<Map<String, dynamic>> greenWalletPaymentMenuCards;

  //================ Wallet functions ================\\

  // Save visibility state to SharedPreferences
  Future<void> saveVisibilityState(bool value) async {
    await prefs.setBool('hideBalance', value);
  }

  changeVisibilityState() {
    saveVisibilityState(!hideBalance.value);
    hideBalance.value = !hideBalance.value;
    update();
  }

  //=========================== Save card state ============================//
  // Load visibility state from SharedPreferences
  Future<void> loadVisibilityState() async {
    hideBalance.value = prefs.getBool('hideBalance') ?? hideBalance.value;
    greenWalletPaymentMenuCards = [
      {
        "amount": int.tryParse(walletBalance),
        "label": "Available balance",
      },
      {
        "amount": 0,
        "label": "Total expenses",
      },
    ];
  }

  //=========================== Fund wallet ============================//
  var isFunding = false.obs;
  final fundWalletFormkey = GlobalKey<FormState>();
  var unformattedAmountText = "".obs;

  var amountEC = TextEditingController();
  var amountFN = FocusNode();

  void formatAmount() {
    // Get the current value
    String currentValue = amountEC.text;

    // Remove any commas to get the unformatted value
    String rawValue = currentValue.replaceAll(',', '');

    // Store the unformatted value
    unformattedAmountText.value = rawValue;

    // Check if it's a valid number
    if (rawValue.isNotEmpty && double.tryParse(rawValue) != null) {
      // Format the number with commas
      String formattedValue = formatWithCommas(rawValue);

      // Update the text controller with the formatted value
      amountEC.value = amountEC.value.copyWith(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
  }

  String formatWithCommas(String value) {
    // Convert the value to a number
    final number = double.parse(value);

    // Format the number with commas
    return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},');
  }

  onFieldSubmitted(String value) {
    fundWallet();
  }

  fundWallet() async {
    if (fundWalletFormkey.currentState!.validate()) {
      // fundWalletFormkey.currentState!.save();
      if (amountEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter an amount");
        return;
      } else if (double.tryParse(unformattedAmountText.value)! <= 100) {
        ApiProcessorController.errorSnack("The amount is too small!");
        return;
      }
      isFunding.value = true;

      try {
        String reference =
            "GreenWheels_${DateTime.now().microsecondsSinceEpoch}";

        var payStackSecretKey = Keys.paystackTestSecretKey ?? "";

        log("Email: ${riderModel.value.email} ");
        log("Paystack Secret Key: $payStackSecretKey ");

        final request = PaystackTransactionRequest(
          reference: reference,
          secretKey: payStackSecretKey,
          email: riderModel.value.email,
          amount: double.tryParse(unformattedAmountText.value)! * 100,
          currency: PaystackCurrency.ngn,
          channel: [
            PaystackPaymentChannel.mobileMoney,
            PaystackPaymentChannel.card,
            PaystackPaymentChannel.ussd,
            PaystackPaymentChannel.bankTransfer,
            PaystackPaymentChannel.bank,
            PaystackPaymentChannel.qr,
            PaystackPaymentChannel.eft,
          ],
        );

        final initializedTransaction =
            await PaymentService.initializeTransaction(request);

        if (!initializedTransaction.status) {
          ApiProcessorController.warningSnack(initializedTransaction.message);
          isFunding.value = false;
          return;
        }

        await PaymentService.showPaymentModal(
          Get.context!,
          transaction: initializedTransaction,
          callbackUrl: '',
        );

        final response = await PaymentService.verifyTransaction(
          paystackSecretKey: payStackSecretKey,
          initializedTransaction.data?.reference ?? request.reference,
        );

        log("Payment Service Response: ${response.toString()}");

        if (response.data.status == PaystackTransactionStatus.success) {
          //Show toast to notify the user of the transaction status
          ApiProcessorController.successSnack(
            // initializedTransaction.message,
            "Transaction Successful",
          );
          isFunding.value = false;

          Get.off(
            () => SuccessScreen(
              loadScreen:
                  SuccessScreenController.instance.goToGreenWalletScreen,
              title: "Wallet credited!",
              subtitleWidget: Column(
                children: [
                  Text(
                    "Amount Paid",
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                          text: intFormattedText(
                              int.tryParse(unformattedAmountText.value) ?? 0),
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            transition: Transition.rightToLeft,
            routeName: "/success-screen",
            curve: Curves.easeInOut,
            fullscreenDialog: true,
            popGesture: true,
            preventDuplicates: true,
          );
        } else if (response.data.status == PaystackTransactionStatus.failed) {
          ApiProcessorController.errorSnack(
              "The transaction failed, please try again later"
              // initializedTransaction.message,
              );

          isFunding.value = false;
        } else if (response.data.status ==
            PaystackTransactionStatus.abandoned) {
          ApiProcessorController.warningSnack(
            // initializedTransaction.message,
            "Transaction abandoned by the user",
          );

          isFunding.value = false;
        } else if (response.data.status == PaystackTransactionStatus.reversed) {
          ApiProcessorController.successSnack(
            // initializedTransaction.message,
            "Transaction will be reversed",
          );

          isFunding.value = false;
        }

        isFunding.value = false;
      } on TimeoutException {
        ApiProcessorController.errorSnack(
          "Internet connection timeout. Please try again",
        );
      } on SocketException {
        ApiProcessorController.errorSnack("Please connect to the internet");
      } catch (e) {
        isFunding.value = false;
        log(e.toString());
      }
      isFunding.value = false;
    }
  }

  fundWithPayStack() async {}

  //Get Rider Profile
  Future<void> getRiderProfile() async {
    var url = ApiUrl.baseUrl + ApiUrl.getRiderProfile;
    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");

    //HTTP Client Service
    http.Response? response =
        await HttpClientService.getRequest(url, userToken);

    if (response == null) {
      return;
    }

    log("Response body=> ${response.body}");
    try {
      if (response.statusCode == 200) {
        // Convert to json
        dynamic responseJson;

        responseJson = jsonDecode(response.body);

        getRiderProfileResponseModel.value =
            GetRiderProfileResponseModel.fromJson(responseJson);

        riderModel.value = getRiderProfileResponseModel.value.data;
        walletBalance.value = riderModel.value.walletBalance;

        log(getRiderProfileResponseModel.value.message);
        log(jsonEncode(riderModel.value));
      } else {
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log("This is the error log: ${e.toString()}");
    }
  }
}
