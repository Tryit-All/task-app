import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/utils/action_button.dart';
import 'package:task_app/app/data/utils/date_field.dart';
import 'package:task_app/app/data/utils/time_field.dart';
import 'package:task_app/app/modules/detail_reminder/views/detail_reminder_view.dart';

import '../controllers/reminder_controller.dart';

class ReminderView extends GetView<ReminderController> {
  ReminderView({Key? key}) : super(key: key);

  final ReminderController controller = Get.put(ReminderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => DetailReminderView(
                  payload: '',
                )),
            icon: const Icon(Icons.library_books_rounded),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Title"),
                  TextField(
                    controller: controller.textEditingController,
                    maxLength: controller.maxTitleLength,
                    decoration: InputDecoration(
                      counterText: "",
                      suffix: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.grey[200],
                        ),
                        child: Text(
                            "${controller.textEditingController.text.length} / ${controller.maxTitleLength}"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Obx(() => CupertinoSlidingSegmentedControl<int>(
                        onValueChanged: controller.updateSegmentedControl,
                        groupValue: controller.segmentedControlGroupValue.value,
                        padding: const EdgeInsets.all(4.0),
                        children: const <int, Widget>{
                          0: Text("One time"),
                          1: Text("Daily"),
                          2: Text("Weekly")
                        },
                      )),
                  const SizedBox(height: 24.0),
                  const Text("Date & Time"),
                  const SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: controller.selectEventDate,
                    child: Obx(() => DateField(
                          eventDate: controller.eventDate.value,
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: controller.selectEventTime,
                    child: Obx(() => TimeField(
                          eventTime: controller.eventTime.value,
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  ActionButtons(
                    onCreate: controller.onCreate,
                    onCancel: controller.resetForm,
                  ),
                  const SizedBox(height: 12.0),
                  GestureDetector(
                    onTap: controller.cancelAllNotifications,
                    child: _buildCancelAllButton(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelAllButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.indigo[100],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "Cancel all the reminders",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Icon(Icons.clear),
        ],
      ),
    );
  }
}
