import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TaskModelV2 {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final int priority;
  final bool hasReminder;
  final NotificationData? notificationData;

  TaskModelV2({
    required this.id,
    required this.title,
    this.description = '',
    required this.date,
    required this.time,
    this.priority = 1,
    this.hasReminder = false,
    this.notificationData,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'time': {'hour': time.hour, 'minute': time.minute},
      'priority': priority,
      'hasReminder': hasReminder,
      'notificationData': notificationData?.toJson(),
    };
  }

  factory TaskModelV2.fromJson(Map<String, dynamic> json) {
    return TaskModelV2(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
      priority: json['priority'] ?? 1,
      hasReminder: json['hasReminder'] ?? false,
      notificationData: json['notificationData'] != null
          ? NotificationData.fromJson(json['notificationData'])
          : null,
    );
  }
}

class NotificationData {
  final String id;
  final String title;
  final String body;
  final String payload;
  final DateTime scheduledDate;
  final bool isRepeating;
  final DateTimeComponents? dateTimeComponents;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.scheduledDate,
    this.isRepeating = false,
    this.dateTimeComponents,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
      'scheduledDate': scheduledDate.toIso8601String(),
      'isRepeating': isRepeating,
      'dateTimeComponents': dateTimeComponents?.toString(),
    };
  }

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      payload: json['payload'],
      scheduledDate: DateTime.parse(json['scheduledDate']),
      isRepeating: json['isRepeating'] ?? false,
      dateTimeComponents: json['dateTimeComponents'] != null
          ? DateTimeComponents.values
              .firstWhere((e) => e.toString() == json['dateTimeComponents'])
          : null,
    );
  }
}
