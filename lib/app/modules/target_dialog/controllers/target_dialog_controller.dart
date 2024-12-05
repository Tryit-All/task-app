import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/target_dialog/views/target_dialog_view.dart';

class TargetDialogController extends GetxController {
  //TODO: Implement TargetDialogController

  final selectedType = TargetType.interval.obs;
  final nameController = TextEditingController();
  final startController = TextEditingController(text: '0');
  final targetController = TextEditingController();
  final currencyController = TextEditingController();
  final RxInt selectedTabIndex = 0.obs;
  final List<String> tabs = [
    'Berlangsung',
    'Selesai',
  ];

  void updateType(TargetType type) {
    selectedType.value = type;
  }

  void saveTarget() {
    // Handle saving logic here
    final result = {
      'name': nameController.text,
      'type': selectedType.value,
      'startValue': startController.text,
      'targetValue': targetController.text,
      'currencyValue': currencyController.text,
    };
    Get.back(result: result);
  }

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
    nameController.dispose();
    startController.dispose();
    targetController.dispose();
    currencyController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}

void showTargetDialog(String title) {
  Get.dialog(TargetDialogView(), arguments: {'title': title}).then((value) {
    if (value != null) {
      // Handle the result
      print('Dialog result: $value');
    }
  });
}

enum TargetType {
  interval,
  ongoing,
  currency,
}
