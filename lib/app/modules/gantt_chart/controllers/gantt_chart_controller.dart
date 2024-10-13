import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/model/model_gantt_chart.dart';

class GanttChartController extends GetxController {
  //TODO: Implement GanttChartController
  final tasks = <ProjectTask>[].obs;
  final selectedTask = Rx<ProjectTask?>(null);
  final cellWidth = 80.0;
  final dayPeriod = RxInt(1);
  final RxInt selectedTaskIndex = RxInt(-1);
  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateTaskProgress(ProjectTask task, double newProgress) {
    task.progress.value = newProgress.clamp(0.0, 1.0);
  }

  void selectTask(int index) {
    if (index >= 0 && index < tasks.length) {
      selectedTaskIndex.value = index;
      selectedTask.value = tasks[index];
      updateDayPeriod();
    }
  }

  void updateDayPeriod() {
    if (selectedTask.value != null) {
      int taskDuration = selectedTask.value!.endDate.value
          .difference(selectedTask.value!.startDate.value)
          .inDays;
      dayPeriod.value = taskDuration > 0 ? taskDuration : 1;
    }
  }

  void updateTaskStartDate(ProjectTask task, double dx) {
    if (selectedTask.value == task) {
      double hoursDelta = (dx / cellWidth) * 24; // Convert to hours
      DateTime newStartDate = task.startDate.value
          .add(Duration(minutes: (hoursDelta * 60).round()));
      if (newStartDate.isBefore(task.endDate.value)) {
        task.startDate.value = newStartDate;
        updateDayPeriod();
      }
    }
  }

  void updateTaskEndDate(ProjectTask task, double dx) {
    if (selectedTask.value == task) {
      print("task: ${task.name}");
      double hoursDelta = (dx / cellWidth) * 24; // Convert to hours
      DateTime newEndDate =
          task.endDate.value.add(Duration(minutes: (hoursDelta * 60).round()));
      if (newEndDate.isAfter(task.startDate.value)) {
        task.endDate.value = newEndDate;
        updateDayPeriod();
      }
    }
  }

  void moveEntireTask(ProjectTask task, double dx) {
    if (selectedTask.value != task) return; // Only move the selected task

    double hoursDelta = (dx / cellWidth) * 24; // Convert to hours
    int minutesDelta = (hoursDelta * 60).round();

    // Calculate new dates without snapping
    DateTime newStartDate =
        task.startDate.value.add(Duration(minutes: minutesDelta));
    DateTime newEndDate =
        task.endDate.value.add(Duration(minutes: minutesDelta));

    // Ensure the task doesn't move outside the valid range
    DateTime earliestStart = getEarliestStartDate();
    DateTime latestEnd = getLatestEndDate();

    if (newStartDate.isBefore(earliestStart)) {
      int adjustMinutes = newStartDate.difference(earliestStart).inMinutes;
      newStartDate = earliestStart;
      newEndDate = newEndDate.add(Duration(minutes: -adjustMinutes));
    } else if (newEndDate.isAfter(latestEnd)) {
      int adjustMinutes = newEndDate.difference(latestEnd).inMinutes;
      newEndDate = latestEnd;
      newStartDate = newStartDate.add(Duration(minutes: -adjustMinutes));
    }

    // Update the task dates
    task.startDate.value = newStartDate;
    task.endDate.value = newEndDate;

    // Update the day period
    updateDayPeriod();
  }

  DateTime getEarliestStartDate() {
    return tasks.isEmpty
        ? DateTime.now()
        : tasks
            .map((t) => t.startDate.value)
            .reduce((a, b) => a.isBefore(b) ? a : b);
  }

  DateTime getLatestEndDate() {
    return tasks.isEmpty
        ? DateTime.now()
        : tasks
            .map((t) => t.endDate.value)
            .reduce((a, b) => a.isAfter(b) ? a : b);
  }

  void loadTasks() {
    tasks.clear();
    tasks.addAll([
      ProjectTask(
        name: 'Some Project',
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 10, 15),
        color: AppColors.trinaryColor,
        initialProgress: 0.11,
      ),
      ProjectTask(
        name: 'Idea',
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 10, 2),
        color: AppColors.trinaryColor,
        initialProgress: 0.29,
      ),
      ProjectTask(
        name: 'Research',
        startDate: DateTime(2024, 10, 2),
        endDate: DateTime(2024, 10, 4),
        color: AppColors.trinaryColor,
        initialProgress: 0.22,
      ),
      ProjectTask(
        name: 'Discussion with team',
        startDate: DateTime(2024, 10, 4),
        endDate: DateTime(2024, 10, 8),
        color: AppColors.trinaryColor,
        initialProgress: 0.35,
      ),
      ProjectTask(
        name: 'Developing',
        startDate: DateTime(2024, 10, 8),
        endDate: DateTime(2024, 10, 9),
        color: AppColors.trinaryColor,
        initialProgress: 0.10,
      ),
      ProjectTask(
        name: 'Review',
        startDate: DateTime(2024, 10, 8),
        endDate: DateTime(2024, 10, 10),
        color: AppColors.trinaryColor,
        initialProgress: 0.20,
      ),
    ]);
    if (tasks.isNotEmpty) {
      selectedTaskIndex.value = 0;
      selectedTask.value = tasks[0];
    }
  }
}
