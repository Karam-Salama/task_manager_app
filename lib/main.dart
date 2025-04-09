import 'package:flutter/material.dart';

import 'core/services/notification_service.dart';
import 'modules/app/todo_app.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotifications();
  // طلب إذن الإشعارات (لـ Android 13+)
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(const TodoApp());
}
