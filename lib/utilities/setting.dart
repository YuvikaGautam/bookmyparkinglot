import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/providers/login.dart';
import 'package:bookmyparkinglot/screens/vehicleProfile.dart';
import 'package:bookmyparkinglot/screens/vehicleProfilee.dart';
import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Settings',
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
                    children: [
                      const SizedBox(height: 25),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: grey,
                              child: const Icon(Icons.person,
                                  size: 75,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Bug Smashers',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.verified, color: Colors.green)
                          ]),
                      const SizedBox(height: 16),
                      const SizedBox(height: 25),
                      ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Edit Profile'),
                          onTap: () {}),
                      const Divider(),
                      // ListTile(
                      //     leading: const Icon(Icons.car_rental),
                      //     title: const Text('Vehicle Profile'),
                      //     onTap: () {
                      //       Navigator.push(context,
                      //           MaterialPageRoute(builder: (context) => VehicleProliles()));
                      //     }),
                      //     const Divider(),
                      ListTile(
                          leading: const Icon(Icons.payment),
                          title: const Text('Payments'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('Notifications'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.help),
                          title: const Text('Help and Support'),
                          onTap: () {}),
                      const Divider(),
                      ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            logout(context);
                          }),
                    ],
                  )
        ));
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await context.read<AuthProvider>().logout();
    SnackBar snackBar = const SnackBar(
      content: Text("Logged out successfully"),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }
}
