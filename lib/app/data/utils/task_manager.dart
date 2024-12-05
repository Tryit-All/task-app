import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/app/data/model/task_model_v2.dart';

class TaskManager {
  final RxList<TaskModelV2> tasks = <TaskModelV2>[].obs;

  static final TaskManager _instance = TaskManager._internal();
  factory TaskManager() => _instance;
  TaskManager._internal();

  // Add task and sort by priority and date/time
  void addTask(TaskModelV2 task) {
    tasks.add(task);
    _sortTasks();
  }

  // Sort tasks by priority (highest first), then by date and time
  void _sortTasks() {
    tasks.sort((a, b) {
      // First sort by priority (highest first)
      final priorityComparison = b.priority.compareTo(a.priority);
      if (priorityComparison != 0) return priorityComparison;

      // Then sort by date
      final dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) return dateComparison;

      // Finally sort by time
      return _compareTimeOfDay(a.time, b.time);
    });
  }

  int _compareTimeOfDay(TimeOfDay a, TimeOfDay b) {
    final aMinutes = a.hour * 60 + a.minute;
    final bMinutes = b.hour * 60 + b.minute;
    return aMinutes.compareTo(bMinutes);
  }

  void removeTask(String taskId) {
    tasks.removeWhere((task) => task.id == taskId);
    _saveTasks();
  }

  List<TaskModelV2> getAllTasks() => tasks.toList();

  List<TaskModelV2> getTasksForDate(DateTime date) {
    return tasks
        .where((task) =>
            task.date.year == date.year &&
            task.date.month == date.month &&
            task.date.day == date.day)
        .toList();
  }

  Future<void> _saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = tasks.map((task) => task.toJson()).toList();
      await prefs.setString('tasks', jsonEncode(tasksJson));
    } catch (e) {
      print('Error saving tasks: $e');
    }
  }

  Future<void> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksString = prefs.getString('tasks');
      if (tasksString != null) {
        final tasksJson = jsonDecode(tasksString) as List;
        tasks.value =
            tasksJson.map((json) => TaskModelV2.fromJson(json)).toList();
        _sortTasks();
      }
    } catch (e) {
      print('Error loading tasks: $e');
    }
  }
}
