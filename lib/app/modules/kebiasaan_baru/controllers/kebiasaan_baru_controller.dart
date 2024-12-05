import 'package:get/get.dart';
import 'package:task_app/app/modules/calender_dialog/controllers/calender_dialog_controller.dart';
import 'package:task_app/app/modules/calender_dialog/views/calender_dialog_view.dart';
import 'package:task_app/app/modules/clock_dialog/controllers/clock_dialog_controller.dart';

class KebiasaanBaruController extends GetxController {
  //TODO: Implement KebiasaanBaruController

  final isSelected = false.obs;
  final count = 0.obs;
  var prioritas = 1.obs;
  var selectProritas = 0.obs;
  var selectedValue = 0.obs;
  var selectedValueEvaluation = 0.obs;
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
  final CalenderDialogController calenderDialogController =
      Get.put(CalenderDialogController());

  final ClockDialogController clockDialogController =
      Get.put(ClockDialogController());

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

  void setSelectedValueEvaluation(int value) {
    selectedValueEvaluation.value = value;
  }

  void toggleDay(String day) {
    days[day]?.value = !(days[day]?.value ?? false);
  }

  void toggleSwitch() {
    if (!isSwitchOn.value) {
      powerOn.value = !powerOn.value;
      print("object");
    }

    if (powerOn.value) {
      showCalendarDialog();
    }
  }
}
