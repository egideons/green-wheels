import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/services/notification/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/controllers/others/connectivity_status_controller.dart';
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

  await NotificationService.instance.initialize();

  prefs = await SharedPreferences.getInstance();

  Get.put(ThemeController());
  Get.put(LoadingController());
  Get.put(ConnectivityStatusController());

  await dotenv.load(fileName: ".env");

  if (kReleaseMode) ErrorWidget.builder = (_) => const AppErrorWidget();

  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
    if (!kReleaseMode) return;
  };

  runApp(const MyApp());
}

late SharedPreferences prefs;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        log("App resumed");
        restoreAppState();
        break;
      case AppLifecycleState.inactive:
        log("App inactive");
        break;
      case AppLifecycleState.paused:
        log("App paused");
        saveAppState();
        break;
      case AppLifecycleState.detached:
        log("App detached");
        break;
      case AppLifecycleState.hidden:
        log("App hidden");
        break;
    }
  }

  void saveAppState() async {
    await prefs.setBool("appMinimized", true);
    log("App state saved");
  }

  void restoreAppState() async {
    bool? wasMinimized = prefs.getBool("appMinimized");
    if (wasMinimized == true) {
      log("Restoring app state...");
      await prefs.setBool("appMinimized", false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      themeMode: ThemeMode.light,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
      ),
    );
  }
}
