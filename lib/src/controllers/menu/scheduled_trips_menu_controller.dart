import 'package:get/get.dart';

import '../../routes/routes.dart';

class ScheduledTripsMenuController extends GetxController {
  static ScheduledTripsMenuController get instance {
    return Get.find<ScheduledTripsMenuController>();
  }

  //=================================== Navigation =====================================\\

  //==To Scheduled Rides==>
  goToScheduledRides() async {
    Get.toNamed(
      Routes.scheduledRidesMenu,
      preventDuplicates: true,
    );
    // Get.to(
    //   () => const ScheduledRidesMenuScreen(),
    //   transition: Transition.rightToLeft,
    //   routeName: "/scheduled-rides-screen",
    //   curve: Curves.easeInOut,
    //   fullscreenDialog: true,
    //   popGesture: true,
    //   preventDuplicates: true,
    // );
  }

  //==To School Commutes==>
  goToSchoolCommutes() async {
    Get.toNamed(
      Routes.schoolCommutesMenu,
      preventDuplicates: true,
    );
    // Get.to(
    //   () => const SchoolCommutesMenuScreen(),
    //   transition: Transition.rightToLeft,
    //   routeName: "/school-commutes",
    //   curve: Curves.easeInOut,
    //   fullscreenDialog: true,
    //   popGesture: true,
    //   preventDuplicates: true,
    // );
  }
}
