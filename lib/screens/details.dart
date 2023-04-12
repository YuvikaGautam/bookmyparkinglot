import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/screens/home.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:bookmyparkinglot/utilities/button.dart';
import 'package:bookmyparkinglot/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();
  final fName = TextEditingController();
  final lName = TextEditingController();
  final vehicleType = TextEditingController();
  final vehicleModel = TextEditingController();
  final vehicleNumber = TextEditingController();


  bool result = false;

  Future<bool> addUser() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    result = await addUserDetails(
        authProvider.userId,
        fName.text,
        lName.text,
        vehicleType.text,
        vehicleModel.text,
        vehicleNumber.text);
    return result;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 31),
          child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fill Your Profile',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: grey,
                          child: const Icon(Icons.person,
                              size: 75,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: buildfName(),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: buildlName(),
                                  ),
                                ],
                              ),
                              buildVehicleNumber(),
                              builVehicleModel(),
                              buildVehicleType(),
                              CustomButton(
                                onPressed: (() async {
                                  bool valid =
                                      _formKey.currentState!.validate();
                                  if (valid) {
                                    await addUser();
                                    if (result) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Welcome to BookMyParkingLot')));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Something went wrong')));
                                    }
                                  }
                                }),
                                text: 'Continue',
                              ),
                            ],
                          ))
                    ],
                  )
                ]),
              ))),
    );
  }

  Widget buildfName() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: fName,
          validator: (value) {
            if (value!.isEmpty) {
              return "First Name cannot be empty";
            }
            if (value.length < 3) {
              return "First Name must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('First Name'),
        ),
      );
  Widget buildlName() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: lName,
          validator: (value) {
            if (value!.isEmpty) {
              return "Last Name cannot be empty";
            }
            if (value.length < 3) {
              return "Last Name must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Last Name'),
        ),
      );

  Widget buildVehicleNumber() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: vehicleNumber,
          validator: (value) {
            if (value!.isEmpty) {
              return "Vehicle Number cannot be empty";
            }
            if (value.length < 8) {
              return "Vehicle Number must be atleast 8 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Enter Vehicle Number'),
        ),
      );
  Widget builVehicleModel() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: vehicleModel,
          
          
          validator: (value) {
            if (value!.isEmpty) {
              return "Vehicle Model cannot be empty";
            }
            if (value.length < 5) {
              return "Vehicle Model must be atleast 5 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Enter Vehicle Model'),
        ),
      );
  Widget buildVehicleType() => Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: vehicleType,
          validator: (value) {
            if (value!.isEmpty) {
              return "Vehicle Type cannot be empty";
            }
            if (value.length < 3) {
              return "Vehicle Type must be atleast 3 characters";
            }
            return null;
          },
          decoration: getCustomDecoration('Enter Vehicle Type'),
        ),
      );
}
