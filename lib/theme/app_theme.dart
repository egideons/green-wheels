import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/constants/consts.dart';
import 'colors.dart';

//IOS Light Theme
CupertinoThemeData? iOSLightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  applyThemeToAll: true,
  scaffoldBackgroundColor: kLightBackgroundColor,
  barBackgroundColor: kLightBackgroundColor,
  textTheme: CupertinoTextThemeData(
    textStyle: defaultTextStyle(),
  ),
);

//IOS Dark Theme
CupertinoThemeData? iOSDarkTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  applyThemeToAll: true,
  scaffoldBackgroundColor: kDarkBackgroundColor,
  barBackgroundColor: kDarkBackgroundColor,
  textTheme: CupertinoTextThemeData(
    textStyle: defaultTextStyle(),
  ),
);

//Android Light Theme
ThemeData androidLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  applyElevationOverlayColor: false,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: "Prototype",
      fontSize: 36,
      fontWeight: FontWeight.w900,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    titleMedium: TextStyle(
      fontFamily: "Prototype",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    titleSmall: TextStyle(
      fontFamily: "Prototype",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Prototype",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Prototype",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    bodySmall: TextStyle(
      fontFamily: "Prototype",
      fontSize: 12,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    labelLarge: TextStyle(
      fontFamily: "Prototype",
      fontSize: 30,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    labelMedium: TextStyle(
      fontFamily: "Prototype",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    labelSmall: TextStyle(
      fontFamily: "Prototype",
      fontSize: 10,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
  ),
  // textTheme: GoogleFonts.montserratAlternatesTextTheme(Typography.dense2021),
  colorScheme: const ColorScheme.light(
    surface: kLightBackgroundColor,
    primary: kPrimaryColor,
    inversePrimary: kDisabledColor,
    secondary: kSecondaryColor,
    brightness: Brightness.light,
    error: kErrorColor,
  ),
);

//Android Dark Theme
ThemeData androidDarkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  applyElevationOverlayColor: false,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: "Prototype",
      fontSize: 36,
      fontWeight: FontWeight.w900,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    titleMedium: TextStyle(
      fontFamily: "Prototype",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    titleSmall: TextStyle(
      fontFamily: "Prototype",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    bodyLarge: TextStyle(
      fontFamily: "Prototype",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    bodyMedium: TextStyle(
      fontFamily: "Prototype",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    bodySmall: TextStyle(
      fontFamily: "Prototype",
      fontSize: 12,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    labelLarge: TextStyle(
      fontFamily: "Prototype",
      fontSize: 30,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    labelMedium: TextStyle(
      fontFamily: "Prototype",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
    labelSmall: TextStyle(
      fontFamily: "Prototype",
      fontSize: 10,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
      letterSpacing: -0.40,
    ),
  ),
  // textTheme: GoogleFonts.montserratAlternatesTextTheme(Typography.dense2021),
  // colorScheme: ColorScheme.dark(
  //   surface: kDarkBackgroundColor,
  //   primary: kLightBackgroundColor,
  //   inversePrimary: kDarkShade,
  //   secondary: kSecondaryColor,
  //   brightness: Brightness.dark,
  //   error: kErrorColor,
  // ),
);
