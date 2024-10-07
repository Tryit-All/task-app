import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTaskController extends GetxController {
  //TODO: Implement NewTaskController

  final count = 0.obs;
  var selectedTime = '00:00'.obs;
  var selectedHour = (-1).obs;
  var selectedMinute = (-1).obs;
  var isSelectingHour = true.obs;
  var prioritas = 1.obs;
  var selectProritas = 0.obs;

  final isSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    isSelected.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void increment() => count.value++;

  void updatePrioritas() {
    selectProritas.value = prioritas.value;
  }

  void updateTime() {
    selectedTime.value =
        '${selectedHour.value.toString().padLeft(2, '0')}:${selectedMinute.value.toString().padLeft(2, '0')}';
  }

  void updateSelectedHour(int hour) {
    selectedHour.value = hour;
    updateTime();
    isSelectingHour.value =
        false; // Pindah ke pemilihan menit setelah jam dipilih
  }

  void updateSelectedMinute(int minute) {
    selectedMinute.value = minute;
    updateTime();
  }

  void selectHour() {
    isSelectingHour.value = true; // Menyediakan pemilihan jam
  }

  void selectMinute() {
    isSelectingHour.value = false; // Menyediakan pemilihan menit
  }

  void increment() {
    prioritas.value++;
  }

  void decrement() {
    if (prioritas.value > 1) {
      prioritas.value--;
    }
  }
}
