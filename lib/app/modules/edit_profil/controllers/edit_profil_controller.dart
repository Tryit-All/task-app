import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilController extends GetxController {
  //TODO: Implement EditProfilController

  final count = 0.obs;
  final TextEditingController namaTextController = TextEditingController();
  final TextEditingController namaPenggunaTextController =
      TextEditingController();
  final TextEditingController noTeleponTextController = TextEditingController();
  final TextEditingController emailPenggunaTextController =
      TextEditingController();
  final FocusNode noTeleponFocusNode = FocusNode();
  final FocusNode emailPenggunaFocusNode = FocusNode();
  final FocusNode namaFocusNode = FocusNode();
  final FocusNode namaPenggunaFocusNode = FocusNode();
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

  void increment() => count.value++;
}
