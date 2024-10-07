import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController

  final count = 0.obs;
  var currentPage = 0.obs;
  late PageController pageController;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Get.to(LoginView());
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
}
