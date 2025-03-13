// ignore_for_file: use_build_context_synchronously

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
import 'package:green_wheels/src/models/wallet/wallet_fund_response_model.dart';
import 'package:green_wheels/src/services/api/api_url.dart';
import 'package:green_wheels/src/services/client/http_client_service.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../others/api_processor_controller.dart';

class GreenWalletPaymentMenuController extends GetxController {
  static GreenWalletPaymentMenuController get instance {
    return Get.find<GreenWalletPaymentMenuController>();
  }

  @override
  void onInit() async {
    super.onInit();
    await loadVisibilityState();
    await getRiderProfile();
    amountEC.clear();
    scrollController.addListener(_scrollListener);
    amountEC.addListener(formatAmount);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
    amountEC.removeListener(formatAmount);
    amountEC.dispose();
    amountFN.dispose();
  }

  //================ Variables =================\\

  var walletBalance = "0".obs;
  var totalExpenses = "0".obs;
  var riderUUID = "".obs;

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

    await getRiderProfile();

    isLoading.value = false;
    update();
  }

  //================ Scroll to Top =================//
  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
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

  //=========================== Load Visibility State ============================//
  // Load visibility state from SharedPreferences
  Future<void> loadVisibilityState() async {
    hideBalance.value = prefs.getBool('hideBalance') ?? hideBalance.value;

    log("This is the wallet balance: $walletBalance");
  }

  //=========================== Fund wallet ============================//
  var isFunding = false.obs;
  final fundWalletFormkey = GlobalKey<FormState>();
  var unformattedAmountText = "".obs;

  var amountEC = TextEditingController();
  var amountFN = FocusNode();

  var walletFundResponseModel = WalletFundResponseModel.fromJson(null).obs;

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

  onFieldSubmitted(String value, BuildContext context) {
    fundWalletWithPayStack(context);
  }

  Future<void> fundWalletWithPayStack(BuildContext context) async {
    //Form Validation
    if (fundWalletFormkey.currentState!.validate()) {
      if (amountEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter an amount");
        return;
      } else if (double.tryParse(unformattedAmountText.value)! <= 100) {
        ApiProcessorController.errorSnack("The amount is too small!");
        return;
      }

      isFunding.value = true;
      String reference = "GreenWheels_${DateTime.now().microsecondsSinceEpoch}";

      // var paystackTestSecretKey = Keys.paystackTestSecretKey ?? "";
      var paystackSecretKey = Keys.paystackSecretKey ?? "";
      var email = riderModel.value.email;

      log("Email: $email ");

      log("Paystack Secret Key: $paystackSecretKey ");

      final request = PaystackTransactionRequest(
        reference: reference,
        secretKey: paystackSecretKey,
        // secretKey: paystackTestSecretKey,
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
      ApiProcessorController.normalSnack(
        "Please make sure to close the page after the transaction.",
        duration: Duration(seconds: 4),
      );

      await PaymentService.showPaymentModal(
        context,
        transaction: initializedTransaction,
        callbackUrl: '',
        onClosing: () {
          Get.close(0);
        },
      );

      try {
        final response = await PaymentService.verifyTransaction(
          paystackSecretKey: paystackSecretKey,
          // paystackSecretKey: paystackTestSecretKey,
          initializedTransaction.data?.reference ?? request.reference,
        );

        log(response.toString(), name: "Payment Service Response");

        if (response.data.status == PaystackTransactionStatus.success) {
          var walletIsFunded = await fundWallet();

          if (walletIsFunded) {
            isFunding.value = false;
            //Show toast to notify the user of the transaction status
            ApiProcessorController.successSnack("Transaction Successful");

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
          }
        } else if (response.data.status == PaystackTransactionStatus.failed) {
          ApiProcessorController.errorSnack(
              "The transaction failed, please try again later"
              // initializedTransaction.message,
              );
        } else if (response.data.status ==
            PaystackTransactionStatus.abandoned) {
          ApiProcessorController.warningSnack(
            // initializedTransaction.message,
            "Transaction abandoned by the user",
          );
        } else if (response.data.status == PaystackTransactionStatus.reversed) {
          ApiProcessorController.successSnack(
            // initializedTransaction.message,
            "Transaction will be reversed",
          );
        }
      } on TimeoutException {
        ApiProcessorController.errorSnack(
          "Internet connection timeout. Please try again",
        );
      } on SocketException {
        ApiProcessorController.errorSnack("Please connect to the internet");
      } catch (e, stackTrace) {
        isFunding.value = false;
        log(e.toString(), stackTrace: stackTrace, name: "Wallet Funding");
      } finally {
        isFunding.value = false;
      }
    }
  }

  Future<bool> fundWallet() async {
    var url = ApiUrl.baseUrl + ApiUrl.transactionCallBackUrl;
    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");
    // Get the current DateTime
    DateTime now = DateTime.now();

    // Format the DateTime
    String formattedDate = DateFormat('yyyy-MM-dd, hh:mma').format(now);

    var data = {
      "rideruuid": riderUUID.value,
      "amount": unformattedAmountText.value,
      "time_stamp": formattedDate,
    };
//
    //HTTP Client Service
    http.Response? response =
        await HttpClientService.postRequest(url, userToken, data, null, false);

    log(jsonEncode(data));

    if (response == null) {
      return false;
    }

    log("Response body=> ${response.body}");
    log("Response Status code=> ${response.statusCode}");

    try {
      if (response.statusCode == 200) {
        // Convert to json
        dynamic responseJson;
        responseJson = jsonDecode(response.body);

        walletFundResponseModel.value =
            WalletFundResponseModel.fromJson(responseJson);
        walletBalance.value =
            walletFundResponseModel.value.data.newBalance.toString();
        return true;
      } else {
        log("An error occured, Response body: ${response.body}");
        return false;
      }
    } catch (e) {
      log("This is the error log: ${e.toString()}");
      return false;
    }
  }

  //Get Rider Profile
  Future<void> getRiderProfile() async {
    var url = ApiUrl.baseUrl + ApiUrl.getRiderProfile;
    var userToken = prefs.getString("userToken");

    log("URL=> $url\nUSERTOKEN=>$userToken");

    isLoading.value = true;

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
        riderUUID.value = riderModel.value.riderUuid;
        walletBalance.value = riderModel.value.walletBalance;
        // totalExpenses.value = riderModel.value.totalExpenses;

        await Future.delayed(const Duration(milliseconds: 500));

        log(getRiderProfileResponseModel.value.message);
        log(jsonEncode(riderModel.value));
        isLoading.value = false;
      } else {
        log("An error occured, Response body: ${response.body}");
      }
    } catch (e) {
      log("This is the error log: ${e.toString()}");
    }
    isLoading.value = false;
  }
}
