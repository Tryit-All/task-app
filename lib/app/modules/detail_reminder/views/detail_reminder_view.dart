import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_reminder_controller.dart';

class DetailReminderView extends GetView<DetailReminderController> {
  DetailReminderView({
    Key? key,
    this.payload,
  }) : super(key: key);

  final String? payload;

  final DetailReminderController controller =
      Get.put(DetailReminderController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadReminderFromPayload(payload);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Reminder"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => controller.reminder.value != null
                ? _buildNotifiedReminderCard()
                : _buildEmptyState()),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        "No reminders yet!",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildNotifiedReminderCard() {
    final reminder = controller.reminder.value!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(
              Icons.alarm,
              size: 60.0,
            ),
            const SizedBox(height: 12.0),
            const Text(
              "Your reminder for",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              reminder.title ?? '',
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              reminder.eventDate ?? '',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: 8.0),
                Text(
                  reminder.eventTime ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
