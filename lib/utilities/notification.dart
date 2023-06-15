import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> showNotification(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  String title,
  String message,
  String payload,
) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',

    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    message,
    platformChannelSpecifics,
    payload: payload,
  );
}
