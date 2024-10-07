import 'package:get/get.dart';

class NewRecurringTaskController extends GetxController {
  //TODO: Implement NewRecurringTaskController

  final isSelected = false.obs;
  final count = 0.obs;
  var prioritas = 1.obs;
  var selectProritas = 0.obs;
  var selectedValue = 0.obs;
  var days = {
    "Senin": false.obs,
    "Selasa": false.obs,
    "Rabu": false.obs,
    "Kamis": false.obs,
    "Jumat": false.obs,
    "Sabtu": false.obs,
    "Minggu": false.obs,
  }.obs;
  var isSwitchOn = false.obs;
  var powerOn = false.obs;

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

  void increment() {
    prioritas.value++;
  }

  void decrement() {
    if (prioritas.value > 1) {
      prioritas.value--;
    }
  }

  void updatePrioritas() {
    selectProritas.value = prioritas.value;
  }

  void setSelectedValue(int value) {
    selectedValue.value = value;
  }

  void toggleDay(String day) {
    days[day]?.value = !(days[day]?.value ?? false);
  }

  void toggleSwitch() {
    if (isSwitchOn.value) {
      Get.snackbar(
        'Mode Otomatis',
        'Tidak dapat mengubah switch secara manual saat mode otomatis aktif.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    } else {
      powerOn.value = !powerOn.value;
      // onTap();
    }
  }
}
