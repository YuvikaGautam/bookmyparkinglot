import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/providers/login.dart';
import 'package:bookmyparkinglot/screens/booking.dart';
import 'package:bookmyparkinglot/screens/confirm.dart';
import 'package:bookmyparkinglot/screens/showticket.dart';
import 'package:bookmyparkinglot/screens/tickectsBooked.dart';
import 'package:bookmyparkinglot/screens/ticketnew.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:bookmyparkinglot/utilities/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ticket.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EdgeInsets cardMargin = EdgeInsets.symmetric(
        horizontal: 0, vertical: size.width * mainCdPadVert);
    final BorderRadius brRad = BorderRadius.circular(size.width * cdBorderRad);
    return Scaffold(
      appBar: CustomAppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * mainBdPadHoriz,
            // vertical: size.width * mainBdPadVert,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Book Parking Lot",
                style: TextStyle(
                  fontSize: size.width * h1Size,
                  fontWeight: h1Weight,
                ),
              ),
              Text(
                "Choose your Parking Lot",
                style: TextStyle(
                  fontSize: size.width * bdTx3Size,
                  fontWeight: bdTx1Weight,
                ),
              ),
              SizedBox(height: size.width * (17 / idealDevWd)),
              FutureBuilder(
                // future: courses(),
                future: GetParkingLots(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        ...(snapshot.data)!.map(
                          (data) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingPage(
                                    data['ownerId'],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 10,
                              shadowColor: const Color.fromRGBO(6, 7, 87, 0.12),
                              shape:
                                  RoundedRectangleBorder(borderRadius: brRad),
                              margin: cardMargin,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Image.asset(
                                      "assests/images/park.png",
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        size.width * mainCdPadVert),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              data["plotName"] ??
                                                  'Rahul Parking Wale',
                                              style: TextStyle(
                                                fontSize: size.width * h2Size,
                                                fontWeight: h2Weight,
                                              ),
                                            ),
                                            Icon(
                                              data['isVerified']
                                                  ? Icons.star
                                                  : Icons.close,
                                              color: data['isVerified']
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Address: " + data["paddress"],
                                          style: TextStyle(
                                            fontSize: size.width * subHdSize,
                                            fontWeight: bdTx3Weight,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              size.width * (10 / idealDevWd),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Two-Wheeler: ' +
                                                  data['bikeSpace'].toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    size.width * bdTx3Size,
                                                fontWeight: h2Weight,
                                              ),
                                            ),
                                            Text(
                                              'Four-Wheeler: ' +
                                                  data['carSpace'].toString(),
                                              style: TextStyle(
                                                fontSize:
                                                    size.width * bdTx3Size,
                                                fontWeight: h2Weight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      margin:
                          EdgeInsets.only(top: size.width * (50 / idealDevWd)),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        onRefresh: () async {
          setState(() {
            GetParkingLots();
            print("Refreshed");
          });
          await Future.delayed(const Duration(seconds: 2));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: bluecolor,
            ),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.book),
          //   label: 'Booking',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code,
              color: bluecolor,
            ),
            label: 'Active Tickets',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: grey,
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShowTicket()));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => BookingPage(),
            //   ),
            // );
          }
          // else if (index == 2) {
          //   // Navigator.push(
          //   //   context,
          //   //   MaterialPageRoute(
          //   //     builder: (context) => TicketPage(),
          //   //   ),
          //   // );
          // }
        },
      ),
    );
  }

  Widget parkingCard() {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          Image.asset(
            "assests/images/park.png",
            height: 200,
          ),
          Text("Parking")
        ],
      ),
    );
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
