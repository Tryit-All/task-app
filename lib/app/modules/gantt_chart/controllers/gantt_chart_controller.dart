import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:task_app/app/data/colors.dart';
import 'package:task_app/app/data/model/model_gantt_chart.dart';

class GanttChartController extends GetxController {
  //TODO: Implement GanttChartController
  final tasks = <ProjectTask>[].obs;
  final selectedTask = Rx<ProjectTask?>(null);
  final cellWidth = 80.0.obs;
  final dayPeriod = RxInt(1);
  final RxInt selectedTaskIndex = RxInt(-1);
  final tooltipController = SuperTooltipController();

  final Rx<GanttViewMode> currentViewMode =
      Rx<GanttViewMode>(GanttViewMode.daily);

  final Rx<GanttViewMode> currentView2 = GanttViewMode.weekly.obs;

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
    tooltipController.dispose();
    super.onClose();
  }

  double get cellWidthNew {
    switch (currentViewMode.value) {
      case GanttViewMode.daily:
        return 100.0;
      case GanttViewMode.weekly:
        return 150.0;
      case GanttViewMode.monthly:
        return 600.0;
    }
  }

  double getTaskStartPositionText(double taskStart) {
    switch (cellWidthNew) {
      case 150.0:
        return (taskStart / 7) * cellWidthNew + 80;
      case 600.0:
        return (taskStart / 30) * cellWidthNew + 80;
      default:
        return taskStart * cellWidthNew;
    }
  }

  double getTaskStartPosition(double taskStart) {
    switch (cellWidthNew) {
      case 150.0:
        return (taskStart / 7) * cellWidthNew;
      case 600.0:
        return (taskStart / 30) * cellWidthNew;
      default:
        return taskStart * cellWidthNew;
    }
  }

  double getTaskWidth(double taskStart, double taskDuration) {
    switch (cellWidthNew) {
      case 150.0:
        return (taskDuration / 7) * cellWidthNew;
      case 600.0:
        return (taskDuration / 30) * cellWidthNew;
      default:
        return taskDuration * cellWidthNew;
    }
  }

  int getUnitsBetween(DateTime start, DateTime end) {
    switch (currentViewMode.value) {
      case GanttViewMode.daily:
        return end.difference(start).inDays + 1;
      case GanttViewMode.weekly:
        return ((end.difference(start).inDays) / 7).ceil();
      case GanttViewMode.monthly:
        return (end.year - start.year) * 12 + end.month - start.month + 1;
    }
  }

  // Get the start of the unit (day/week/month)
  DateTime getUnitStart(DateTime date) {
    switch (currentViewMode.value) {
      case GanttViewMode.daily:
        return DateTime(date.year, date.month, date.day);
      case GanttViewMode.weekly:
        // Get start of week (assuming Monday is first day)
        final diff = date.weekday - 1;
        return DateTime(date.year, date.month, date.day)
            .subtract(Duration(days: diff));
      case GanttViewMode.monthly:
        return DateTime(date.year, date.month, 1);
    }
  }

  // Get the end of the unit (day/week/month)
  DateTime getUnitEnd(DateTime date) {
    switch (currentViewMode.value) {
      case GanttViewMode.daily:
        return DateTime(date.year, date.month, date.day, 23, 59, 59);
      case GanttViewMode.weekly:
        final startOfWeek = getUnitStart(date);
        return startOfWeek
            .add(Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      case GanttViewMode.monthly:
        return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
    }
  }

  // Change view mode
  void changeViewMode(GanttViewMode mode) {
    currentViewMode.value = mode;
    update(); // Trigger UI update
  }

  // Modified getTaskPosition method
  double getTaskPosition(DateTime date, DateTime startDate) {
    switch (currentViewMode.value) {
      case GanttViewMode.daily:
        return date.difference(startDate).inDays.toDouble();
      case GanttViewMode.weekly:
        return date.difference(getUnitStart(startDate)).inDays / 7;
      case GanttViewMode.monthly:
        final months =
            (date.year - startDate.year) * 12 + date.month - startDate.month;
        return months.toDouble();
    }
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
      double hoursDelta = (dx / cellWidth.toDouble()) * 24; // Convert to hours
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
      double hoursDelta = (dx / cellWidth.toDouble()) * 24; // Convert to hours
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

    double hoursDelta = (dx / cellWidth.toDouble()) * 24; // Convert to hours
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

    // Create Project SafePath
    final safePathProject = ProjectTask(
      name: 'Project SafePath',
      startDate: DateTime(2024, 10, 1),
      endDate: DateTime(2024, 10, 15),
      color: AppColors.trinaryColor,
      initialProgress: 0.23,
      isParent: true,
    );

    final safePathSubtasks = [
      ProjectTask(
        name: 'Idea',
        startDate: DateTime(2024, 10, 1),
        endDate: DateTime(2024, 10, 2),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.29,
        parent: safePathProject,
      ),
      ProjectTask(
        name: 'Research',
        startDate: DateTime(2024, 10, 2),
        endDate: DateTime(2024, 10, 4),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.22,
        parent: safePathProject,
      ),
      ProjectTask(
        name: 'Discussion with team',
        startDate: DateTime(2024, 10, 4),
        endDate: DateTime(2024, 10, 8),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.35,
        parent: safePathProject,
      ),
      ProjectTask(
        name: 'Developing',
        startDate: DateTime(2024, 10, 8),
        endDate: DateTime(2024, 10, 9),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.10,
        parent: safePathProject,
      ),
      ProjectTask(
        name: 'Review',
        startDate: DateTime(2024, 10, 8),
        endDate: DateTime(2024, 10, 10),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.20,
        parent: safePathProject,
      ),
    ];

    // Create Project IOTMCC
    final iotmccProject = ProjectTask(
      name: 'Project IOTMCC',
      startDate: DateTime(2024, 10, 15),
      endDate: DateTime(2024, 11, 1),
      color: AppColors.trinaryColor,
      initialProgress: 0.0,
      isParent: true,
    );

    final iotmccSubtasks = [
      ProjectTask(
        name: 'Idea',
        startDate: DateTime(2024, 10, 15),
        endDate: DateTime(2024, 10, 16),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
      ProjectTask(
        name: 'Research',
        startDate: DateTime(2024, 10, 16),
        endDate: DateTime(2024, 10, 19),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
      ProjectTask(
        name: 'Discussion with team',
        startDate: DateTime(2024, 10, 19),
        endDate: DateTime(2024, 10, 22),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
      ProjectTask(
        name: 'Developing',
        startDate: DateTime(2024, 10, 22),
        endDate: DateTime(2024, 10, 28),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
      ProjectTask(
        name: 'Review',
        startDate: DateTime(2024, 10, 28),
        endDate: DateTime(2024, 10, 30),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
      ProjectTask(
        name: 'Release',
        startDate: DateTime(2024, 10, 30),
        endDate: DateTime(2024, 10, 31),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
      ProjectTask(
        name: 'Party Time',
        startDate: DateTime(2024, 10, 31),
        endDate: DateTime(2024, 11, 1),
        color: AppColors.trinaryColor.withOpacity(0.8),
        initialProgress: 0.0,
        parent: iotmccProject,
      ),
    ];

    // Add subtasks to parent projects
    safePathProject.subtasks.addAll(safePathSubtasks);
    iotmccProject.subtasks.addAll(iotmccSubtasks);

    // Add all tasks to the main list
    tasks.addAll([
      safePathProject,
      ...safePathSubtasks,
      iotmccProject,
      ...iotmccSubtasks,
    ]);

    if (tasks.isNotEmpty) {
      selectedTaskIndex.value = 0;
      selectedTask.value = tasks[0];
    }
  }
}
