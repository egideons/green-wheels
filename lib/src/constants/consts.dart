//default value
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_wheels/theme/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\s*$';
//Hide Digits pattern
const String hideDigits = r'\d';

const kBigSizedBox = SizedBox(height: kDefaultPadding * 2);
const kBigWidthSizedBox = SizedBox(width: kDefaultPadding * 2);

const kDefaultPadding = 20.0;
const kHalfDefaultPadding = 10.0;

const kHalfSizedBox = SizedBox(height: kDefaultPadding / 2);
const kHalfWidthSizedBox = SizedBox(width: kDefaultPadding / 2);

const kSizedBox = SizedBox(height: kDefaultPadding);
const kSmallSizedBox = SizedBox(height: 5);

const kSmallWidthSizedBox = SizedBox(width: 5);

const kWidthSizedBox = SizedBox(width: kDefaultPadding);

const String loginPasswordPattern = r'^.{8,}$';

//validation for mobile
// const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
const String mobilePattern = r'^(?!0+$)\d{10,11}$';

//username pattern
const String namePattern = r'^.{3,}$'; //Min. of 3 characters

const String nigerianPhoneMobilePattern = r'^(\+?234|0)?[789]\d{9}$';

//password pattern
const String passwordPattern =
    r'^(?=.*[A-Za-z0-9])(?=.*[^A-Za-z0-9])(?=.*\d).{8,}$';
//referral Code pattern
const String referralCodePattern = r'^.{6}$';

//validation for street address
const String streetAddressPattern = r'^\d+\s+[a-zA-Z0-9\s.-]+$';

const String zipCodePattern = r"^\d{6}(?:-\d{4})?$";

String nA = "N/A";

String nairaSign = '\u20A6';

String phoneNumberPattern = r'^\(\d{3}\) \d{3}-\d{4}$';

convertToCurrency(String e) {
  String newStr = e.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[0]},");
  return newStr;
}

String convertToDateString(String inputString) {
  return inputString.replaceFirst(RegExp(r"\T.*"), "");
}

// Create a unique Id using DateTime
int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1);
}

defaultTextStyle({
  Color? color,
  Paint? background,
  Color? backgroundColor,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  String? debugLabel,
  String? fontFamily,
  double? fontSize,
  FontStyle? fontStyle,
  FontWeight? fontWeight,
  double? letterSpacing,
}) =>
    TextStyle(
      color: color ?? kTextBlackColor,
      background: background,
      backgroundColor: backgroundColor,
      decoration: decoration ?? TextDecoration.none,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamily: fontFamily ?? "Prototype",
      fontSize: fontSize ?? 14.0,
      fontStyle: fontStyle ?? FontStyle.normal,
      fontWeight: fontWeight ?? FontWeight.w600,
      letterSpacing: letterSpacing ?? .60,
    );

//========== Image ==============\\
const int maxImageSize = 5 * 1024 * 1024; // 5 MB

Future<bool> checkXFileSize(XFile? image) async {
  if (image == null) {
    return false;
  }
  int imgLen = await image.length();
  return imgLen > maxImageSize;
}

//===================== Number format ==========================\\
String doubleFormattedText(double value) {
  final numberFormat = NumberFormat('#,##0');
  return numberFormat.format(value);
}

String doubleFormattedTextWithDecimal(double value) {
  final numberFormat = NumberFormat('#,##0.00');
  return numberFormat.format(value);
}

String format12HrTime(DateTime time) {
  // Format the time as '1:20PM'
  String formattedTime = DateFormat.jm().format(time);

  return formattedTime;
}

String formatDate(DateTime date) {
  // Format the date as '23 Feb 2020'
  String formattedDate = DateFormat('MMM dd, y').format(date);

  return formattedDate;
}

//===================== DateTime Formate ==========================\\

String formatDateAndTime(DateTime dateTime) {
  // Format the date as '23 Feb 2020'
  String formattedDate = DateFormat('dd MMM y').format(dateTime);

  // Format the time as '1:20PM'
  String formattedTime = DateFormat.jm().format(dateTime);

  // Combine the formatted date and time
  String formattedDateTime = '$formattedDate • $formattedTime';

  return formattedDateTime;
}

String formatDoubleNumber(double num) {
  if (num >= 1000000000) {
    double numDouble = num / 1000000000.0;
    return '${numDouble.toStringAsFixed(numDouble.truncateToDouble() == numDouble ? 0 : 2)}B';
  } else if (num >= 1000000) {
    double numDouble = num / 1000000.0;
    return '${numDouble.toStringAsFixed(numDouble.truncateToDouble() == numDouble ? 0 : 2)}M';
  } else if (num >= 1000) {
    double numDouble = num / 1000.0;
    return '${numDouble.toStringAsFixed(numDouble.truncateToDouble() == numDouble ? 0 : 2)}K';
  } else {
    return num.toString();
  }
}

String formatIntNumber(int num) {
  if (num >= 1000000000) {
    double numDouble = num / 1000000000.0;
    return '${numDouble.toStringAsFixed(numDouble.truncateToDouble() == numDouble ? 0 : 2)}B';
  } else if (num >= 1000000) {
    double numDouble = num / 1000000.0;
    return '${numDouble.toStringAsFixed(numDouble.truncateToDouble() == numDouble ? 0 : 2)}M';
  } else if (num >= 1000) {
    double numDouble = num / 1000.0;
    return '${numDouble.toStringAsFixed(numDouble.truncateToDouble() == numDouble ? 0 : 2)}K';
  } else {
    return num.toString();
  }
}

// Example function to format a number with thousands separators
String formatNumberWithCommas(int number) {
  // Create a NumberFormat instance for the current locale
  final NumberFormat formatter = NumberFormat("#,##0", "en_US");
  // Format the number with thousands separators
  return formatter.format(number);
}

String formatUNIXTime(int unixTimestamp) {
  // Convert the Unix timestamp to a DateTime object
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);

  // Create a DateFormat object
  DateFormat dateFormat = DateFormat('yyyy-MM-dd • HH:mm');

  // Format the DateTime object to the desired string
  String formattedString = dateFormat.format(dateTime.toLocal());

  return formattedString;
}

List<int> generateRandomNumbers(int limit, int num) {
  Random random = Random();
  List<int> randomNumbers = [];

  for (int i = 0; i < limit; i++) {
    randomNumbers
        .add(random.nextInt(num)); // Generates random number between 0 and 20
  }

  return randomNumbers;
}

String generateRandomReference({int length = 32}) {
  var random = Random.secure();
  var values = List<int>.generate(length, (i) => random.nextInt(256));
  var randomString = base64Url.encode(values);
  return randomString.substring(0, length);
}

String intFormattedText(int value) {
  final numberFormat = NumberFormat('#,##0');
  return numberFormat.format(value);
}

//===================== Mask Phone Number ==========================\\
String maskString(String phoneNumber) {
  // Ensure the phone number is at least 4 characters long
  if (phoneNumber.length < 4) {
    throw ArgumentError('Phone number must be at least 4 digits long');
  }

  // Get the last 4 digits of the phone number
  String lastFour = phoneNumber.substring(phoneNumber.length - 4);

  // Mask the remaining part of the phone number with asterisks
  String maskedPart = '*' * (phoneNumber.length - 4);

  // Combine the masked part with the last four digits
  return maskedPart + lastFour;
}

String maskWalletBalance(String walletBalance) {
  if (walletBalance.contains('.')) {
    // Split the walletBalance string into two parts: before and after the decimal point
    List<String> parts = walletBalance.split('.');
    // Create masked versions of both parts
    String maskedBeforeDecimal = parts[0].replaceAll(RegExp(r'[0-9]'), '*');
    String maskedAfterDecimal = parts[1].replaceAll(RegExp(r'[0-9]'), '*');
    // Combine both masked parts with the decimal point
    return '$maskedBeforeDecimal.$maskedAfterDecimal';
  } else {
    // If no decimal point, mask the entire walletBalance string
    return walletBalance.replaceAll(RegExp(r'[0-9]'), '*');
  }
}

String shortenId(String id) {
  if (id.length <= 8) {
    return id;
  }
  final int mid = id.length ~/ 2;
  return '${id.substring(0, 4)}...${id.substring(mid + 1)}';
}

String getNameInitials(String name) {
  // Split the name by spaces
  List<String> nameParts = name.split(' ');

  // Map each part to its first letter and join them
  String initials = nameParts.map((part) => part[0]).join();

  return initials.toUpperCase(); // Convert to uppercase if needed
}
