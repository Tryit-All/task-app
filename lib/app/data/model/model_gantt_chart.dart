import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectTask {
  final String name;
  final Rx<DateTime> startDate;
  final Rx<DateTime> endDate;
  final Color color;
  final RxDouble progress;
  final RxList<ProjectTask> subtasks;
  final ProjectTask? parent;
  final bool isParent;
  final RxBool isExpanded;

  ProjectTask({
    required this.name,
    required DateTime startDate,
    required DateTime endDate,
    required this.color,
    double initialProgress = 0.0,
    List<ProjectTask>? subtasks,
    this.parent,
    this.isParent = false,
  })  : startDate = startDate.obs,
        endDate = endDate.obs,
        progress = initialProgress.obs,
        subtasks = (subtasks ?? []).obs,
        isExpanded = false.obs;

  // Method to calculate overall progress based on subtasks
  double calculateOverallProgress() {
    if (subtasks.isEmpty) return progress.value;

    double totalProgress =
        subtasks.fold(0.0, (sum, task) => sum + task.progress.value);
    return totalProgress / subtasks.length;
  }

  // Method to update parent dates based on subtasks
  void updateDatesFromSubtasks() {
    if (subtasks.isEmpty) return;

    DateTime earliestStart = subtasks
        .map((task) => task.startDate.value)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    DateTime latestEnd = subtasks
        .map((task) => task.endDate.value)
        .reduce((a, b) => a.isAfter(b) ? a : b);

    startDate.value = earliestStart;
    endDate.value = latestEnd;
  }
}

enum GanttViewMode { daily, weekly, monthly }
