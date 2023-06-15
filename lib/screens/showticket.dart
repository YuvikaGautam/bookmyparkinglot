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
  const ShowTicket({Key? key}) : super(key: key);

  @override
  State<ShowTicket> createState() => _ShowTicketState();
}

class _ShowTicketState extends State<ShowTicket> {
  Future<Map>? _getTicket;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _getTicket = getTicket(authProvider.userId);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: _getTicket,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  final ticketDetails = snapshot.data!;
                  final activeStatus = snapshot.data!['activeStatus'];
                  print(ticketDetails);
                  return Column(
                    children: [
                      Text(
                        "Booking Confirmed",
                        style: TextStyle(
                          fontSize: size.width * h1Size,
                          fontWeight: h1Weight,
                          color: bluecolor,
                        ),
                      ),
                      SizedBox(height: size.width * (40 / idealDevWd)),
                      SizedBox(height: size.width * (35 / idealDevWd)),
                      Text(
                        "Booking ID: ${ticketDetails['ticketIdCheckout'] ?? ticketDetails['ticketIdCheckin']}",
                        style: TextStyle(
                          fontSize: size.width * bdTx3Size,
                          fontWeight: bdTx1Weight,
                        ),
                      ),
                      QrImageView(
                        data: ticketDetails['ticketIdCheckout'] ??
                            ticketDetails['ticketIdCheckin'],
                        version: QrVersions.auto,
                        size: 250,
                        gapless: false,
                      ),
                      SizedBox(height: size.width * (17 / idealDevWd)),
                      SizedBox(height: size.width * (30 / idealDevWd)),
                      Text(
                        'Scan the QR code to the parking lot',
                        style: TextStyle(
                          fontSize: size.width * bdTx1Size,
                          fontWeight: bdTx1Weight,
                        ),
                      ),
                      SizedBox(height: size.width * (30 / idealDevWd)),
                      SizedBox(height: size.width * (30 / idealDevWd)),
                      CustomButton(
                        text: 'Cancel Booking',
                        onPressed: () async {
                          if (activeStatus) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'You have an Active Ticket and cannot Cancel Booking',
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Booking Cancelled')),
                            );
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(),
                            ),
                          );
                        },
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
