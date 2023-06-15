import 'package:bookmyparkinglot/servers/api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    bool apiResponse = await checkTowed();
    int help = await checkHelp();
    if (apiResponse) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

      await showNotification(
        flutterLocalNotificationsPlugin,
        "Alert!!!!",
        "Your car has been Towed!",
        "Your car has been Towed!",
      );
    }
if (help == 1) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

      await showNotification(
          FlutterLocalNotificationsPlugin(),
          "Help!!!!",
          "Please remove your vehicle, Mine is stuck!",
          "Please remove your vehicle, Mine is stuck!",
        );
    }if (help == 2) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ),
      );

      await showNotification(
          FlutterLocalNotificationsPlugin(),
          "Help!!!!",
          "Please remove your vehicle, I need to go urgently!",
          "Please remove your vehicle, I need to go urgently!",
        );
    }
    return Future.value(true);
  });
}



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
