import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/controllers/others/connectivity_status_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/controllers/others/loading_controller.dart';
import 'src/controllers/others/theme_controller.dart';
import 'src/routes/routes.dart';
import 'src/utils/components/app_error_widget.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kTransparentColor),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  prefs = await SharedPreferences.getInstance();

  Get.put(ThemeController());
  Get.put(LoadingController());
  Get.put(ConnectivityStatusController());

  //This is to handle widget errors by showing a custom error widget screen
  if (kReleaseMode) ErrorWidget.builder = (_) => const AppErrorWidget();

  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
    if (!kReleaseMode) return;
  };
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

late SharedPreferences prefs;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //iOS App
    if (Platform.isIOS) {
      return GetCupertinoApp(
        title: "Green Wheels",
        color: kPrimaryColor,
        navigatorKey: Get.key,
        defaultTransition: Transition.native,
        debugShowCheckedModeBanner: false,
        locale: Get.deviceLocale,
        initialRoute: Routes.startupSplashscreen,
        getPages: Routes.getPages,
        theme: Get.isDarkMode ? iOSDarkTheme : iOSLightTheme,
      );
    }

    //Android App
    return GetMaterialApp(
      title: "Green Wheels",
      color: kPrimaryColor,
      navigatorKey: Get.key,
      defaultTransition: Transition.native,
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      initialRoute: Routes.startupSplashscreen,
      getPages: Routes.getPages,
      theme: androidLightTheme,
      darkTheme: androidDarkTheme,
      // themeMode: ThemeController.instance.themeMode.value,
      themeMode: ThemeMode.light,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
      ),
    );
  }
}
