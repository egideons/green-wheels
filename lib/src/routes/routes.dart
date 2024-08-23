import 'package:get/get.dart';

import '../../app/auth/email_login/screen/email_login_screen.dart';
import '../../app/auth/email_otp/screen/email_otp.dart';
import '../../app/auth/email_signup/screen/email_signup_screen.dart';
import '../../app/auth/phone_login/screen/phone_login_screen.dart';
import '../../app/auth/phone_otp/screen/phone_otp.dart';
import '../../app/auth/phone_signup/screen/phone_signup_screen.dart';
import '../../app/auth/provide_name/screen/provide_name_screen.dart';
import '../../app/auth/provide_phone/screen/provide_phone.dart';
import '../../app/home/screen/home_screen.dart';
import '../../app/onboarding/screen/onboarding_screen.dart';
import '../../app/ride/screen/ride_screen.dart';
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
  static const phoneSignup = "/phone-signup";
  static const phoneLogin = "/phone-login";
  static const phoneOTP = "/phone-otp";
  static const emailSignup = "/email-signup";
  static const emailLogin = "/email-login";
  static const emailOTP = "/email-otp";
  static const providePhone = "/provide-phone";
  static const provideName = "/provide-Name";
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
    GetPage(name: phoneSignup, page: () => const PhoneSignupScreen()),
    GetPage(name: phoneLogin, page: () => const PhoneLoginScreen()),
    GetPage(name: phoneOTP, page: () => const PhoneOTP()),
    GetPage(name: emailSignup, page: () => const EmailSignupScreen()),
    GetPage(name: providePhone, page: () => const ProvidePhone()),
    GetPage(name: emailLogin, page: () => const EmailLoginScreen()),
    GetPage(name: emailOTP, page: () => const EmailOTP()),
    GetPage(name: provideName, page: () => const ProvideNameScreen()),

    //Main App Section
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: rideScreen, page: () => const RideScreen()),
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
