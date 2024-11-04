import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/utils/custom_day_picker.dart';
import 'package:task_app/app/data/utils/notification_service.dart';

class ReminderController extends GetxController {
  //TODO: Implement ReminderController

  final count = 0.obs;

  final NotificationService notificationService = NotificationService.instance;

  final NotificationService _notificationService =
      Get.find<NotificationService>();

  final maxTitleLength = 60;
  final textEditingController = TextEditingController(text: "Business meeting");

  final segmentedControlGroupValue = 0.obs;
  final currentDate = DateTime.now().obs;
  final eventDate = Rxn<DateTime>();
  final currentTime = TimeOfDay.now().obs;
  final eventTime = Rxn<TimeOfDay>();

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
    textEditingController.dispose();
  }

  // Future<bool> scheduleReminder({
  //   required String title,
  //   required DateTime reminderDateTime,
  // }) async {
  //   return await NotificationService.instance.scheduleNotification(
  //     title: title,
  //     body: 'Reminder: $title',
  //     scheduledDate: reminderDateTime,
  //   );
  // }

  Future<void> onCreate() async {
    if (!validateForm()) return;

    print(
        "${textEditingController.text} - ${DateFormat("EEEE, d MMM y").format(eventDate.value!)} - ${eventTime.value!.format(Get.context!)}");

    try {
      final payload = jsonEncode({
        "title": textEditingController.text,
        "eventDate": DateFormat("EEEE, d MMM y").format(eventDate.value!),
        "eventTime": eventTime.value!.format(Get.context!),
      });

      await notificationService.showNotification(
        id: 0,
        title: textEditingController.text,
        body: "A new event has been created.",
        payload: payload,
      );

      // await scheduleReminder(
      //   title: textEditingController.text,
      //   reminderDateTime: eventDate.value!.add(Duration(
      //       hours: eventTime.value!.hour, minutes: eventTime.value!.minute)),
      // );

      await notificationService.scheduleNotification(
        title: textEditingController.value.text,
        body: 'Reminder: ${textEditingController.text}',
        payload: payload,
        scheduledDate: eventDate.value!.add(Duration(
            hours: eventTime.value!.hour, minutes: eventTime.value!.minute)),
      );

      resetForm();
      Get.snackbar(
        'Success',
        'Reminder created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create reminder',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
    }
  }

  bool validateForm() {
    if (eventDate.value == null || eventTime.value == null) {
      Get.snackbar(
        'Error',
        'Please select both date and time',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
      );
      return false;
    }
    return true;
  }

  Future<void> cancelAllNotifications() async {
    await notificationService.cancelAllNotifications();
    Get.snackbar(
      'Success',
      'All notifications cancelled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void resetForm() {
    segmentedControlGroupValue.value = 0;
    eventDate.value = null;
    eventTime.value = null;
  }

  void updateSegmentedControl(int? value) {
    if (value == 1) eventDate.value = null;
    segmentedControlGroupValue.value = value!;
  }

  DateTimeComponents? getDateTimeComponents() {
    if (segmentedControlGroupValue.value == 1) {
      return DateTimeComponents.time;
    } else if (segmentedControlGroupValue.value == 2) {
      return DateTimeComponents.dayOfWeekAndTime;
    }
    return null;
  }

  Future<void> selectEventDate() async {
    final today = DateTime(
      currentDate.value.year,
      currentDate.value.month,
      currentDate.value.day,
    );

    if (segmentedControlGroupValue.value == 0) {
      final date = await showDatePicker(
        context: Get.context!,
        initialDate: today,
        firstDate: today,
        lastDate: DateTime(currentDate.value.year + 10),
      );
      if (date != null) {
        eventDate.value = date;
      }
    } else if (segmentedControlGroupValue.value == 1) {
      eventDate.value = today;
    } else if (segmentedControlGroupValue.value == 2) {
      CustomDayPicker(
        onDaySelect: (val) {
          eventDate.value = today.add(
            Duration(days: (val - today.weekday + 1) % DateTime.daysPerWeek),
          );
        },
      ).show(Get.context!);
    }
  }

  Future<void> selectEventTime() async {
    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(
        hour: currentTime.value.hour,
        minute: currentTime.value.minute + 1,
      ),
    );
    if (time != null) {
      eventTime.value = time;
    }
  }

  void increment() => count.value++;
}
