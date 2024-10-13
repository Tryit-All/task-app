import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectTask {
  final String name;
  final Rx<DateTime> startDate;
  final Rx<DateTime> endDate;
  final Color color;
  final RxDouble progress;

  ProjectTask({
    required this.name,
    required DateTime startDate,
    required DateTime endDate,
    required this.color,
    double initialProgress = 0.0,
  })  : startDate = startDate.obs,
        endDate = endDate.obs,
        progress = initialProgress.obs;
}
