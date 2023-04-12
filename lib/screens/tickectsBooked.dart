// import 'package:bookmyparkinglot/providers/auth.dart';
// import 'package:bookmyparkinglot/screens/ticketnew.dart';
// import 'package:bookmyparkinglot/servers/api.dart';
// import 'package:bookmyparkinglot/utilities/appBar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TicketsBooked extends StatefulWidget {
//   const TicketsBooked({super.key});

//   @override
//   State<TicketsBooked> createState() => _TicketsBookedState();
// }

// class _TicketsBookedState extends State<TicketsBooked> {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     return Scaffold(
//         appBar: CustomAppBar(title: 'Tickets Booked'),
//         body: SafeArea(
//             minimum: const EdgeInsets.symmetric(horizontal: 10),
//             child: SingleChildScrollView(
//                 child: FutureBuilder(
//               future: getallTickets(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                           onTap: () {
//                             //move to ticket details page
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => ParkingTicketScreen(
//                                         snapshot.data![index].ticketid)));
//                           },
//                           child: Card(
//                             child: ListTile(
//                               title: Text('Ticket ${snapshot.data![index].ticketid}'),
//                               // subtitle: Text('Ticket ${snapshot.data![index].}'),
//                               // trailing: Text('Ticket ${snapshot.data![index].ticketid}'),
//                             ),
//                           ));
//                     },
//                   );
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ))));
//   }
// }



// // Column(
// //               children: [
// //                 //create a listview.builder for 10 tickets and on click move to ticket details page
// //                 ListView.builder(
// //                   shrinkWrap: true,
// //                   itemCount: 10,
// //                   itemBuilder: (context, index) {
// //                     return GestureDetector(
// //                         onTap: () {
// //                           //move to ticket details page
// //                           Navigator.push(context,
// //                               MaterialPageRoute(builder: (context) => ParkingTicketScreen( ticketid)));
// //                         },
// //                         child: Card(
// //                       child: ListTile(
// //                         title: Text('Ticket $ticketid'),
// //                         subtitle: Text('Ticket $index'),
// //                         trailing: Text('Ticket $index'),
// //                       ),
// //                     ));
// //                   },
// //                 ),
// //               ],
// //             )