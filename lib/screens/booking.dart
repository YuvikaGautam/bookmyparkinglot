import 'package:bookmyparkinglot/screens/confirm.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'ticket.dart';

class BookingPage extends StatefulWidget {
  int id;
  BookingPage(this.id, {super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

String _value = "car";
int _currentIntValue = 1;
double price = 0;

class _BookingPageState extends State<BookingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value = "car";
    _currentIntValue = 1;
    price = 0;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
        ),
        body: RefreshIndicator(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * mainBdPadHoriz,
              vertical: size.width * mainBdPadVert,
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: ParkingLot(widget.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            snapshot.data!['parkingLot'] ??
                                'Rahul Parking Wale',
                            style: TextStyle(
                              fontSize: size.width * h1Size,
                              fontWeight: h1Weight,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(height: size.width * (17 / idealDevWd)),
                          SizedBox(
                            // height: 125,
                            width: double.infinity,
                            child: Image.asset(
                              "assests/images/park.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          SizedBox(height: size.width * (10 / idealDevWd)),
                          Text(
                            snapshot.data!['address'],
                            style: TextStyle(
                              fontSize: size.width * h2Size,
                              fontWeight: h2Weight,
                            ),
                          ),
                          SizedBox(height: size.width * (17 / idealDevWd)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!['parkingManager'],
                                style: TextStyle(
                                  fontSize: size.width * subHdSize,
                                  fontWeight: bdTx2Weight,
                                ),
                              ),
                              Text(
                                snapshot.data!['parkingPhNo'],
                                style: TextStyle(
                                  fontSize: size.width * subHdSize,
                                  fontWeight: bdTx2Weight,
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          SizedBox(height: size.width * (17 / idealDevWd)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Availablity :" +
                                    snapshot.data!['carSpace'].toString(),
                                style: TextStyle(
                                  fontSize: size.width * subHdSize,
                                  fontWeight: bdTx1Weight,
                                ),
                              ),
                              Text(
                                "Availablity :" +
                                    snapshot.data!['bikeSpace'].toString(),
                                style: TextStyle(
                                  fontSize: size.width * subHdSize,
                                  fontWeight: bdTx1Weight,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _value = "car";
                                    _currentIntValue = 1;
                                    Price();
                                  });
                                },
                                child: Container(
                                  height: 125,
                                  width: 125,
                                  color: _value == "car"
                                      ? Colors.grey
                                      : Colors.transparent,
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 75,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _value = "bike";
                                    _currentIntValue = 1;
                                    Price();
                                  });
                                },
                                child: Container(
                                  height: 125,
                                  width: 125,
                                  color: _value == "bike"
                                      ? Colors.grey
                                      : Colors.transparent,
                                  child: const Icon(
                                    Icons.two_wheeler,
                                    size: 75,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.width * (30 / idealDevWd)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "No. of Hours :",
                                style: TextStyle(
                                  fontSize: size.width * h3Size,
                                  fontWeight: bdTx1Weight,
                                ),
                              ),
                              SizedBox(width: size.width * (10 / idealDevWd)),
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
                                // onChanged: (value) =>
                                //     setState(() => _currentIntValue = value),
                                onChanged: (value) {
                                  setState(() {
                                    _currentIntValue = value;
                                    Price();
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Total Amount : Rs. $price",
                                style: TextStyle(
                                  fontSize: size.width * h3Size,
                                  fontWeight: bdTx1Weight,
                                ),
                              ),
                              SizedBox(width: size.width * (10 / idealDevWd)),
                              SizedBox(
                                // width: double.infinity,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Colors.black)),
                                  onPressed: () {
                                    if (price == 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please select a vehicle type'),
                                        ),
                                      );
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmationPage(
                                                    snapshot.data!['placeId'],
                                                    snapshot
                                                        .data!['parkingLot'],
                                                    snapshot.data!['address'],
                                                    snapshot
                                                        .data!['parkingPhNo'],
                                                    _currentIntValue,
                                                    price,
                                                    _value,
                                                    snapshot.data!['carSpace'],
                                                    snapshot
                                                        .data!['bikeSpace']),
                                          ),
                                          (route) => false);
                                      //   Navigator.pushReplacement(
                                      //   context,
                                      // MaterialPageRoute(
                                      //   builder: (context) => ConfirmationPage(
                                      //     snapshot.data!['placeId'],
                                      //       snapshot.data!['parkingLot'],
                                      //       snapshot.data!['address'],
                                      //       snapshot.data!['parkingPhNo'],
                                      //       _currentIntValue,
                                      //       price,
                                      //       _value
                                      //   ),
                                      // ),
                                      // );
                                    }
                                  },
                                  child: const Text('Book Now'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(
                            top: size.width * (50 / idealDevWd)),
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
          onRefresh: () async {
            
            
            setState(() {
              ParkingLot(widget.id.toString());
              print("Refreshed");
              Future.delayed(const Duration(seconds: 2 ));
            });
          },
        ));
  }

  void Price() {
    if (_value == "car") {
      price = 50 + (_currentIntValue - 1) * 20;
    } else if (_value == "bike") {
      price = 20 + (_currentIntValue - 1) * 10;
    }
  }
}
