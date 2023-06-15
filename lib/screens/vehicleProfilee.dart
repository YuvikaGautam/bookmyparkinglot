import 'package:bookmyparkinglot/providers/auth.dart';
import 'package:bookmyparkinglot/servers/api.dart';
import 'package:flutter/material.dart';

import 'package:bookmyparkinglot/utilities/appBar.dart';
import 'package:bookmyparkinglot/utilities/button.dart';
import 'package:provider/provider.dart';

class VehicleProfiles extends StatefulWidget {
  const VehicleProfiles({Key? key}) : super(key: key);

  @override
  State<VehicleProfiles> createState() => _VehicleProfilesState();
}

class _VehicleProfilesState extends State<VehicleProfiles> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  var selecteddefaultVehicleId;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Vehicle Profiles',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  // Fetch vehicle profiles again
                  setState(() {});
                },
                child: FutureBuilder<List<dynamic>>(
                  future: Future.wait([
                    fetchVehicleProfiles(authProvider.userId.toString()),
                    fetchDefaultVehicle(authProvider.userId.toString())
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final vehicleProfiles = snapshot.data![0];
                      final defaultVehicle = snapshot.data![1];
                      var defaultVehicleId = defaultVehicle['vehicleId'];
                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: vehicleProfiles!.length,
                            itemBuilder: (BuildContext context, int index) {
                              final vehicleProfile = vehicleProfiles[index];
                              final vehicleId = vehicleProfile['vehicleId'];

                              final isDefault = vehicleId == defaultVehicleId;
                              // final selecteddefaultVehicleId =
                              //     defaultVehicleId == vehicleId;

                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selecteddefaultVehicleId = vehicleId;
                                    print(
                                        'defaultVehicleId: $defaultVehicleId');
                                  });
                                  print('isDefault: $isDefault');
                                },
                                child: Card(
                                  color: selecteddefaultVehicleId == vehicleId
                                      ? Colors.grey[300]
                                      : Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.grey,
                                            child: Icon(
                                              Icons.car_rental,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Visibility(
                                                visible: isDefault,
                                                child: const Text('Default:'),
                                              ),
                                              Text(
                                                'Vehicle Number : ${vehicleProfile["vehicleNo"]}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Vehicle Type : ${vehicleProfile["vehicleType"]}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Vehicle Model : ${vehicleProfile["vehicleName"]}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Select the Default Vehicle',
                            onPressed: () async {
                              if (selecteddefaultVehicleId != null) {
                                await setDefaultVehicleProfile(
                                  selecteddefaultVehicleId.toString(),
                                
                                );
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertVehicle(refreshIndicatorKey: _refreshIndicatorKey);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AlertVehicle extends StatefulWidget {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  AlertVehicle({Key? key, required this.refreshIndicatorKey}) : super(key: key);

  @override
  State<AlertVehicle> createState() => _AlertVehicleState();
}

class _AlertVehicleState extends State<AlertVehicle> {
  final _formKey = GlobalKey<FormState>();
  String _vehicleNumber = '';
  String _vehicleType = '';
  String _vehicleName = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return AlertDialog(
      title: const Text('Enter Vehicle Details'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(labelText: 'Vehicle Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Vehicle Number';
                }
                return null;
              },
              onSaved: (value) => _vehicleNumber = value!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _vehicleType = 'Car';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _vehicleType == 'car' ? Colors.blue : Colors.grey,
                  ),
                  child: const Text('Car'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _vehicleType = 'Bike';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _vehicleType == 'bike' ? Colors.blue : Colors.grey,
                  ),
                  child: const Text('Bike'),
                ),
              ],
            ),
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              decoration:
                  const InputDecoration(labelText: 'Vehicle Model Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Vehicle Model Name';
                }
                return null;
              },
              onSaved: (value) => _vehicleName = value!,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomButton(
                text: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButton(
                text: 'Submit',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    bool result = await addVehicleProfile(
                      authProvider.userId.toString(),
                      _vehicleNumber,
                      _vehicleType,
                      _vehicleName,
                    );
                    if (result) {
                      setState(() {});
                      Navigator.of(context).pop();
                      setState(() {});
                    }

                    widget.refreshIndicatorKey.currentState?.show();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
