import 'dart:async';

import 'package:bookmyparkinglot/screens/confirm.dart';
import 'package:bookmyparkinglot/screens/tickectsBooked.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/backg.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/screens/ticket.dart';
import 'package:bookmyparkinglot/utilities/setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/loading.dart';
import 'providers/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'screens/showticket.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Workmanager().initialize(
    callbackDispatcher,
  );
  Workmanager().registerPeriodicTask(
    "update",
    "simplePeriodicTask",
    frequency: const Duration(minutes: 2),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().initAuth();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 300), (timer) async {
      bool result = await checkTowed();
      int help = await checkHelp();
      if (help == 1) {
        showNotification(
          FlutterLocalNotificationsPlugin(),
          "Help!!!!",
          "Please remove your vehicle, Mine is stuck!",
          "Please remove your vehicle, Mine is stuck!",
        );
      } else if (help == 2) {
        showNotification(
          FlutterLocalNotificationsPlugin(),
          "Help!!!!",
          "Please remove your vehicle, I need to go urgently!",
          "Please remove your vehicle, I need to go urgently!",
        );
      }
      if (await result) {
        showNotification(
          FlutterLocalNotificationsPlugin(),
          "Alert!!!!",
          "Your car has been Towed!",
          "Your car has been Towed!",
        );
      } // Show the notification
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      // home: const ShowTicket(),
      home: context.watch<AuthProvider>().loading
          ? const Loading()
          : (context.watch<AuthProvider>().isLoggedin
              ? const MyHomePage()
              : const Login()),
    );
  }
}
