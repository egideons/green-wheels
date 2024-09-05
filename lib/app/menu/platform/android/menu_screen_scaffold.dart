import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_wheels/src/constants/consts.dart';
import 'package:green_wheels/src/utils/components/my_app_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../src/controllers/app/menu_screen_controller.dart';
import '../../content/menu_option.dart';
import '../../content/menu_total_info_container.dart';
import '../../content/profile_info.dart';

class MenuScreenScaffold extends GetView<MenuScreenController> {
  const MenuScreenScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: myAppBar(
        colorScheme,
        media,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification),
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: FadeInRight(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                profileInfo(colorScheme, media, controller),
                kBigSizedBox,
                SizedBox(
                  height: 100,
                  child: Row(
                    children: List.generate(
                      controller.menuTotalInfo.length,
                      (index) {
                        var menu = controller.menuTotalInfo[index];
                        return Expanded(
                          child: FadeIn(
                            curve: Curves.easeInOut,
                            child: menuTotalInfoContainer(
                              colorScheme,
                              icon: menu["icon"],
                              label: menu["label"],
                              number: menu["number"],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                kSizedBox,
                ListView.separated(
                  itemCount: controller.menuOptions.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => kSizedBox,
                  itemBuilder: (context, index) {
                    var menuItem = controller.menuOptions[index];
                    return menuOption(
                      colorScheme,
                      controller,
                      nav: menuItem["nav"],
                      icon: menuItem["icon"],
                      title: menuItem["label"],
                    );
                  },
                ),
                kSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
