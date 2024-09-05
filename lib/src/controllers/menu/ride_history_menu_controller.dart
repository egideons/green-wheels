import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideHistoryMenuController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static RideHistoryMenuController get instance {
    return Get.find<RideHistoryMenuController>();
  }

  late TabController tabBarController;
  var selectedTabBar = 0.obs;
  var isLoading = false.obs;

  //================ controllers =================\\
  var scrollController = ScrollController();

  //================ Booleans =================\\
  var isScrollToTopBtnVisible = false.obs;

  void clickOnTabBarOption(int index) {
    selectedTabBar.value = index;
  }

  @override
  void onClose() {
    tabBarController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(() {
      selectedTabBar.value = tabBarController.index;
    });
  }

  //================ Handle refresh ================\\

  Future<void> onRefresh() async {
    setLoading(true);

    await Future.delayed(const Duration(seconds: 2));

    setLoading(false);
  }

  //================ Scroll to Top =================//
  void scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }

  //================ Scroll Listener =================//

  void _scrollListener() {
    //========= Show action button ========//
    if (scrollController.position.pixels >= 150) {
      isScrollToTopBtnVisible.value = true;
    }
    //========= Hide action button ========//
    else if (scrollController.position.pixels < 150) {
      isScrollToTopBtnVisible.value = false;
    }
  }
}
