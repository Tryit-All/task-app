import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/model/task_model_v2.dart';
import 'package:task_app/app/data/utils/notification_service.dart';
import 'package:task_app/app/data/utils/task_manager.dart';

class NewTaskController extends GetxController {
  final notificationService = Get.find<NotificationService>();
  //TODO: Implement NewTaskController

  final count = 0.obs;
  var selectedTime = '00:00'.obs;
  var selectedHour = (-1).obs;
  var selectedMinute = (-1).obs;
  var isSelectingHour = true.obs;
  var prioritas = 1.obs;
  var selectProritas = 0.obs;
  final isSelected = false.obs;

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final selectedDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();
    isSelected.value = false;
    selectedDate.value = DateTime.now();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    super.onClose();
  }

  // void increment() => count.value++;

  Future<void> createTask() async {
    if (!validateForm()) return;

    try {
      final task = TaskModelV2(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: taskTitleController.text,
        description: taskDescriptionController.text,
        date: selectedDate.value!,
        time: TimeOfDay(hour: selectedHour.value, minute: selectedMinute.value),
        priority: selectProritas.value,
        hasReminder: true,
      );

      // Create notification if time is selected
      if (selectedHour.value >= 0 && selectedMinute.value >= 0) {
        // final scheduledDate = DateTime(
        //   selectedDate.value!.year,
        //   selectedDate.value!.month,
        //   selectedDate.value!.day,
        //   selectedHour.value,
        //   selectedMinute.value,
        // );

        final payload = jsonEncode({
          'title': taskTitleController.text,
          "eventDate": DateFormat("EEEE, d MMM y").format(selectedDate.value!),
          "eventTime": selectedTime.value.toString(),
        });

        print(payload);

        await notificationService.showNotification(
          id: 0,
          title: taskTitleController.text,
          body: taskDescriptionController.text,
          payload: payload,
        );

        await notificationService.scheduleNotification(
          title: task.title,
          body: task.description.isEmpty ? 'Task reminder' : task.description,
          payload: payload,
          scheduledDate: selectedDate.value!.add(Duration(
              hours: selectedHour.value, minutes: selectedMinute.value)),
        );
      }

      // TODO: Save task to local storage or backend

      TaskManager().addTask(task);

      Get.back(result: task);
      Get.snackbar(
        'Success',
        'Task created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create task',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
    }
  }

  bool validateForm() {
    if (taskTitleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter task title',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
      return false;
    }
    if (selectedDate.value == null) {
      Get.snackbar(
        'Error',
        'Please select a date',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
      return false;
    }
    return true;
  }

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
