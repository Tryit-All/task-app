import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_app/app/data/model/reminder_model.dart';

class DetailReminderController extends GetxController {
  //TODO: Implement DetailReminderController

  final count = 0.obs;
  Rx<ReminderModel?> reminder = Rx<ReminderModel?>(null);

  void loadReminderFromPayload(String? payload) {
    if (payload == null || payload.isEmpty) {
      reminder.value = null;
      return;
    }

    try {
      final data = jsonDecode(payload);
      if (data is Map<String, dynamic>) {
        reminder.value = ReminderModel.fromJson(data);
      } else {
        print('Invalid JSON structure: $data');
        reminder.value = null;
      }
    } catch (e) {
      print('Error parsing JSON: $e');
      reminder.value = null;
    }
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
  }

  void increment() => count.value++;
}
