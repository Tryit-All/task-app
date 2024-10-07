import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final TextEditingController emailAddressTextController =
      TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController namaTextController = TextEditingController();
  final FocusNode emailAddressFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode namaTextFocusNode = FocusNode();
  bool passwordVisibility = false;
  final RxBool obscureText = true.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void increment() => count.value++;
}
