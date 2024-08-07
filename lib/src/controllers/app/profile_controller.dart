import 'package:get/get.dart';

// import '../../../app/profile/screens/scheduled_trips/screen/scheduled_trips_screen.dart';
// import '../../../app/profile/screens/settings/screen/settings_screen.dart';

class ProfileController extends GetxController {
  static ProfileController get instance {
    return Get.find<ProfileController>();
  }

  //=================================== Navigation =====================================\\

  //==To Scheduled Rides==>
  // goToScheduledTrips() async {
  //   Get.to(
  //     () => const ScheduledTripsScreen(),
  //     transition: Transition.rightToLeft,
  //     routeName: "/scheduled-trips-screen",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     preventDuplicates: true,
  //   );
  // }

  //==To Settings==>
  // goToSettings() async {
  //   Get.to(
  //     () => const SettingsScreen(),
  //     transition: Transition.rightToLeft,
  //     routeName: "/settings",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     preventDuplicates: true,
  //   );
  // }

  //==To Support==>
  goToSupport() async {
    // Get.to(
    //   () => const Support(),
    //   transition: Transition.rightToLeft,
    //   routeName: "/support",
    //   curve: Curves.easeInOut,
    //   fullscreenDialog: true,
    //   popGesture: true,
    //   preventDuplicates: true,
    // );
  }
}
