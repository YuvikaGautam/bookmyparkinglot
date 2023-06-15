import 'package:flutter/material.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:bookmyparkinglot/utilities/button.dart';
import 'package:bookmyparkinglot/utilities/scanner.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen({Key? key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _uniqueCodeController = TextEditingController();
  String uniqueCode = '';
  List<String> messages = [
    "Please remove your vehicle, Mine is stuck!",
    "Please remove your vehicle, I need to go urgently!",
  ];
  String selectedMessage = 'Please remove your vehicle, Mine is stuck!';

  Future<void> _scanQRCode() async {
    String? result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(builder: (context) => const Scanner()),
    );

    if (result != null) {
      Map data = await getDataofUsers(result);
      setState(() {
        uniqueCode = result;
        print('uniqueCode: $uniqueCode');
      });
    }
  }

  void _sendMessage() {
    // Implement the logic to send the selected message
    print('uniqueCode: $uniqueCode');
    print('Sending message: $selectedMessage');
    SnackBar snackBar = const SnackBar(
      content: Text('Message sent successfully!'),
      backgroundColor: Colors.green,
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            const Text(
              'Select Message to Send to the Owner',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isSelected = selectedMessage == messages[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMessage = messages[index];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.grey : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              messages[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
  text: uniqueCode.isEmpty
      ? "Scan the QR code"
      : "Send the Message to Owner",
  onPressed: () {
    if (uniqueCode.isEmpty) {
      _scanQRCode();
    } else if (selectedMessage.isNotEmpty) {
      _sendMessage();
    }
  },
),

          ],
        ),
      ),
    );
  }
}
