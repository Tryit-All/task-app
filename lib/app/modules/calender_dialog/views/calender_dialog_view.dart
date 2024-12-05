import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/app/data/colors.dart';
import '../controllers/calender_dialog_controller.dart';

class CalenderDialogView extends GetView<CalenderDialogController> {
  const CalenderDialogView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            SizedBox(height: 16),
            _buildWeekdayHeader(),
            _buildCalendarGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() {
      final monthYear =
          DateFormat('MMMM, yyyy').format(controller.currentMonth.value);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_left_rounded,
              color: AppColors.primaryColor,
            ),
            onPressed: controller.previousMonth,
          ),
          Text(
            monthYear,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          IconButton(
            icon: Transform(
              alignment: Alignment.center,
              transform:
                  Matrix4.rotationY(3.14159), // Membalik ikon secara horizontal
              child: Icon(
                Icons.arrow_left_rounded,
                color: AppColors.primaryColor,
              ),
            ),
            onPressed: controller.nextMonth,
          ),
        ],
      );
    });
  }

  Widget _buildWeekdayHeader() {
    final weekdays = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map((day) => Container(
                width: 40,
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    return Obx(() {
      final days = controller.getDaysInMonth();
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          return _buildDayCell(day);
        },
      );
    });
  }

  Widget _buildDayCell(DateTime day) {
    return Obx(() {
      final isSelected = day.isAtSameMomentAs(controller.selectedDate.value);
      final isCurrentMonth = day.month == controller.currentMonth.value.month;

      return InkWell(
        onTap: () {
          controller.updateSelectedDate(day);
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: !isCurrentMonth
                    ? Colors.grey[400]
                    : isSelected
                        ? Colors.white
                        : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    });
  }
}

void showCalendarDialog() {
  Get.dialog(CalenderDialogView());
}
