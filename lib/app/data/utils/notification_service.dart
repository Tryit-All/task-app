import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/modules/detail_reminder/views/detail_reminder_view.dart';
import 'package:task_app/app/routes/app_pages.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class NotificationService extends GetxService {
  static NotificationService? _instance;
  static NotificationService get instance {
    _instance ??= Get.find<NotificationService>();
    return _instance!;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const channelId = "1";
  static const channelName = "thecodexhub";
  static const channelDesc =
      "This channel is responsible for all the local notifications";

  // Notification details
  NotificationDetails? _notificationDetails;
  bool _isInitialized = false;

  @override
  void onInit() {
    super.onInit();
    initNotification();
  }

  Future<void> initNotification() async {
    tz.initializeTimeZones();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        if (payload != null) {
          Get.to(() => DetailReminderView(payload: payload));
        }
      },
    );

    InitializationSettings settings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    _isInitialized = true;
    _initNotificationDetails();
  }

  void _initNotificationDetails() {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: channelDesc,
            playSound: true,
            priority: Priority.high,
            importance: Importance.high,
            icon: '@mipmap/ic_launcher',
            ongoing: true,
            autoCancel: false);

    final DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    _notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      if (_notificationDetails == null) {
        _initNotificationDetails();
      }

      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        _notificationDetails,
        payload: payload,
      );
    } catch (e) {
      printError(info: 'Show notification error: $e');
    }
  }

  Future<bool> scheduleNotification({
    required String title,
    required String body,
    required String payload,
    required DateTime scheduledDate,
  }) async {
    try {
      // Validate if the date is in the future
      if (scheduledDate.isBefore(DateTime.now())) {
        print('Error: Cannot schedule notification for past date');
        return false;
      }

      // Convert to TZDateTime
      final tz.Location local = tz.local;
      tz.TZDateTime scheduledTZDate = tz.TZDateTime.from(scheduledDate, local);

      // Add a minute buffer to ensure it's in the future
      if (scheduledTZDate.isBefore(tz.TZDateTime.now(local))) {
        scheduledTZDate =
            tz.TZDateTime.now(local).add(const Duration(minutes: 1));
      }

      // Create the notification details
      if (_notificationDetails == null) {
        _initNotificationDetails();
      }

      // Schedule the notification
      await flutterLocalNotificationsPlugin.zonedSchedule(
        DateTime.now().millisecond, // unique id
        title,
        body,
        scheduledTZDate,
        _notificationDetails!,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
        matchDateTimeComponents: getDateTimeComponents(scheduledDate),
      );

      print('Notification scheduled for: ${scheduledTZDate.toString()}');
      return true;
    } catch (e) {
      print('Error scheduling notification: $e');
      return false;
    }
  }

  DateTimeComponents? getDateTimeComponents(DateTime scheduledDate) {
    if (scheduledDate.hour == 0 && scheduledDate.minute == 0) {
      return DateTimeComponents.dayOfMonthAndTime;
    } else if (scheduledDate.hour == 0) {
      return DateTimeComponents.dayOfWeekAndTime;
    } else {
      return DateTimeComponents.time;
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      await flutterLocalNotificationsPlugin.cancel(id);
    } catch (e) {
      printError(info: 'Cancel notification error: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      printError(info: 'Cancel all notifications error: $e');
    }
  }

  void _onSelectNotification(NotificationResponse response) {
    if (response.payload != null) {
      print("Notification response: ${response.payload}");
      Get.to(() => DetailReminderView(payload: response.payload!));
    }
  }
}
