// import 'package:bookmyparkinglot/providers/auth.dart';
// import 'package:bookmyparkinglot/servers/api.dart';
// import 'package:bookmyparkinglot/utilities/appBar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ParkingTicketScreen extends StatefulWidget {
//   String ticketId;

//   ParkingTicketScreen(this.ticketId, {super.key});
//   @override
//   _ParkingTicketScreenState createState() => _ParkingTicketScreenState();
// }

// class _ParkingTicketScreenState extends State<ParkingTicketScreen> {
//   Future<Map<String, dynamic>>? _ticketData;

//   @override
//   void initState() {
//     super.initState();
//     // final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     // _ticketData = fetchTicketData(authProvider.userId);
//   }

//   // Future<Map<String, dynamic>> _fetchTicketData() async {
//   //   final response = await http.get(Uri.parse('https://yourapi.com/ticket'));
//   //   if (response.statusCode == 200) {
//   //     final decoded = json.decode(response.body);
//   //     return decoded;
//   //   } else {
//   //     throw Exception('Failed to load ticket data');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//         final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     return Scaffold(
//         appBar: CustomAppBar(title: 'Ticket Details'),
//         // body: Center(
//         //   child: Column(
//         //     mainAxisAlignment: MainAxisAlignment.center,
//         //     children: [
//         //       QrImage(
//         //         data: widget.ticketId,
//         //         version: QrVersions.auto,
//         //         size: 200.0,
//         //       ),
//         //       SizedBox(height: 20.0),
//         //       Text(
//         //         'Parking Slot: 1',
//         //         style: TextStyle(fontSize: 20.0),
//         //       ),
//         //       SizedBox(height: 10.0),
//         //       Text(
//         //         'Check-in Time: 10pm',
//         //         style: TextStyle(fontSize: 20.0),
//         //       ),
//         //     ],
//         //   ),
//         // )
//         body: FutureBuilder<Map<String, dynamic>>(
//           future: fetchTicketData(authProvider.userId),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('${snapshot.error}'));
//             } else {
//               final ticketData = snapshot.data;
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // QrImage(
//                   //   data: ticketData['ticket_id'],
//                   //   version: QrVersions.auto,
//                   //   size: 200.0,
//                   // ),
//                   // SizedBox(height: 20.0),
//                   Text(
//                     'Tickect ID: '+ ticketData["ticket_id"],
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     'Check-in Time: ${ticketData['check_in_time']??widget.ticketId}',
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//         );
//   }
// }
