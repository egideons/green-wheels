import 'package:get/get.dart';

// import '../../../app/profile/screens/scheduled_trips/screens/scheduled_rides/screen/scheduled_rides.dart';
// import '../../../app/profile/screens/scheduled_trips/screens/school_commutes/screen/school_commutes.dart';

class ScheduledTripsController extends GetxController {
  static ScheduledTripsController get instance {
    return Get.find<ScheduledTripsController>();
  }

  //=================================== Navigation =====================================\\

  //==To Scheduled Rides==>
  // goToScheduledRides() async {
  //   Get.to(
  //     () => const ScheduledRides(),
  //     transition: Transition.rightToLeft,
  //     routeName: "/scheduled-rides-screen",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     preventDuplicates: true,
  //   );
  // }

  //==To School Commutes==>
  // goToSchoolCommutes() async {
  //   Get.to(
  //     () => const SchoolCommutesScreen(),
  //     transition: Transition.rightToLeft,
  //     routeName: "/school-commutes",
  //     curve: Curves.easeInOut,
  //     fullscreenDialog: true,
  //     popGesture: true,
  //     preventDuplicates: true,
  //   );
  // }
}
