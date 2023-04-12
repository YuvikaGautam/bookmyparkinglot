import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/screens/home.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:bookmyparkinglot/utilities/button.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowTicket extends StatefulWidget {
  const ShowTicket({super.key});

  @override
  State<ShowTicket> createState() => _ShowTicketState();
}

class _ShowTicketState extends State<ShowTicket> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final Size size = MediaQuery.of(context).size;
    const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
    bool activeTicket = false;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getTicket(authProvider.userId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Booking Confirmed",
                        style: TextStyle(
                            fontSize: size.width * h1Size,
                            fontWeight: h1Weight,
                            color: bluecolor),
                      ),
                      SizedBox(height: size.width * (40 / idealDevWd)),
                      SizedBox(height: size.width * (35 / idealDevWd)),
                      Text(
                        "Booking ID: " + snapshot.data!['ticketId'].toString(),
                        // "Booking ID: $bookingId",
                        style: TextStyle(
                          fontSize: size.width * bdTx3Size,
                          fontWeight: bdTx1Weight,
                        ),
                      ),
                      QrImage(
                        // data: encoded,
                        data: snapshot.data!['ticketId'].toString(),
                        version: QrVersions.auto,
                        size: 200,
                        gapless: false,
                      ),
                      SizedBox(height: size.width * (17 / idealDevWd)),
                      SizedBox(height: size.width * (30 / idealDevWd)),
                      Text('Scan the QR code to enter the parking lot',
                          style: TextStyle(
                            fontSize: size.width * bdTx1Size,
                            fontWeight: bdTx1Weight,
                          )),
                      SizedBox(height: size.width * (30 / idealDevWd)),
                      // Text(
                      //     'Starting Time: ${DateTime.parse(snapshot.data!["bookingtime"]).day}/${DateTime.parse(snapshot.data!["bookingtime"]).month}/${DateTime.parse(snapshot.data!["bookingtime"]).year} ${DateTime.parse(snapshot.data!["bookingtime"]).hour}:${DateTime.parse(snapshot.data!["bookingtime"]).minute}',
                      //     style: TextStyle(
                      //       fontSize: size.width * bdTx1Size,
                      //       fontWeight: bdTx1Weight,
                      //     )),
                      // SizedBox(height: size.width * (30 / idealDevWd)),
                      // Visibility(
                      //   visible: snapshot.data!['checkinTime'] != null,
                      //   child: Text(
                      //       'Check In Time: ${DateTime.parse(snapshot.data!["checkinTime"]).day}/${DateTime.parse(snapshot.data!["checkinTime"]).month}/${DateTime.parse(snapshot.data!["checkinTime"]).year} ${DateTime.parse(snapshot.data!["bookingtime"]).hour}:${DateTime.parse(snapshot.data!["checkinTime"]).minute}',
                      //       style: TextStyle(
                      //         fontSize: size.width * bdTx1Size,
                      //         fontWeight: bdTx1Weight,
                      //       )),
                      // ),
                      SizedBox(height: size.width * (30 / idealDevWd)),
                      CustomButton(
                        text: 'Cancel Booking',
                        onPressed: () async {
                          // await updateParkingLot();

                          if (snapshot.data!['activeStatus']) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('You have an active ticket')));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Booking Cancelled')));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage()));
                          }
                        },
                      )
                    ],
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
