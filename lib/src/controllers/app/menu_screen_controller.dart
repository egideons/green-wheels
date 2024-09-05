import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../routes/routes.dart';

class MenuScreenController extends GetxController {
  static MenuScreenController get instance {
    return Get.find<MenuScreenController>();
  }

  //===================== Variable ========================\\
  List<Map<String, dynamic>> menuTotalInfo = [
    {
      "icon": Iconsax.routing,
      "number": 10,
      "label": "Ride bookings",
    },
    {
      "icon": Iconsax.calendar_1,
      "number": 5,
      "label": "Scheduled Rides",
    },
    {
      "icon": Iconsax.car,
      "number": 1,
      "label": "Car rentals",
    },
  ];

  List<Map<String, dynamic>> get menuOptions {
    return [
      {
        "icon": Iconsax.routing,
        "nav": goToRideHistory,
        "label": "Ride History",
      },
      {
        "icon": Iconsax.calendar_1,
        "nav": goToScheduledTrips,
        "label": "Scheduled TRips",
      },
      {
        "icon": Iconsax.car,
        "nav": goToCarRentals,
        "label": "Car Rentals",
      },
      {
        "icon": Iconsax.wallet_1,
        "nav": goToGreenWalletPayment,
        "label": "Green Wallet Payment",
      },
      {
        "icon": Iconsax.message_question,
        "nav": goToFAQs,
        "label": "FAQ",
      },
      {
        "icon": Iconsax.setting_2,
        "nav": goToSettings,
        "label": "Settings",
      },
    ];
  }

  //===================== Navivations ========================\\
  goToRideHistory() async {
    Get.toNamed(
      Routes.rideHistoryMenu,
      preventDuplicates: true,
    );
  }

  goToScheduledTrips() async {}

  goToCarRentals() async {}

  goToGreenWalletPayment() async {}

  goToFAQs() async {}

  goToSettings() async {}
}
