import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';

import '../controllers/clock_dialog_controller.dart';

class ClockDialogView extends GetView<ClockDialogController> {
  ClockDialogView({Key? key}) : super(key: key);

  final controller = Get.put(ClockDialogController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pengingat baru',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildTimeSelector(),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 6),
            _buildTypeSelector(),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
            ),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: _buildScheduleSelector()),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Obx(() {
      final time = controller.selectedTime.value;
      final timeString =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

      return GestureDetector(
        onTap: () async {
          final TimeOfDay? picked = await showTimePicker(
            context: Get.context!,
            initialTime: TimeOfDay.fromDateTime(time),
          );
          if (picked != null) {
            controller.updateTime(
              DateTime(
                  time.year, time.month, time.day, picked.hour, picked.minute),
            );
          }
        },
        child: Text(
          textAlign: TextAlign.center,
          timeString,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }

  Widget _buildTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipe',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTypeOption(
              'Jangan ingatkan',
              Icons.notifications_off_outlined,
              ReminderType.none,
            ),
            _buildTypeOption(
              'Notifikasi',
              Icons.notifications_outlined,
              ReminderType.notification,
            ),
            _buildTypeOption(
              'Alarm',
              Icons.alarm_outlined,
              ReminderType.alarm,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeOption(String label, IconData icon, ReminderType type) {
    return Obx(() {
      final isSelected = controller.selectedType.value == type;
      return InkWell(
        onTap: () => controller.updateType(type),
        child: Container(
          width: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.trinaryColor : Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primaryColor : Colors.grey[600],
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 8,
                  color: isSelected ? AppColors.primaryColor : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildScheduleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jadwal',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        _buildRadioOption('Selalu aktif', ScheduleType.alwaysActive),
        _buildRadioOption(
            'Hari tertentu dalam seminggu', ScheduleType.specificDays),
        _buildRadioOption('Hari sebelumnya', ScheduleType.previousDay),
      ],
    );
  }

  Widget _buildRadioOption(String label, ScheduleType type) {
    return Obx(() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 1.0,
            child: Radio<ScheduleType>(
              value: type,
              groupValue: controller.scheduleType.value,
              onChanged: (value) => controller.updateSchedule(value!),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle save logic here
            Get.back(result: {
              'time': controller.selectedTime.value,
              'type': controller.selectedType.value,
              'schedule': controller.scheduleType.value,
            });
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

void showClockDialog() {
  Get.dialog(ClockDialogView()).then((value) {
    if (value != null) {
      // Handle the result
      print('Selected time: ${value['time']}');
      print('Selected type: ${value['type']}');
      print('Selected schedule: ${value['schedule']}');
    }
  });
}
