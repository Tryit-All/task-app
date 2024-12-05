import 'package:get/get.dart';

class ClockDialogController extends GetxController {
  //TODO: Implement ClockDialogController

  final count = 0.obs;
  final selectedTime = DateTime.now().obs;
  final selectedType = ReminderType.none.obs;
  final scheduleType = ScheduleType.alwaysActive.obs;
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

  void updateTime(DateTime time) {
    selectedTime.value = time;
  }

  void updateType(ReminderType type) {
    selectedType.value = type;
  }

  void updateSchedule(ScheduleType type) {
    scheduleType.value = type;
  }

  void increment() => count.value++;
}

enum ReminderType { none, notification, alarm }

enum ScheduleType { alwaysActive, specificDays, previousDay }
