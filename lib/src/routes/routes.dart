import 'package:get/get.dart';
import 'package:green_wheels/app/menu/views/scheduled_trips_menu/views/scheduled_rides/screen/scheduled_rides_menu_screen.dart';

import '../../app/auth/email_login/screen/email_login_screen.dart';
import '../../app/auth/email_otp/screen/email_otp.dart';
import '../../app/auth/email_signup/screen/email_signup_screen.dart';
import '../../app/auth/phone_login/screen/phone_login_screen.dart';
import '../../app/auth/phone_otp/screen/phone_otp.dart';
import '../../app/auth/phone_signup/screen/phone_signup_screen.dart';
import '../../app/auth/provide_name/screen/provide_name_screen.dart';
import '../../app/auth/provide_phone/screen/provide_phone.dart';
import '../../app/home/content/rent_ride/choose_available_vehicle_scaffold.dart';
import '../../app/home/screen/home_screen.dart';
import '../../app/menu/screen/menu_screen.dart';
import '../../app/menu/views/car_rentals/screen/car_rentals_menu_screen.dart';
import '../../app/menu/views/green_wallet_payment/screen/green_wallet_payment_menu_screen.dart';
import '../../app/menu/views/green_wallet_payment/views/fund_wallet_scaffold.dart';
import '../../app/menu/views/ride_history/screen/ride_history_menu_screen.dart';
import '../../app/menu/views/scheduled_trips_menu/screen/scheduled_trips_menu_screen.dart';
import '../../app/menu/views/scheduled_trips_menu/views/school_commutes/screen/school_commutes_menu_screen.dart';
import '../../app/onboarding/screen/onboarding_screen.dart';
import '../../app/ride/screen/ride_screen.dart';
import '../../app/schedule_trip/screen/schedule_trip_screen.dart';
import '../../app/school_commute/screen/school_commute_screen.dart';
import '../../app/splash/loading/screen/loading_screen.dart';
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
  static const scheduleTripScreen = "/schedule-trip";
  static const schoolCommuteScreen = "/school-commute";
  static const chooseAvailableVehicle = "/choose-available-vehicle";

  //Menu Section
  static const menu = "/menu";
  static const profile = "/profile-menu";
  static const rideHistoryMenu = "/ride-history-menu";
  static const scheduledTripsMenu = "/scheduled-trips-menu";
  static const scheduledRidesMenu = "/scheduled-ride-menu";
  static const schoolCommutesMenu = "/school-commutes-menu";
  static const carRentalsMenu = "/car-rentals-menu";
  static const greenWalletPaymentMenu = "/green-wallet-payment-menu";
  static const fundWalletMenu = "/fund-wallet-menu";
  static const faqMenu = "/faq-menu";
  static const settingsMenu = "/settings-menu";

  //========================= GET PAGES ==========================\\
  static final getPages = [
    //Splash Screens
    GetPage(name: startupSplashscreen, page: () => const StartupSplashScreen()),
    // GetPage(
    //   name: congratulationsSplashScreen,
    //   page: () => const CongratulationsSplashScreen(),
    // ),
    GetPage(name: successScreen, page: () => const SuccessScreen()),
    GetPage(name: loadingScreen, page: () => const LoadingScreen()),

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
    GetPage(
      name: scheduleTripScreen,
      page: () => const ScheduleTripScreen(),
    ),
    GetPage(
      name: schoolCommuteScreen,
      page: () => const SchoolCommuteScreen(),
    ),
    GetPage(
      name: chooseAvailableVehicle,
      page: () => const ChooseAvailableVehicleScaffold(),
    ),

    //Menu Section
    // GetPage(name: notificationsScreen, page: () => const NotificationsScreen()),
    GetPage(name: menu, page: () => const MenuScreen()),
    GetPage(name: rideHistoryMenu, page: () => const RideHistoryMenuScreen()),
    GetPage(
      name: scheduledTripsMenu,
      page: () => const ScheduledTripsMenuScreen(),
    ),
    GetPage(
      name: scheduledRidesMenu,
      page: () => const ScheduledRidesMenuScreen(),
    ),
    GetPage(
      name: schoolCommutesMenu,
      page: () => const SchoolCommutesMenuScreen(),
    ),
    GetPage(name: carRentalsMenu, page: () => const CarRentalMenuScreen()),
    GetPage(
      name: greenWalletPaymentMenu,
      page: () => const GreenWalletPaymentMenuScreen(),
    ),
    GetPage(
      name: fundWalletMenu,
      page: () => const FundWalletMenuScaffold(),
    ),
    // GetPage(name: faqMenu, page: () => const FAQMenuScreen()),
    // GetPage(name: settingsMenu, page: () => const SettingsMenuScreen()),
  ];
}
