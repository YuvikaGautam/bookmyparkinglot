// import 'dart:convert';
// import 'package:bookmyparkinglot/providers/auth.dart';
// import 'package:bookmyparkinglot/screens/home.dart';
// import 'package:bookmyparkinglot/servers/api.dart';
// import 'package:bookmyparkinglot/utilities/appBar.dart';
// import 'package:bookmyparkinglot/utilities/button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:bookmyparkinglot/utilities/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:slide_countdown/slide_countdown.dart';

// class ConfirmationPage extends StatefulWidget {
//   ConfirmationPage({super.key});

//   @override
//   State<ConfirmationPage> createState() => _ConfirmationPageState();
// }

// class _ConfirmationPageState extends State<ConfirmationPage> {
//   // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * hours;
//   // int CarValue = 0, BikeValue = 0;
//   // int encoded = 0;
//   // Future<void> bookingID() async {
//   //   String bookingId = ("BMPS " +
//   //           DateTime.now().millisecondsSinceEpoch.hashCode.toString() +
//   //           "@@" +
//   //           FirebaseAuth.instance.currentUser!.uid)
//   //       .hashCode
//   //       .toString();
//   //   encoded = base64.encode(utf8.encode(bookingId)).hashCode;
//   //   print("encoded: $encoded");
//   //   print("bookingId: $bookingId");
//   // if (widget.vehicle == "car") {
//   //   CarValue = widget.carSpace - 1;
//   //   await updateParkingLotCar(widget.parkingLotId, CarValue);
//   // } else {
//   //   BikeValue = widget.bikeSpace - 1;
//   //   await updateParkingLotBike(widget.parkingLotId, BikeValue);
//   // }
//   // await addBooking(
//   //   encoded,
//   //   widget.vehicle,
//   //   widget.hours,
//   //   widget.parkingLotId,
//   // );
//   // }

//   // updateParkingLot() async {
//   //   if (widget.vehicle == "car") {
//   //     CarValue = CarValue + 1;
//   //     await updateParkingLotCar(widget.parkingLotId, CarValue);
//   //   } else {
//   //     BikeValue = BikeValue + 1;
//   //     await updateParkingLotBike(widget.parkingLotId, BikeValue);
//   //   }
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   bookingID();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final Size size = MediaQuery.of(context).size;
//     const defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
//     bool activeTicket = false;
//     return Scaffold(
//         appBar: CustomAppBar(),
//         body: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(
//               horizontal: size.width * mainBdPadHoriz,
//               vertical: size.width * mainBdPadVert,
//             ),
//             child: FutureBuilder(
//                 future: getTicket(authProvider.userId),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     // return // Center(
//               child: Column(
//                 children: [
//                   Text(
//                     "Booking Confirmed",
//                     style: TextStyle(
//                       fontSize: size.width * h1Size,
//                       fontWeight: h1Weight,
//                       color: bluecolor
//                     ),
//                   ),
//                   SizedBox(height: size.width * (40 / idealDevWd)),
//                   // Text(
//                   //   "Parking Lot: ${widget.parkingLotName}",
//                   //   style: TextStyle(
//                   //     fontSize: size.width * h2Size,
//                   //     fontWeight: subHdWeight,
//                   //   ),
//                   // ),
//                   // Text(
//                   //   "Address: ${widget.parkingLotAddress}",
//                   //   style: TextStyle(
//                   //     fontSize: size.width * h3Size,
//                   //     fontWeight: subHdWeight,
//                   //   ),
//                   // ),
//                   SizedBox(height: size.width * (35 / idealDevWd)),
//                   Text(
//                     "Booking ID: $ticketId",
//                     // "Booking ID: $bookingId",
//                     style: TextStyle(
//                       fontSize: size.width * bdTx3Size,
//                       fontWeight: bdTx1Weight,
                      
//                     ),
//                   ),
//                   QrImage(
//                     // data: encoded,
//                     data: ticketId.toString(),
//                     version: QrVersions.auto,
//                     size: 200,
//                     gapless: false,
//                   ),
//                   SizedBox(height: size.width * (17 / idealDevWd)),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                   //   children: [
//                   //     Text(
//                   //       "Vehicle Type: ${widget.vehicle.toUpperCase()}",
//                   //       style: TextStyle(
//                   //         fontSize: size.width * bdTx3Size,
//                   //         fontWeight: bdTx1Weight,
//                   //       ),
//                   //     ),
//                   //     Container(
//                   //       height: 125,
//                   //       width: 125,
//                   //       color: Colors.transparent,
//                   //       child: widget.vehicle == "car"
//                   //           ? Icon(
//                   //               Icons.directions_car,
//                   //               size: 75,
//                   //             )
//                   //           : Icon(
//                   //               Icons.two_wheeler,
//                   //               size: 75,
//                   //             ),
//                   //     ),
//                   //   ],
//                   // ),
//                   SizedBox(height: size.width * (30 / idealDevWd)),
//                   Text('Scan the QR code to enter the parking lot',
//                       style: TextStyle(
//                         fontSize: size.width * bdTx1Size,
//                         fontWeight: bdTx1Weight,
//                       )),
//                   SizedBox(height: size.width * (30 / idealDevWd)),
//                   Text('Starting Time: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}',
//                       style: TextStyle(
//                         fontSize: size.width * bdTx1Size,
//                         fontWeight: bdTx1Weight,
//                       )),
//                   SizedBox(height: size.width * (30 / idealDevWd)),
//                   Text('Check In Time: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}',
//                       style: TextStyle(
//                         fontSize: size.width * bdTx1Size,
//                         fontWeight: bdTx1Weight,
//                       )),
//                   // SlideCountdownSeparated(
//                   //   onDone: () async {
//                   //     await updateParkingLot();
//                   //     Navigator.pushAndRemoveUntil(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => MyHomePage(),
//                   //         ),
//                   //         (route) => false);
//                   //   },
//                   //   height: 50,
//                   //   width: 50,
//                   //   separatorType: SeparatorType.title,
//                   //   textStyle: TextStyle(
//                   //     fontSize: size.width * h3Size,
//                   //     fontWeight: subHdWeight,
//                   //     color: Colors.white,
//                   //   ),
//                   //   duration: Duration(hours: widget.hours),
//                   //   padding: defaultPadding,
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.black,
//                   //     borderRadius: BorderRadius.circular(10),
//                   //   ),
//                   // ),
//                   // SizedBox(height: size.width * (10 / idealDevWd)),
//                   SizedBox(height: size.width * (30 / idealDevWd)),
                  
//                   CustomButton(text: 'Cancel Booking', onPressed: () async {
//                         // await updateParkingLot();

//                         if(activeTicket){
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have an active ticket')));
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
//                         }
//                         else{
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Cancelled')));
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
//                         }
//                       },)

                  
//                   // MaterialButton(
//                   //     color: Colors.black,
//                   //     shape: RoundedRectangleBorder(
//                   //         borderRadius:
//                   //             BorderRadius.all(Radius.circular(20.0))),
//                   //     elevation: 5.0,
//                   //     height: 40,
//                   //     onPressed: () async {
//                   //       // await updateParkingLot();

//                   //       Navigator.pushAndRemoveUntil(
//                   //           context,
//                   //           MaterialPageRoute(
//                   //             builder: (context) => MyHomePage(),
//                   //           ),
//                   //           (route) => false);
//                   //     },
//                   //     child: Text("Cancel Booking",
//                   //         style: TextStyle(
//                   //           fontSize: size.width * bdTx3Size,
//                   //           fontWeight: bdTx1Weight,
//                   //           color: Colors.white,
//                   //         ))),
                

//                   } else {
//                     return Container(
//                       margin:
//                           EdgeInsets.only(top: size.width * (50 / idealDevWd)),
//                       child: const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   }
//                 },                                          
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// // Center(
// //               child: Column(
// //                 children: [
// //                   Text(
// //                     "Booking Confirmed",
// //                     style: TextStyle(
// //                       fontSize: size.width * h1Size,
// //                       fontWeight: h1Weight,
// //                       color: bluecolor
// //                     ),
// //                   ),
// //                   SizedBox(height: size.width * (40 / idealDevWd)),
// //                   // Text(
// //                   //   "Parking Lot: ${widget.parkingLotName}",
// //                   //   style: TextStyle(
// //                   //     fontSize: size.width * h2Size,
// //                   //     fontWeight: subHdWeight,
// //                   //   ),
// //                   // ),
// //                   // Text(
// //                   //   "Address: ${widget.parkingLotAddress}",
// //                   //   style: TextStyle(
// //                   //     fontSize: size.width * h3Size,
// //                   //     fontWeight: subHdWeight,
// //                   //   ),
// //                   // ),
// //                   SizedBox(height: size.width * (35 / idealDevWd)),
// //                   Text(
// //                     "Booking ID: $ticketId",
// //                     // "Booking ID: $bookingId",
// //                     style: TextStyle(
// //                       fontSize: size.width * bdTx3Size,
// //                       fontWeight: bdTx1Weight,
                      
// //                     ),
// //                   ),
// //                   QrImage(
// //                     // data: encoded,
// //                     data: ticketId.toString(),
// //                     version: QrVersions.auto,
// //                     size: 200,
// //                     gapless: false,
// //                   ),
// //                   SizedBox(height: size.width * (17 / idealDevWd)),
// //                   // Row(
// //                   //   mainAxisAlignment: MainAxisAlignment.center,
// //                   //   crossAxisAlignment: CrossAxisAlignment.center,
// //                   //   children: [
// //                   //     Text(
// //                   //       "Vehicle Type: ${widget.vehicle.toUpperCase()}",
// //                   //       style: TextStyle(
// //                   //         fontSize: size.width * bdTx3Size,
// //                   //         fontWeight: bdTx1Weight,
// //                   //       ),
// //                   //     ),
// //                   //     Container(
// //                   //       height: 125,
// //                   //       width: 125,
// //                   //       color: Colors.transparent,
// //                   //       child: widget.vehicle == "car"
// //                   //           ? Icon(
// //                   //               Icons.directions_car,
// //                   //               size: 75,
// //                   //             )
// //                   //           : Icon(
// //                   //               Icons.two_wheeler,
// //                   //               size: 75,
// //                   //             ),
// //                   //     ),
// //                   //   ],
// //                   // ),
// //                   SizedBox(height: size.width * (30 / idealDevWd)),
// //                   Text('Scan the QR code to enter the parking lot',
// //                       style: TextStyle(
// //                         fontSize: size.width * bdTx1Size,
// //                         fontWeight: bdTx1Weight,
// //                       )),
// //                   SizedBox(height: size.width * (30 / idealDevWd)),
// //                   Text('Starting Time: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}',
// //                       style: TextStyle(
// //                         fontSize: size.width * bdTx1Size,
// //                         fontWeight: bdTx1Weight,
// //                       )),
// //                   SizedBox(height: size.width * (30 / idealDevWd)),
// //                   Text('Check In Time: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}',
// //                       style: TextStyle(
// //                         fontSize: size.width * bdTx1Size,
// //                         fontWeight: bdTx1Weight,
// //                       )),
// //                   // SlideCountdownSeparated(
// //                   //   onDone: () async {
// //                   //     await updateParkingLot();
// //                   //     Navigator.pushAndRemoveUntil(
// //                   //         context,
// //                   //         MaterialPageRoute(
// //                   //           builder: (context) => MyHomePage(),
// //                   //         ),
// //                   //         (route) => false);
// //                   //   },
// //                   //   height: 50,
// //                   //   width: 50,
// //                   //   separatorType: SeparatorType.title,
// //                   //   textStyle: TextStyle(
// //                   //     fontSize: size.width * h3Size,
// //                   //     fontWeight: subHdWeight,
// //                   //     color: Colors.white,
// //                   //   ),
// //                   //   duration: Duration(hours: widget.hours),
// //                   //   padding: defaultPadding,
// //                   //   decoration: BoxDecoration(
// //                   //     color: Colors.black,
// //                   //     borderRadius: BorderRadius.circular(10),
// //                   //   ),
// //                   // ),
// //                   // SizedBox(height: size.width * (10 / idealDevWd)),
// //                   SizedBox(height: size.width * (30 / idealDevWd)),
                  
// //                   CustomButton(text: 'Cancel Booking', onPressed: () async {
// //                         // await updateParkingLot();

// //                         if(activeTicket){
// //                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have an active ticket')));
// //                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
// //                         }
// //                         else{
// //                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Cancelled')));
// //                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
// //                         }
// //                       },)

                  
// //                   // MaterialButton(
// //                   //     color: Colors.black,
// //                   //     shape: RoundedRectangleBorder(
// //                   //         borderRadius:
// //                   //             BorderRadius.all(Radius.circular(20.0))),
// //                   //     elevation: 5.0,
// //                   //     height: 40,
// //                   //     onPressed: () async {
// //                   //       // await updateParkingLot();

// //                   //       Navigator.pushAndRemoveUntil(
// //                   //           context,
// //                   //           MaterialPageRoute(
// //                   //             builder: (context) => MyHomePage(),
// //                   //           ),
// //                   //           (route) => false);
// //                   //     },
// //                   //     child: Text("Cancel Booking",
// //                   //         style: TextStyle(
// //                   //           fontSize: size.width * bdTx3Size,
// //                   //           fontWeight: bdTx1Weight,
// //                   //           color: Colors.white,
// //                   //         ))),
// //                 ],
// //               ),
// //             )