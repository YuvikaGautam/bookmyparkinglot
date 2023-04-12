// import 'package:bookmyparkinglot/utilities/appBar.dart';
// import 'package:bookmyparkinglot/utilities/button.dart';
// import 'package:flutter/material.dart';

// class VehicleProliles extends StatefulWidget {
//   const VehicleProliles({super.key});

//   @override
//   State<VehicleProliles> createState() => _VehicleProlilesState();
// }

// class _VehicleProlilesState extends State<VehicleProliles> {
//   List<String> options = ['Option 1', 'Option 2', 'Option 3'];
//   int? selectedOption;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Vehicle Profiles',
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: AlwaysScrollableScrollPhysics(),
//                 itemCount: options.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Card(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 20,
//                               backgroundColor: Colors.grey,
//                               child: Icon(
//                                 Icons.car_rental,
//                                 size: 10,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(width: 20),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Vehicle Number : DL 8CW 54221',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   'Vehicle Type : Car',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(
//                                   'Vehicle Model : Maruti Suzuki Swift',
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         ListTile(
//                           trailing: Radio(
//                             value: index,
//                             groupValue: selectedOption,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedOption = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertVehicle();
//             },
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class AlertVehicle extends StatefulWidget {
//   const AlertVehicle({super.key});

//   @override
//   State<AlertVehicle> createState() => _AlertVehicleState();
// }

// class _AlertVehicleState extends State<AlertVehicle> {
//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     String _vehicleNumber = '';
//     String _vehicleType = '';
//     String _vehicleModel = '';
//     return AlertDialog(
//       title: Text('Enter Vehicle Details'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Vehicle Number'),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your Vehicle Number';
//                 }
//                 return null;
//               },
//               onSaved: (value) => _vehicleNumber = value!,
//             ),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _vehicleType = 'Car';
//                     });
//                   },
//                   child: Text('Car'),
//                   style: _vehicleType == 'Car'
//                       ? ElevatedButton.styleFrom(primary: Colors.blue)
//                       : ElevatedButton.styleFrom(primary: Colors.grey),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _vehicleType = 'Bike';
//                     });
//                   },
//                   child: Text('Bike'),
//                   style: _vehicleType == 'Bike'
//                       ? ElevatedButton.styleFrom(primary: Colors.blue)
//                       : ElevatedButton.styleFrom(primary: Colors.grey),
//                 ),
//               ],
//             ),
//             // DropdownButtonFormField(
//             //   decoration: InputDecoration(labelText: 'Vehicle Type'),
//             //   value: _vehicleType,
//             //   onChanged: (newValue) {
//             //     setState(() {
//             //       _vehicleType =
//             //           newValue.toString(); // update the selected vehicle type
//             //     });
//             //   },
//             //   items: <String>['Car', 'Bike']
//             //       .map<DropdownMenuItem<String>>((String value) {
//             //     return DropdownMenuItem<String>(
//             //       value: value,
//             //       child: Text(value),
//             //     );
//             //   }).toList(),
//             //   validator: (value) {
//             //     if (value == null || value.isEmpty) {
//             //       return 'Please select a vehicle type'; // add validation for the selected value
//             //     }
//             //     return null;
//             //   },
//             //   onSaved: (value) => _vehicleType = value!,
//             // ),
//             // TextFormField(
//             //   decoration: InputDecoration(labelText: 'Vehicle Type'),
//             //   validator: (value) {
//             //     if (value!.isEmpty) {
//             //       return 'Please enter your email';
//             //     }
//             //     return null;
//             //   },
//             //   onSaved: (value) => _vehicleType = value!,
//             // ),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Vehicle Model'),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your Vehicle Model';
//                 }
//                 return null;
//               },
//               onSaved: (value) => _vehicleModel = value!,
//             ),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Expanded(
//               child: CustomButton(
//                 text: 'Cancel',
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: CustomButton(
//                 text: 'Save',
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     print(_vehicleNumber);
//                     print(_vehicleType);
//                     print(_vehicleModel);
//                     Navigator.of(context).pop();
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
