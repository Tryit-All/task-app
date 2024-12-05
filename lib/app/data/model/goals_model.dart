import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TargetItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final RxDouble progress;
  final TargetItemType subtitleType;

  TargetItem({
    required this.title,
    this.subtitle,
    required this.icon,
    double initialProgress = 0.0,
    required this.subtitleType,
  }) : progress = initialProgress.obs;
}

enum TargetItemType {
  measurementInterval,
  finishedOrUnfinished,
  targetMoney,
}

class HistoryItem {
  final String title;
  final bool isCompleted;
  final DateTime date;

  HistoryItem({
    required this.title,
    required this.isCompleted,
    required this.date,
  });
}
