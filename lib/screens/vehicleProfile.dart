// import 'package:bookmyparkinglot/utilities/appBar.dart';
// import 'package:flutter/material.dart';

// // Step 2: Create a class to represent a vehicle profile
// class VehicleProfile {
//   final String make;
//   final String model;
//   final int year;
//   final String color;
//   final String image;

//   VehicleProfile({
//     required this.make,
//     required this.model,
//     required this.year,
//     required this.color,
//     required this.image,
//   });
// }

// // Step 3: Create a class to manage the list of vehicle profiles
// class VehicleProfiles {
//   List<VehicleProfile> _profiles = [
//     VehicleProfile(
//       make: 'Toyota',
//       model: 'Camry',
//       year: 2018,
//       color: 'Silver',
//       image: 'https://via.placeholder.com/150',
//     ),
//     VehicleProfile(
//       make: 'Honda',
//       model: 'Accord',
//       year: 2020,
//       color: 'Black',
//       image: 'https://via.placeholder.com/150',
//     ),
//   ];

//   List<VehicleProfile> get profiles => _profiles;

//   void addProfile(VehicleProfile profile) {
//     _profiles.add(profile);
//   }
// }

// class VehicleScreen extends StatelessWidget {
//   final VehicleProfiles _vehicleProfiles = VehicleProfiles();
//   VehicleScreen({super.key});

//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: CustomAppBar(title: 'Vehicle Profiles'),
//         body: ListView.builder(
//           itemCount: _vehicleProfiles.profiles.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               leading: Image.network(_vehicleProfiles.profiles[index].image),
//               title: Text(
//                 '${_vehicleProfiles.profiles[index].make} ${_vehicleProfiles.profiles[index].model}',
//               ),
//               subtitle: Text(
//                 'Year: ${_vehicleProfiles.profiles[index].year}, Color: ${_vehicleProfiles.profiles[index].color}',
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ProfileDetailsScreen(
//                       profile: _vehicleProfiles.profiles[index],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => CreateProfileScreen(
//                   onProfileCreated: (profile) {
//                     _vehicleProfiles.addProfile(profile);
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             );
//           },
//           child: Icon(Icons.add),
//         ),
//       );  
//   }
// }

// // class VehicleProfile extends StatelessWidget {
// // final VehicleProfiles _vehicleProfiles = VehicleProfiles();

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Vehicle Profiles',
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Vehicle Profiles'),
// //         ),
// //         body: ListView.builder(
// //           itemCount: _vehicleProfiles.profiles.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             return ListTile(
// //               leading: Image.network(_vehicleProfiles.profiles[index].image),
// //               title: Text(
// //                 '${_vehicleProfiles.profiles[index].make} ${_vehicleProfiles.profiles[index].model}',
// //               ),
// //               subtitle: Text(
// //                 'Year: ${_vehicleProfiles.profiles[index].year}, Color: ${_vehicleProfiles.profiles[index].color}',
// //               ),
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => ProfileDetailsScreen(
// //                       profile: _vehicleProfiles.profiles[index],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           },
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //           onPressed: () {
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => CreateProfileScreen(
// //                   onProfileCreated: (profile) {
// //                     _vehicleProfiles.addProfile(profile);
// //                     Navigator.pop(context);
// //                   },
// //                 ),
// //               ),
// //             );
// //           },
// //           child: Icon(Icons.add),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // Step 5: Create a screen to display the details of a selected profile
// class ProfileDetailsScreen extends StatelessWidget {
//   final VehicleProfile profile;

//   ProfileDetailsScreen({required this.profile});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${profile.make} ${profile.model}'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(profile.image),
//             SizedBox(height: 16),
//             Text(
//               'Year: ${profile.year}',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Color: ${profile.color}',
//               style: TextStyle(fontSize: 24),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Step 6: Create a screen to allow the user to create a new profile
// class CreateProfileScreen extends StatefulWidget {
//   final Function(VehicleProfile) onProfileCreated;

//   CreateProfileScreen({required this.onProfileCreated});

//   @override
//   _CreateProfileScreenState createState() => _CreateProfileScreenState();
// }

// class _CreateProfileScreenState extends State<CreateProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _makeController = TextEditingController();
//   final _modelController = TextEditingController();
//   final _yearController = TextEditingController();
//   final _colorController = TextEditingController();
//   final _imageController = TextEditingController();

//   @override
//   void dispose() {
//     _makeController.dispose();
//     _modelController.dispose();
//     _yearController.dispose();
//     _colorController.dispose();
//     _imageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Profile'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _makeController,
//                 decoration: InputDecoration(
//                   labelText: 'Make',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a make';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _modelController,
//                 decoration: InputDecoration(
//                   labelText: 'Model',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a model';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _yearController,
//                 decoration: InputDecoration(
//                   labelText: 'Year',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a year';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _colorController,
//                 decoration: InputDecoration(
//                   labelText: 'Color',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a color';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _imageController,
//                 decoration: InputDecoration(
//                   labelText: 'Image URL',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an image URL';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     widget.onProfileCreated(
//                       VehicleProfile(
//                         make: _makeController.text,
//                         model: _modelController.text,
//                         year: int.parse(_yearController.text),
//                         color: _colorController.text,
//                         image: _imageController.text,
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Create'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
