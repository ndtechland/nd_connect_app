// import 'dart:convert';
// import 'dart:isolate';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
//
// class LocationTaskHandler extends TaskHandler {
//   SendPort? sendPort;
//
//   @override
//   Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
//     this.sendPort = sendPort;
//     print('Background task started at $timestamp');
//   }
//
//   @override
//   Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
//     try {
//       // Fetch the current location
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       // Prepare the request body
//       final Map<String, dynamic> requestBody = {
//         "CurrentLat": position.latitude.toString(),
//         "Currentlong": position.longitude.toString(),
//         "Userid": 1, // Replace with dynamic User ID if necessary
//       };
//
//       // Send POST request to your API
//       final response = await http.post(
//         Uri.parse('https://api.ndtechland.com/api/EmployeeApi/UpdateEmployeeLocation'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestBody),
//       );
//
//       if (response.statusCode == 200) {
//         print('Location updated successfully: ${response.body}');
//       } else {
//         print('Failed to update location: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error in location fetching or API call: $e');
//     }
//   }
//
//   @override
//   Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
//     print('Background task destroyed at $timestamp');
//   }
//
//   @override
//   void onButtonPressed(String id) {
//     print('Notification button pressed: $id');
//   }
//
//   @override
//   void onNotificationPressed() {
//     print('Notification pressed');
//   }
// }
