import 'package:get/get.dart';

import '../../app/auth/login/screen/login_screen.dart';
import '../../app/auth/phone_otp/screen/email_otp.dart';
import '../../app/auth/signup/screen/signup_screen.dart';
import '../../app/onboarding/screen/onboarding_screen.dart';
import '../../app/splash/startup/screen/splash_screen.dart';
import '../../app/splash/success/screen/success_screen.dart';
// import '../../app/home/screen/home_screen.dart';
// import '../../app/profile/screen/profile_screen.dart';
// import '../../app/profile/screens/scheduled_trips/screen/scheduled_trips_screen.dart';
// import '../../app/profile/screens/scheduled_trips/screens/school_commutes/screen/school_commutes.dart';
// import '../../app/profile/screens/settings/screen/settings_screen.dart';
// import '../../app/ride/screen/ride_screen.dart';

class Routes {
  //Splash screens
  static const startupSplashscreen = "/";
  static const congratulationsSplashScreen = "/congratulations-splash-screen";
  static const successScreen = "/success-screen";
  static const loadingScreen = "/loading-screen";

  //Onboarding
  static const onboarding = "/onboarding";

  //Locked Screen
  static const lockedScreen = "/lockedScreen";

  //Auth Screens
  static const signup = "/signup";
  static const login = "/login";
  static const emailOTP = "/email-otp";
  static const resetPassword = "/reset-password";
  static const resetPasswordViaEmail = "/reset-password-via-email";
  static const resetPasswordViaEmailOTP = "/reset-password-via-email-otp";

  //Home Section
  static const homeScreen = "/home";
  static const rideScreen = "/ride";

  //Profile Section
  static const profileScreen = "/profile";
  static const scheduledTripsScreen = "/scheduled-trips-screen";
  static const scheduledRides = "/scheduled-rides";
  static const schoolCommutesScreen = "/school-commutes";
  static const support = "/support";
  static const settingsScreen = "/settings";

  //========================= GET PAGES ==========================\\
  static final getPages = [
    //Splash Screens
    GetPage(name: startupSplashscreen, page: () => const StartupSplashScreen()),
    // GetPage(
    //   name: congratulationsSplashScreen,
    //   page: () => const CongratulationsSplashScreen(),
    // ),
    GetPage(name: successScreen, page: () => const SuccessScreen()),
    // GetPage(name: loadingScreen, page: () => const LoadingScreen()),

    //Auth Pages
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: emailOTP, page: () => const EmailOTP()),

    //Main App Section
    // GetPage(name: homeScreen, page: () => const HomeScreen()),
    // GetPage(name: rideScreen, page: () => const RideScreen()),
    // GetPage(name: profileScreen, page: () => const ProfileScreen()),
    // GetPage(
    //   name: scheduledTripsScreen,
    //   page: () => const ScheduledTripsScreen(),
    // ),
    // GetPage(
    //   name: schoolCommutesScreen,
    //   page: () => const SchoolCommutesScreen(),
    // ),
    // GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    // GetPage(name: notificationsScreen, page: () => const NotificationsScreen()),
  ];
}
