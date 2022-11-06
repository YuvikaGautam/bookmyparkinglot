import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

String adminBaseUrl =
    "https://admin-details-bookmyslot.herokuapp.com/AdminDetails";
String userBaseUrl = "https://user-booking-api.herokuapp.com/UserBooking";

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
//       "placeId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "carSpace": carSpace,
//       "parkingManager": "test",
//       "parkingPhNo": "test",
//       "parkingLot": "test",
//       "address": "test"
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
//       "placeId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "bikeSpace": bikeSpace,
//       "parkingManager": "test",
//       "parkingPhNo": "test",
//       "parkingLot": "test",
//       "address": "test",
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
Future<int> updateParkingLotCar(int id, int carSpace) async {
 
  Map data = {
      "placeId": 1,
      "fnameofowner": "test",
      "lnameofowner": "test",
      "password": "test",
      "email": "test",
      "carSpace": carSpace,
      "parkingManager": "test",
      "parkingPhNo": "test",
      "parkingLot": "test",
      "address": "test"
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
Future<int> updateParkingLotBike(int id, int bikeSpace) async {
 
  Map data = {
      "placeId": 1,
      "fnameofowner": "test",
      "lnameofowner": "test",
      "password": "test",
      "email": "test",
      "bikeSpace": bikeSpace,
      "parkingManager": "test",
      "parkingPhNo": "test",
      "parkingLot": "test",
      "address": "test"
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
//       "placeId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "carSpace": carSpace,
//       "parkingManager": "test",
//       "parkingPhNo": "test",
//       "parkingLot": "test",
//       "address": "test"
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
//       "placeId": 1,
//       "fnameofowner": "test",
//       "lnameofowner": "test",
//       "password": "test",
//       "email": "test",
//       "bikeSpace": bikeSpace,
//       "parkingManager": "test",
//       "parkingPhNo": "test",
//       "parkingLot": "test",
//       "address": "test",
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

Future<bool> addBooking(
    int bookingId, String vehicle, int hours, int parkingLotId) async {
  print("in add booking");

  Map data = {
    "bookingID": bookingId,
    "vehicleType": vehicle,
    "date": DateTime.now().toString(),
    "time": hours,
    "placeId": parkingLotId
  };
  http.Response response = await http.post(Uri.parse('$userBaseUrl/AddData'),
      headers: {"content-type": "application/json"},
      body: json.encode(data));
print(json.encode(data));
  print(response.body);
  if (response.statusCode == 200) {
    print("booking added");
    return true;
  } else {
    print("booking not added");
    return false;
  }
}
