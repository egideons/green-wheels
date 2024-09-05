import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchoolCommutesMenuController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SchoolCommutesMenuController get instance {
    return Get.find<SchoolCommutesMenuController>();
  }

  late TabController tabBarController;
  var selectedTabBar = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    tabBarController = TabController(length: 3, vsync: this);
    tabBarController.addListener(() {
      selectedTabBar.value = tabBarController.index;
    });
  }

  @override
  void onClose() {
    tabBarController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  //================ controllers =================\\
  var scrollController = ScrollController();

  //================ Booleans =================\\
  var isScrollToTopBtnVisible = false.obs;

  void clickOnTabBarOption(int index) {
    selectedTabBar.value = index;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  //================ Scroll to Top =================//
  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

//================ Scroll Listener =================//

  void _scrollListener() {
    //========= Show action button ========//
    if (scrollController.position.pixels >= 150) {
      isScrollToTopBtnVisible.value = true;
      update();
    }
    //========= Hide action button ========//
    else if (scrollController.position.pixels < 150) {
      isScrollToTopBtnVisible.value = false;
      update();
    }
  }

  //================ Handle refresh ================\\

  Future<void> onRefresh() async {
    isLoading.value = true;
    update();

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    update();
  }
}
