import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

String adminBaseUrl =
    "https://bookingadmin-production.up.railway.app/AdminDetails";
String userBaseUrl =
    "https://userbookingapi-production.up.railway.app/UserBooking";

Future<bool> addUserDetails(String userId, String fname, String lname,
    String vehicleType, String vehicleModel, String vehicleNumber) async {
  Map data = {
    "userId": userId,
    "fname": fname,
    "lname": lname,
    "vdetails": {
      "vehicleType": vehicleType,
      "vehicleName": vehicleModel,
      "vehicleNo": vehicleNumber
    }
  };
  print(data);
  http.Response response = await http.post(Uri.parse('$userBaseUrl/AddData'),
      body: json.encode(data), headers: {"Content-Type": "application/json"});
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List> GetParkingLots() async {
  http.Response response =
      await http.get(Uri.parse('$adminBaseUrl/GetAllAdminDetails'));
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return [];
  }
}

// Future<Map<String, dynamic>> fetchTicketData(String userId) {
//   return http.get(Uri.parse('$userBaseUrl/$userId/ticket')).then((response) {
//     if (response.statusCode == 200) {
//       final decoded = json.decode(response.body);
//       return decoded;
//     } else {
//       throw Exception('Failed to load ticket data');
//     }
//   });
// }

Future<Map> ParkingLot(String id) async {
  http.Response response =
      await http.get(Uri.parse('$adminBaseUrl/GetAdminDetails/$id'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    return {};
  }
}

// Future<Map> updateParkingLotDecrease(
//     int id, String typeVehicle, int carSpace, int bikeSpace) async {
//   if (typeVehicle == "car") {
//     carSpace = carSpace - 1;
//     Map data = {
//       "ownerId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "carSpace": carSpace,
//       "pmanager": "test",
//       "pphNo": "test",
//       "plotName": "test",
//       "paddress": "test"
//     };
//     print("-----------------------------------");
//     print(json.encode(data));
//     http.Response response =
//         await http.put(Uri.parse('$adminBaseUrl/UpdateCar/$id'),
//             headers: {
//               "content-type": "application/json",
//             },
//             body: json.encode(data));
//     if (response.statusCode == 200) {
//       print("car updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     } else {
//       print("car not updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     }
//   } else {
//     bikeSpace = bikeSpace - 1;
//     Map data = {
//       "ownerId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "bikeSpace": bikeSpace,
//       "pmanager": "test",
//       "pphNo": "test",
//       "plotName": "test",
//       "paddress": "test",
//     };
//     print("-----------------------------------");
//     print(data);
//     http.Response response = await http.put(
//         Uri.parse('$adminBaseUrl/UpdateBike/$id'),
//         headers: {"content-type": "application/json"},
//         body: json.encode(data));
//     if (response.statusCode == 200) {
//       print("bike updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     } else {
//       print("bike not updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     }
//   }
// }
Future<int> updateParkingLotCar(String id, int carSpace) async {
  Map data = {
    "carSpace": carSpace,
  };
  print("-----------------------------------");
  print(json.encode(data));
  http.Response response =
      await http.put(Uri.parse('$adminBaseUrl/UpdateCar/$id'),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(data));
  if (response.statusCode == 200) {
    print("car updated");
    return carSpace;
  } else {
    print("car not updated");
    return carSpace;
  }
}

Future<int> updateParkingLotBike(String id, int bikeSpace) async {
  Map data = {
    "bikeSpace": bikeSpace,
  };
  print("-----------------------------------");
  print(json.encode(data));
  http.Response response =
      await http.put(Uri.parse('$adminBaseUrl/UpdateBike/$id'),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(data));
  if (response.statusCode == 200) {
    print("car updated");
    return bikeSpace;
  } else {
    print("car not updated");
    return bikeSpace;
  }
}

// Future<Map> updateParkingLotIncrease(
//     int id, String typeVehicle, int carSpace, int bikeSpace) async {
//   if (typeVehicle == "car") {
//     carSpace = carSpace + 1;
//     Map data = {
//       "ownerId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "carSpace": carSpace,
//       "pmanager": "test",
//       "pphNo": "test",
//       "plotName": "test",
//       "paddress": "test"
//     };
//     print("-----------------------------------");
//     print(json.encode(data));
//     http.Response response =
//         await http.put(Uri.parse('$adminBaseUrl/UpdateCar/$id'),
//             headers: {
//               "content-type": "application/json",
//             },
//             body: json.encode(data));
//     if (response.statusCode == 200) {
//       print("car updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     } else {
//       print("car not updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     }
//   } else {
//     bikeSpace = bikeSpace + 1;
//     Map data = {
//       "ownerId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "bikeSpace": bikeSpace,
//       "pmanager": "test",
//       "pphNo": "test",
//       "plotName": "test",
//       "paddress": "test",
//     };
//     print("-----------------------------------");
//     print(data);
//     http.Response response = await http.put(
//         Uri.parse('$adminBaseUrl/UpdateBike/$id'),
//         headers: {"content-type": "application/json"},
//         body: json.encode(data));
//     if (response.statusCode == 200) {
//       print("bike updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     } else {
//       print("bike not updated");
//       return {"bikeSpace": bikeSpace, "carSpace": carSpace};
//     }
//   }
// }
Future<bool> generateTicket(String userId, String ownerId, String bookingTime,
    int duration, String ticketId, String checkoutId) async {
  Map data = {
    "tickets": {
      "ticketId": ticketId,
      "ticketIdCheckout": checkoutId,
      "ownerId": ownerId,
      "bookingtime": bookingTime,
      "duration": duration,
      "activeStatus": false,
    }
  };
  print("-----------------------------------");
  print(json.encode(data));
  http.Response response =
      await http.put(Uri.parse('$userBaseUrl/Ticket/$userId'),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(data));
  if (response.statusCode == 200) {
    print("ticket generated");
    return true;
  } else {
    print("ticket not generated");
    return false;
  }
}

Future<Map> getTicket(String userId) async {
  print(userId);
  http.Response response =
      await http.get(Uri.parse('$userBaseUrl/$userId/tickets'));
  if (response.statusCode == 200) {
    print("tickets fetched");
    return json.decode(response.body);
  } else {
    print("tickets not fetched");
    return json.decode(response.body);
  }
}

// Future<bool> checkCheckInStatus() async {
//   http.Response response =
//       await http.get(Uri.parse('$userBaseUrl/CheckInStatus'));
//   if (response.statusCode == 200) {
//     print("status fetched");
//     return true;
//   } else {
//     print("status not fetched");
//     return false;
//   }
// }

// Future<bool> addBooking(
//     int bookingId, String vehicle, int hours, String parkingLotId) async {
//   print("in add booking");

//   Map data = {
//     "bookingID": bookingId,
//     "vehicleType": vehicle,
//     "date": DateTime.now().toString(),
//     "time": hours,
//     "ownerId": parkingLotId
//   };
//   http.Response response = await http.post(Uri.parse('$userBaseUrl/AddData'),
//       headers: {"content-type": "application/json"}, body: json.encode(data));
//   print(json.encode(data));
//   print(response.body);
//   if (response.statusCode == 200) {
//     print("booking added");
//     return true;
//   } else {
//     print("booking not added");
//     return false;
//   }
// }
