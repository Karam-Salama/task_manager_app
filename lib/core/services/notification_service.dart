import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initializeNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/launcher_icon',
      [
        NotificationChannel(
          channelGroupKey: 'todo_channel_group',
          channelKey: 'todo_channel',
          channelName: 'Todo notifications',
          channelDescription: 'Notification channel for Todo app',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          playSound: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'todo_channel_group',
          channelGroupName: 'Todo group',
        )
      ],
    );
  }

  static Future<void> scheduleTodoNotification({
    required int id,
    required String title,
    required String description,
    required DateTime scheduledTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'todo_channel',
        title: title,
        body: description,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(
        date: scheduledTime,
        allowWhileIdle: true,
      ),
    );
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }
}
