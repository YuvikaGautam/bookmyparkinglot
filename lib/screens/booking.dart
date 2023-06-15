// import 'dart:math';

// import 'package:bookmyparkinglot/screens/confirm.dart';
// import 'package:bookmyparkinglot/screens/showticket.dart';
// import 'package:bookmyparkinglot/servers/api.dart';
// import 'package:bookmyparkinglot/utilities/appBar.dart';
// import 'package:bookmyparkinglot/utilities/button.dart';
// import 'package:bookmyparkinglot/utilities/constant.dart';
// import 'package:bookmyparkinglot/providers/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:provider/provider.dart';
// import 'ticket.dart';

// class BookingPage extends StatefulWidget {
//   String id;
//   BookingPage(this.id, {super.key});

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// String _value = "car";
// int _currentIntValue = 1;
// double price = 0;
// String ticketid = "";
// String checkoutid = "";

// class _BookingPageState extends State<BookingPage> {
//   @override
//   void initState() {
//     super.initState();
//     _value = "car";
//     _currentIntValue = 1;
//     price = 0;
//   }

//   Future<void> generateIds(String useridd) async {
//    String  id1 = "";
//    String id2 = "";
//     var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//     var charLength = chars.length;
//     for (var i = 0; i < 14; i++) {
//       id1 += chars[Random().nextInt(charLength)];
//       id2 += chars[Random().nextInt(charLength)];
//     }
//     ticketid = '$id1&$useridd';
//     checkoutid = '$id2&$useridd';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     return Scaffold(
//         appBar: CustomAppBar(
//           title: 'Parking Details',
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
//           ),
//         ),
//         body: RefreshIndicator(
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: EdgeInsets.symmetric(
//               horizontal: size.width * mainBdPadHoriz,
//             ),
//             child: Column(
//               children: [
//                 FutureBuilder(
//                   future: ParkingLot(widget.id.toString()),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Image.asset(
//                               "assests/images/park.png",
//                               fit: BoxFit.fitWidth,
//                             ),
//                           ),
//                           SizedBox(height: size.width * (17 / idealDevWd)),
//                           Align(
//                               alignment: Alignment.centerLeft,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     snapshot.data!["plotName"] ??
//                                         'Rahul Parking Wale',
//                                     style: TextStyle(
//                                       fontSize: 26,
//                                       fontWeight: h1Weight,
//                                     ),
//                                   ),

//                                   // SizedBox(height: size.width * (10 / idealDevWd)),
//                                   Text(
//                                     snapshot.data!["paddress"],
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: h2Weight,
//                                         color: grey),
//                                   ),
//                                 ],
//                               )),
//                           SizedBox(height: size.width * (17 / idealDevWd)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 snapshot.data!['pmanager'],
//                                 style: TextStyle(
//                                   fontSize: size.width * subHdSize,
//                                   fontWeight: bdTx2Weight,
//                                 ),
//                               ),
//                               Text(
//                                 snapshot.data!['pphNo'],
//                                 style: TextStyle(
//                                   fontSize: size.width * subHdSize,
//                                   fontWeight: bdTx2Weight,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Divider(),
//                           SizedBox(height: size.width * (17 / idealDevWd)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50),
//                                     border: Border.all(color: bluecolor),
//                                     color: Colors.transparent,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.directions_car,
//                                         color: bluecolor,
//                                         size: 20,
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         "Availablity :" +
//                                             snapshot.data!['carSpace']
//                                                 .toString(),
//                                         style: TextStyle(
//                                             fontSize: size.width * subHdSize,
//                                             fontWeight: bdTx1Weight,
//                                             color: bluecolor),
//                                       ),
//                                     ],
//                                   )),
//                               Container(
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50),
//                                     border: Border.all(color: bluecolor),
//                                     color: Colors.transparent,
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.two_wheeler,
//                                         color: bluecolor,
//                                         size: 20,
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Text(
//                                         "Availablity :" +
//                                             snapshot.data!['bikeSpace']
//                                                 .toString(),
//                                         style: TextStyle(
//                                             fontSize: size.width * subHdSize,
//                                             fontWeight: bdTx1Weight,
//                                             color: bluecolor),
//                                       ),
//                                     ],
//                                   )),
//                             ],
//                           ),
//                           SizedBox(height: size.width * (30 / idealDevWd)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text(
//                                 "No. of Hours :",
//                                 style: TextStyle(
//                                   fontSize: size.width * h3Size,
//                                   fontWeight: bdTx1Weight,
//                                 ),
//                               ),
//                               SizedBox(width: size.width * (10 / idealDevWd)),
//                               NumberPicker(
//                                 value: _currentIntValue,
//                                 minValue: 1,
//                                 maxValue: 24,
//                                 step: 1,
//                                 itemHeight: 50,
//                                 itemWidth: 75,
//                                 axis: Axis.horizontal,
//                                 textStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: bdTx1Weight,
//                                 ),
//                                 selectedTextStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: size.width * h3Size,
//                                   fontWeight: bdTx1Weight,
//                                 ),
//                                 // onChanged: (value) =>
//                                 //     setState(() => _currentIntValue = value),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _currentIntValue = value;
//                                     Price();
//                                   });
//                                 },
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16),
//                                   border: Border.all(color: Colors.black26),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: size.width * (20 / idealDevWd)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               Text(
//                                 "Select Your Vehicle",
//                                 style: TextStyle(
//                                   fontSize: size.width * h3Size,
//                                   fontWeight: bdTx1Weight,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _value = "car";
//                                     _currentIntValue = 1;
//                                     Price();
//                                   });
//                                 },
//                                 child: Container(
//                                   height: 55,
//                                   width: 55,
//                                   color: _value == "car"
//                                       ? Colors.grey
//                                       : Colors.transparent,
//                                   child: Icon(
//                                     Icons.directions_car,
//                                     color: bluecolor,
//                                     size: 40,
//                                   ),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _value = "bike";
//                                     _currentIntValue = 1;
//                                     Price();
//                                   });
//                                 },
//                                 child: Container(
//                                   height: 55,
//                                   width: 55,
//                                   color: _value == "bike"
//                                       ? Colors.grey
//                                       : Colors.transparent,
//                                   child: Icon(
//                                     Icons.two_wheeler,
//                                     color: bluecolor,
//                                     size: 40,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: size.width * (50 / idealDevWd)),
//                           Text(
//                             "Total Amount : Rs. $price",
//                             style: TextStyle(
//                               fontSize: size.width * h3Size,
//                               fontWeight: bdTx1Weight,
//                             ),
//                           ),
//                           CustomButton(
//                             text: 'Continue',
//                             onPressed: () async {
//                               if (price == 0) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content:
//                                         Text('Please select a vehicle type'),
//                                   ),
//                                 );
//                               } else {
//                                 await authProvider.ValuesAuth(
//                                     snapshot.data!['ownerId']);
//                                 if (_value == "car") {
//                                   await updateParkingLotCar(widget.id,
//                                       snapshot.data!['carSpace'] - 1);
//                                 } else {
//                                   await updateParkingLotBike(widget.id,
//                                       snapshot.data!['bikeSpace'] - 1);
//                                 }
//                                 await generateIds(authProvider.userId);
//                                 await generateTicket(
//                                     authProvider.userId,
//                                     snapshot.data!['ownerId'],
//                                     DateTime.now().toString(),
//                                     _currentIntValue,
//                                     ticketid,
//                                     checkoutid);
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ShowTicket(),
//                                   ),
//                                 );
//                                 // Navigator.pushAndRemoveUntil(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //       builder: (context) => ConfirmationPage(
//                                 //           snapshot.data!['ownerId'],
//                                 //           snapshot.data!["plotName"],
//                                 //           snapshot.data!["paddress"],
//                                 //           snapshot.data!['pphNo'],
//                                 //           _currentIntValue,
//                                 //           price,
//                                 //           _value,
//                                 //           snapshot.data!['carSpace'],
//                                 //           snapshot.data!['bikeSpace']),
//                                 //     ),
//                                 //     (route) => false);
//                                 //   Navigator.pushReplacement(
//                                 //   context,
//                                 // MaterialPageRoute(
//                                 //   builder: (context) => ConfirmationPage(
//                                 //     snapshot.data!['ownerId'],
//                                 //       snapshot.data!["plotName"],
//                                 //       snapshot.data!["paddress"],
//                                 //       snapshot.data!['pphNo'],
//                                 //       _currentIntValue,
//                                 //       price,
//                                 //       _value
//                                 //   ),
//                                 // ),
//                                 // );
//                               }
//                             },
//                           )
//                         ],
//                       );
//                     } else {
//                       return Container(
//                         margin: EdgeInsets.only(
//                             top: size.width * (50 / idealDevWd)),
//                         child: const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     }
//                   },
//                 )
//               ],
//             ),
//           ),
//           onRefresh: () async {
//             setState(() {
//               ParkingLot(widget.id.toString());
//               print("Refreshed");
//               Future.delayed(const Duration(seconds: 2));
//             });
//           },
//         ));
//   }

//   void Price() {
//     if (_value == "car") {
//       price = 50 + (_currentIntValue - 1) * 20;
//     } else if (_value == "bike") {
//       price = 20 + (_currentIntValue - 1) * 10;
//     }
//   }
// }
import 'dart:math';

import 'package:bookmyparkinglot/screens/confirm.dart';
import 'package:bookmyparkinglot/screens/showticket.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:bookmyparkinglot/utilities/button.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'ticket.dart';

class BookingPage extends StatefulWidget {
  final String id;

  BookingPage(this.id, {Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late String _value;
  int _currentIntValue = 1;
  double price = 0;
  String ticketid = "";
  String checkInid = "";
  bool isLoading = false;
  // var vehicleList = {
  //   "vehicles": [
  //     {"vehicleNumber": "DLQWW12345", "vehicleType": "car"},
  //     {"vehicleNumber": "DLQWW67890", "vehicleType": "bike"},
  //     {"vehicleNumber": "DLQWW24680", "vehicleType": "car"}
  //   ]
  // };
  String vehicleNumberSub = '';
  @override
  void initState() {
    super.initState();
    _value = "car";
    _currentIntValue = 1;
    price = 0;
  }

  Future<void> generateIds() async {
    String id1 = "";
    String id2 = "";
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    var charLength = chars.length;
    for (var i = 0; i < 14; i++) {
      id1 += chars[Random().nextInt(charLength)];
      id2 += chars[Random().nextInt(charLength)];
    }
    ticketid = id1;
    checkInid = id2;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Parking Details',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            // Add code to refresh data here
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * mainBdPadHoriz,
          ),
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                future: Future.wait([
                  ParkingLot(widget.id.toString()),
                  fetchVehicleProfiles(authProvider.userId.toString())
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var parkingData = snapshot.data![0];
                    var vehicleData = snapshot.data![1];
                    return isLoading
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text(
                                  'Please wait while the ticket is generated...',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assests/images/park.png",
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              SizedBox(height: size.width * (17 / idealDevWd)),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parkingData["plotName"] ??
                                          'Rahul Parking Wale',
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: h1Weight,
                                      ),
                                    ),
                                    Text(
                                      parkingData["paddress"],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: h2Weight,
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.width * (17 / idealDevWd)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    parkingData['pmanager'],
                                    style: TextStyle(
                                      fontSize: size.width * subHdSize,
                                      fontWeight: bdTx2Weight,
                                    ),
                                  ),
                                  Text(
                                    parkingData['pphNo'],
                                    style: TextStyle(
                                      fontSize: size.width * subHdSize,
                                      fontWeight: bdTx2Weight,
                                    ),
                                  )
                                ],
                              ),
                              const Divider(),
                              SizedBox(height: size.width * (17 / idealDevWd)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildAvailabilityContainer(
                                    Icons.directions_car,
                                    "Availability: ${parkingData['carSpace']}",
                                  ),
                                  buildAvailabilityContainer(
                                    Icons.two_wheeler,
                                    "Availability: ${parkingData['bikeSpace']}",
                                  ),
                                ],
                              ),
                              SizedBox(height: size.width * (20 / idealDevWd)),
                              Text(
                                "Select Your Vehicle :",
                                style: TextStyle(
                                  fontSize: size.width * h3Size,
                                  fontWeight: bdTx1Weight,
                                ),
                              ),
                              SizedBox(width: size.width * (10 / idealDevWd)),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: vehicleData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      buildVehicleListTile(
                                        vehicleData[index]["vehicleType"] ==
                                                'car'
                                            ? Icons.directions_car
                                            : Icons.two_wheeler,
                                        vehicleData[index]["vehicleNo"],
                                        vehicleData[index]["vehicleType"],
                                      ),
                                      const Divider(),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: size.width * (20 / idealDevWd)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "No. of Hours:",
                                    style: TextStyle(
                                      fontSize: size.width * h3Size,
                                      fontWeight: bdTx1Weight,
                                    ),
                                  ),
                                  SizedBox(
                                      width: size.width * (10 / idealDevWd)),
                                  NumberPicker(
                                    value: _currentIntValue,
                                    minValue: 1,
                                    maxValue: 24,
                                    step: 1,
                                    itemHeight: 50,
                                    itemWidth: 75,
                                    axis: Axis.horizontal,
                                    textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: bdTx1Weight,
                                    ),
                                    selectedTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.width * h3Size,
                                      fontWeight: bdTx1Weight,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _currentIntValue = value;

                                        calculatePrice();
                                      });
                                    },
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.black26),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.width * (20 / idealDevWd)),
                              Text(
                                "Total Amount : Rs. $price",
                                style: TextStyle(
                                  fontSize: size.width * h3Size,
                                  fontWeight: bdTx1Weight,
                                ),
                              ),
                              CustomButton(
                                text: 'Continue',
                                onPressed: () async {
                                  if (price == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please select a vehicle type'),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await generateIds();
                                    bool result1 = await bookTicket(
                                        authProvider.userId,
                                        ticketid,
                                        checkInid,
                                        widget.id,
                                        _currentIntValue);
                                    if (_value == 'car') {
                                      await updateParkingLotCar(widget.id,
                                          parkingData['carSpace'] - 1);
                                    } else {
                                      await updateParkingLotBike(widget.id,
                                          parkingData['bikeSpace'] - 1);
                                    }

                                    bool result2 = await addTicketToOwner(
                                        checkInid,
                                        ticketid,
                                        widget.id,
                                        authProvider.userId,
                                        vehicleNumberSub);
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (result1 && result2) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Ticket Booked Successfully'),
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ShowTicket(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Ticket Booking Failed'),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
                      margin: EdgeInsets.only(
                        top: size.width * (50 / idealDevWd),
                      ),
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
      ),
    );
  }

  Container buildAvailabilityContainer(IconData icon, String text) {
    final size = MediaQuery.of(context).size; // Retrieve the screen size
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: bluecolor),
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: bluecolor,
            size: 20,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: size.width * subHdSize,
              fontWeight: bdTx1Weight,
              color: bluecolor,
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildVehicleListTile(
    IconData icon,
    String vehicleNumber,
    String vehicleType,
  ) {
    final size = MediaQuery.of(context).size; // Retrieve the screen size

    return ListTile(
      leading: Icon(
        icon,
        color: bluecolor,
        size: 30,
      ),
      title: Text(
        vehicleNumber,
        style: TextStyle(
          fontSize: size.width * h3Size,
          fontWeight: bdTx1Weight,
        ),
      ),
      trailing: Radio(
        value: vehicleType,
        groupValue: _value,
        onChanged: (value) {
          setState(() {
            _value = value.toString();
            _currentIntValue = 1;
            vehicleNumberSub = vehicleNumber;
            calculatePrice();
          });
        },
      ),
      onTap: () {
        setState(() {
          _value = vehicleType;
          _currentIntValue = 1;
          vehicleNumberSub = vehicleNumber;
          calculatePrice();
        });
      },
    );
  }

  void calculatePrice() {
    if (_value == "car") {
      price = 50 + (_currentIntValue - 1) * 20;
    } else if (_value == "bike") {
      price = 20 + (_currentIntValue - 1) * 10;
    }
  }
}
