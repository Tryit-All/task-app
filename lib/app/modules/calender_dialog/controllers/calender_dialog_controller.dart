import 'package:get/get.dart';

class CalenderDialogController extends GetxController {
  //TODO: Implement CalenderDialogController

  final count = 0.obs;
  final selectedDate = DateTime.now().obs;
  final currentMonth = DateTime.now().obs;
  final differenceInDays = 0.obs;

  @override
  void onInit() {
    super.onInit();
    calculateDifference();
    ever(selectedDate, (_) => calculateDifference());
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

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void nextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
      1,
    );
  }

  void previousMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month - 1,
      1,
    );
  }

  List<DateTime> getDaysInMonth() {
    final List<DateTime> days = [];
    final firstDay =
        DateTime(currentMonth.value.year, currentMonth.value.month, 1);
    final lastDay =
        DateTime(currentMonth.value.year, currentMonth.value.month + 1, 0);

    // Add empty slots for days before the first day of month
    final firstWeekday = firstDay.weekday;
    for (var i = 1; i < firstWeekday; i++) {
      days.add(firstDay.subtract(Duration(days: firstWeekday - i)));
    }

    // Add all days of the month
    for (var i = 0; i < lastDay.day; i++) {
      days.add(
          DateTime(currentMonth.value.year, currentMonth.value.month, i + 1));
    }

    return days;
  }

  void calculateDifference() {
    final now = DateTime.now();
    differenceInDays.value = selectedDate.value.difference(now).inDays;
  }
}
