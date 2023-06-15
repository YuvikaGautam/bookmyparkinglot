import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

String ownerBaseUrl =
    "https://bookingowner-production.up.railway.app/OwnerDetails";
String userBaseUrl =
    "https://userbookingapi-production.up.railway.app/UserBooking";

Future<bool> addUserDetails(String userId, String fname, String lname,
    String vehicleType, String vehicleModel, String vehicleNumber) async {
  String vehicleId = DateTime.now().millisecondsSinceEpoch.toString();
  Map data = {
    "userId": userId,
    "fname": fname,
    "lname": lname,
    "minutesSaved": 0,
    "isTowed": false,
    "message": 0,
    "vdetails": [
      {
        "vehicleId": vehicleId,
        "vehicleType": vehicleType,
        "vehicleName": vehicleModel,
        "vehicleNo": vehicleNumber
      }
    ],
    "defaultvehicle": {"default": true, "vehicleId": vehicleId},
    "tickets": [],
  };
  print(data);
  print(json.encode(data));
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
      await http.get(Uri.parse('$ownerBaseUrl/GetAllOwnerDetailsnophoto'));
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return [];
  }
}

Future<Map> getLatestTicket(String id) async {
  http.Response response = await http.get(
      Uri.parse('$userBaseUrl/621LkZwm6dO9pbaIz9PFu2xSuQ72/latest-ticket'));
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return {};
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
      await http.get(Uri.parse('$ownerBaseUrl/owners/$id'));
  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    return {};
  }
}

Future<List> fetchVehicleProfiles(String id) async {
  http.Response response = await http
      .get(Uri.parse('$userBaseUrl/621LkZwm6dO9pbaIz9PFu2xSuQ72/vehicle'));
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return [];
  }
}

Future<Map> fetchDefaultVehicle(String id) async {
  http.Response response = await http
      .get(Uri.parse('$userBaseUrl/GetById/621LkZwm6dO9pbaIz9PFu2xSuQ72'));
  print(json.decode(response.body));
  if (response.statusCode == 200) {
    return json.decode(response.body)['defaultvehicle'];
  } else {
    return {};
  }
}

Future<bool> setDefaultVehicleProfile(String id) async {
  Map data = {"default": true, "vehicleId": id};
  http.Response response = await http.put(
      Uri.parse('$userBaseUrl/SetDefaultVehicle/621LkZwm6dO9pbaIz9PFu2xSuQ72'),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"});
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> addVehicleProfile(String id, String vehicleNumber,
    String vehicleType, String vehicleModel) async {
  String vehicleId = DateTime.now().millisecondsSinceEpoch.toString();
  List data = [
    {
      "vehicleId": vehicleId,
      "vehicleType": vehicleType,
      "vehicleName": vehicleModel,
      "vehicleNo": vehicleNumber
    }
  ];
  print(data);
  print(json.encode(data));
  http.Response response = await http.put(
      Uri.parse('$userBaseUrl/VehicleDetails/621LkZwm6dO9pbaIz9PFu2xSuQ72'),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"});
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
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
//         await http.put(Uri.parse('$ownerBaseUrl/UpdateCar/$id'),
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
//         Uri.parse('$ownerBaseUrl/UpdateBike/$id'),
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
Future<bool> updateParkingLotCar(String id, int carSpace) async {
  http.Response response =
      await http.patch(Uri.parse('$ownerBaseUrl/UpdateCar/$id'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode(carSpace));
  if (response.statusCode == 200) {
    print("car updated");
    return true;
  } else {
    print("car not updated");
    return false;
  }
}

Future<int> updateParkingLotBike(String id, int bikeSpace) async {
  http.Response response =
      await http.patch(Uri.parse('$ownerBaseUrl/UpdateBike/$id'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode(bikeSpace));
  if (response.statusCode == 200) {
    print("car updated");
    return bikeSpace;
  } else {
    print("car not updated");
    return bikeSpace;
  }
}

Future<bool> bookTicket(String userId, String ticketId, String ticketIdCheckin,
    String ownerId, int duration) async {
  String bookingtime = DateTime.now().millisecondsSinceEpoch.toString();
  List data = [
    {
      "ticketId": ticketId,
      "activeStatus": "false",
      "ticketIdCheckin": ticketIdCheckin,
      "ownerId": ownerId,
      "bookingtime": bookingtime,
      "duration": duration
    }
  ];
  print(data);
  print(json.encode(data));
  http.Response response = await http.put(
      Uri.parse('$userBaseUrl/Ticket/621LkZwm6dO9pbaIz9PFu2xSuQ72'),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"});
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> addTicketToOwner(String checkInid, String ticketid, String ownerid,
    String userId, String vehicleNumberSub) async {
  Map data = {
    "ticketNumber": checkInid,
    "ticketStatus": false,
    "ticketId": ticketid,
    "ownerId": ownerid,
    "userId": "621LkZwm6dO9pbaIz9PFu2xSuQ72",
    "vehicleNumber": vehicleNumberSub
  };
  print(data);
  print(json.encode(data));
  http.Response response = await http.put(
      Uri.parse('$ownerBaseUrl/owners/$ownerid/tickets'),
      body: json.encode(data),
      headers: {"Content-Type": "application/json"});
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
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
//         await http.put(Uri.parse('$ownerBaseUrl/UpdateCar/$id'),
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
//         Uri.parse('$ownerBaseUrl/UpdateBike/$id'),
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
// Future<bool> generateTicket(String userId, String ownerId, String bookingTime,
//     int duration, String ticketId, String checkoutId) async {
//   Map data = {
//     "tickets": {
//       "ticketId": ticketId,
//       "ticketIdCheckout": checkoutId,
//       "ownerId": ownerId,
//       "bookingtime": bookingTime,
//       "duration": duration,
//       "activeStatus": false,
//     }
//   };
//   print("-----------------------------------");
//   print(json.encode(data));
//   http.Response response =
//       await http.put(Uri.parse('$userBaseUrl/Ticket/$userId'),
//           headers: {
//             "content-type": "application/json",
//           },
//           body: json.encode(data));
//   if (response.statusCode == 200) {
//     print("ticket generated");
//     return true;
//   } else {
//     print("ticket not generated");
//     return false;
//   }
// }

Future<Map> getTicket(String userId) async {
  print(userId);
  http.Response response = await http.get(
      Uri.parse('$userBaseUrl/621LkZwm6dO9pbaIz9PFu2xSuQ72/latest-ticket'));
  if (response.statusCode == 200) {
    print("tickets fetched");
    print(json.decode(response.body));
    return json.decode(response.body);
  } else if (response.statusCode == 500) {
    print("tickets not fetched");
    return {};
  } else {
    print("tickets not fetched");
    return {};
  }
}

Future<List> getallTickets(String userId) async {
  http.Response response =
      await http.get(Uri.parse('$userBaseUrl/$userId/all-tickets'));
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
Future<bool> checkTowed() async {
  String useriD = "621LkZwm6dO9pbaIz9PFu2xSuQ72";
  http.Response response =
      await http.get(Uri.parse('$userBaseUrl/$useriD/isTowed'));
  if (response.statusCode == 200) {
    print("towed status fetched");
    print(response.body);
    return response.body == "true" ? true : false;
  } else {
    print("towed status not fetched");
    return false;
  }
}

Future<int> checkHelp() async {
  String useriD = "621LkZwm6dO9pbaIz9PFu2xSuQ72";
  http.Response response =
      await http.get(Uri.parse('$userBaseUrl/$useriD/message'));
  if (response.statusCode == 200) {
    print("message status fetched");
    print(response.body);
    return int.parse(response.body);
  } else {
    print("message status not fetched");
    return 0;
  }
}

Future<bool> updateDefaultProfile(vehicleProfile) async {
  // Perform your API call
  // Replace this with your actual API call logic
  print('-------------------------Update-------------------------------------');
  bool apiResponse = true; // Replace with your API response logic

  return apiResponse;
}

Future<Map> getDataofUsers(String id) async {
  http.Response response = await http.get(Uri.parse('$userBaseUrl/GetAllData'));
  if (response.statusCode == 200) {
    print("data fetched");
    return json.decode(response.body);
  } else {
    print("data not fetched");
    return {
      "name": "John Doe",
      "email": "johndoe@example.com",
      "phone": "1234567890",
      "vehicleNumber": "ABC123",
      "parkingSlot": "A1",
      "checkInTime": "2023-06-11 10:00 AM",
      "checkOutTime": "2023-06-11 06:00 PM"
    };
  }
}
