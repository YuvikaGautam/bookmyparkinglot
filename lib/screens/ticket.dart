// import 'package:flutter/material.dart';
// import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timer_count_down/timer_count_down.dart';
// import 'package:custom_timer/custom_timer.dart';

// class TicketPage extends StatefulWidget {
//   final int i;
//   const TicketPage(this.i, {super.key});

//   @override
//   State<TicketPage> createState() => _TicketPageState();
// }

// class _TicketPageState extends State<TicketPage> with WidgetsBindingObserver {
//   late CountdownTimerController controller;
//   int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 300;
//   void setTime() {
//     endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 50;
//     // controller.start();
//   }

//   Future<void> getTimeresume() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey("OldTime")) {
//       int oldTime = prefs.getInt("OldTime")!;
//       int lastEndTime = prefs.getInt("lastEndtime")!;
//       int newTime = DateTime.now().millisecondsSinceEpoch;
//       int diff = newTime - oldTime;
//       prefs.clear();
//       if (diff < lastEndTime) {
//         endTime = lastEndTime - diff;
//       } else {
//         endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
//       }
//     } else {
//       endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
//     }
//   }

//   @override
//   void initState() {
//     setState(() {
//       getTimeresume();
//     });
//     // if(prefs.containsKey("date")){
//     //   getTimeresume();
//     // }

//     // controller = CountdownTimerController(endTime: endTime, onEnd: setTime);
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     switch (state) {
//       case AppLifecycleState.resumed:
//         await getTimeresume();
//         print("resumed");
//         break;
//       case AppLifecycleState.inactive:
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setInt("OldTime", DateTime.now().millisecondsSinceEpoch);
//         prefs.setInt("lastEndtime", endTime);
//         print("inactive");
//         break;
// //make your operations
//       case AppLifecycleState.paused:
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setInt("OldTime", DateTime.now().millisecondsSinceEpoch);
//         prefs.setInt("lastEndtime", endTime);
//         print("paused");
// //make your operations
//         break;
//       case AppLifecycleState.detached:
// //make your operations
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         prefs.setInt("OldTime", DateTime.now().millisecondsSinceEpoch);
//         prefs.setInt("lastEndtime", endTime);
//         print("detached");
//         break;
//       default:
//         break;
//     }
//   }

//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Center(
//   //       child: CountdownTimer(
//   //         controller: controller,
//   //         endTime: endTime,
//   //         widgetBuilder: (context, time) {
//   //           if (time == null) {
//   //             return Text('Game over');
//   //           }
//   //           return Text(
//   //               'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ticket'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("Ticket number: ${widget.i}"),
//             const SizedBox(height: 20),
// // CustomTimer(
// //                 controller: _controller,
// //                 begin: Duration(days: 1),
// //                 end: Duration(),
// //                 builder: (remaining) {
// //                   return Text(
// //                       "${remaining.hours}:${remaining.minutes}:${remaining.seconds}.${remaining.milliseconds}",
// //                       style: TextStyle(fontSize: 24.0));
//                 // }),
//             CountdownTimer(
//               endTime: endTime,
//               widgetBuilder: (context, time) {
//                 if (time == null) {
//                   return Text('Game over');
//                 }
//                 return Text(
//                     'days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
//               },
//             ),
//             ElevatedButton(
//                 onPressed: (() {
//                   setState(() {
//                     setTime();
//                   });
//                 }),
//                 child: const Text("Set time")),
//             // Countdown(
//             //   seconds: widget.i,
//             //   build: (BuildContext context, double time) =>
//             //       Text(time.toString()),
//             //   interval: Duration(milliseconds: 100),
//             //   onFinished: () {
//             //     // Navigator.pop(context);
//             //     print('Timer is done!');
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
