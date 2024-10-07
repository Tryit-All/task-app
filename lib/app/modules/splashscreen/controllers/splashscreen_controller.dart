import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    if (name == null) {
      _navigateToLogin();
    } else {
      _navigateToNavigation();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void _navigateToLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/onboarding');
    });
  }

  void _navigateToNavigation() async {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/navigation');
    });
  }
}
