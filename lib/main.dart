import 'package:bookmyparkinglot/screens/confirm.dart';
import 'package:bookmyparkinglot/screens/tickectsBooked.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/screens/ticket.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/loading.dart';
import 'providers/login.dart';


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
           backgroundColor: Colors.white,
          ),),
          // home: ConfirmationPage()
      home: context.watch<AuthProvider>().loading
          ? const Loading()
          : (context.watch<AuthProvider>().isLoggedin
              ? const MyHomePage()
              :  const Login()),
    );
  }
}

