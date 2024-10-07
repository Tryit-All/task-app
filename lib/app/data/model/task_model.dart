import 'package:get/get.dart';

class Task {
  final String title;
  final String description;
  final String time;
  var isCompleted = false.obs;

  Task(this.title, this.description, this.time);
}

class TaskModel {
  final String title;
  final String description;
  var isTogled = false.obs;

  TaskModel(this.title, this.description);
}
