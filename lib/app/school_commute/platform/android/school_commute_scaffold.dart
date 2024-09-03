import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/utils/buttons/android/android_elevated_button.dart';
import 'package:green_wheels/src/utils/components/default_info_container.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';

import '../../../../src/constants/assets.dart';
import '../../../../src/constants/consts.dart';
import '../../../../src/controllers/app/school_commute_controller.dart';
import '../../../../theme/colors.dart';
import '../../content/school_commute_select_date_time_route_form.dart';

class SchoolCommuteScaffold extends GetView<SchoolCommuteController> {
  const SchoolCommuteScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;
    var defaultTextFieldBorderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(colorScheme, media, title: "School Commutes"),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          SvgPicture.asset(
            Assets.carCalendarOutlineIconSvg,
            height: 60,
          ),
          kBigSizedBox,
          Text(
            "Select a pickup date, time and route",
            maxLines: 2,
            style: defaultTextStyle(
              color: kTextBlackColor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          kSizedBox,
          defaultInfoContainer(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: schoolCommuteSelectDateTimeRouteForm(
              defaultTextFieldBorderStyle,
              controller,
            ),
          ),
          kBigSizedBox,
          Obx(
            () {
              return AndroidElevatedButton(
                title: "Confirm Booking",
                disable: controller.confirmBookingButtonIsEnabled.isFalse,
                onPressed: controller.confirmBooking,
              );
            },
          ),
        ],
      ),
    );
  }
}
