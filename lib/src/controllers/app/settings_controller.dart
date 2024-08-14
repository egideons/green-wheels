import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance {
    return Get.find<SettingsController>();
  }

  //=================================== Navigation =====================================\\
  // showLogoutModalBottomSheet() async {
  //   final media = MediaQuery.of(Get.context!).size;
  //   var colorScheme = Theme.of(Get.context!).colorScheme;

  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     constraints:
  //         BoxConstraints(maxHeight: media.height, minWidth: media.width),
  //     enableDrag: true,
  //     useSafeArea: true,
  //     context: Get.context!,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(50),
  //         topRight: Radius.circular(50),
  //       ),
  //     ),
  //     builder: (context) {
  //       // return Obx(() {
  //       return logoutScaffold(colorScheme, media);
  //       // });
  //     },
  //   );
  // }

  //=================================== Logout =====================================\\

  // logOut() async {
  //   // Log the user out and save the state
  //   prefs.setBool("isLoggedIn", false);

  //   await Get.offAll(
  //     () => const PhoneLoginScreen(),
  //     routeName: "/login",
  //     fullscreenDialog: true,
  //     curve: Curves.easeInOut,
  //     predicate: (routes) => false,
  //     popGesture: false,
  //     transition: Get.defaultTransition,
  //   );
  // }
}
