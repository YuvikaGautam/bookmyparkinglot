import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/screens/ticketnew.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketsBooked extends StatefulWidget {
  const TicketsBooked({Key? key});

  @override
  State<TicketsBooked> createState() => _TicketsBookedState();
}

class _TicketsBookedState extends State<TicketsBooked> {
  Future<List<dynamic>>? _ticketsFuture;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _ticketsFuture = getallTickets(authProvider.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Tickets Booked',
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            future: _ticketsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    dynamic ticket = snapshot.data![index];
                    return ticket['ActiveStatus'] == false
                        ? GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => TicketDetails(ticket: ticket),
                              //   ),
                              // );
                            },
                            child: Card(
                              elevation: 4, // Add elevation for a shadow effect
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  'Booking Time ${DateTime.fromMillisecondsSinceEpoch(ticket['bookingtime'] * 1000)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      'Check In Time ${DateTime.fromMillisecondsSinceEpoch(ticket['CheckinTime'] * 1000)}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Check Out Time ${DateTime.fromMillisecondsSinceEpoch(ticket['CheckoutTime'] * 1000)}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Center(child: Text('No Active Tickets Found'));
                  },
                );
              } else {
                return const Center(child: Text('No tickets found.'));
              }
            },
          ),
        ),
      ),
    );
  }
}
