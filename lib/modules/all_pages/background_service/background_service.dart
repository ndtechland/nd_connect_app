// import 'dart:async';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:nd_connect_techland/controllers/location_controller.dart';
//
// class BackgroundService {
//   static Future<void> initializeService() async {
//     final service = FlutterBackgroundService();
//
//     // Define background execution logic
//     await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: true,
//         autoStart: true,
//         notificationChannelId: 'my_background_service',
//         initialNotificationTitle: 'Background Service',
//         initialNotificationContent: 'Running in the background',
//       ),
//       iosConfiguration: IosConfiguration(
//         onForeground: onStart,
//         onBackground: onIosBackground,
//       ),
//     );
//
//     service.startService();
//   }
//
//   static void onStart(ServiceInstance service) async {
//     print("Background Service Started");
//
//     // Initialize GetStorage
//     await GetStorage.init();
//     final prefs = GetStorage();
//
//     // Initialize LocationController
//     final locationController = Get.put(LocationController());
//
//     if (service is AndroidServiceInstance) {
//       service.on('setAsForeground').listen((event) {
//         service.setAsForegroundService();
//       });
//
//       service.on('setAsBackground').listen((event) {
//         service.setAsBackgroundService();
//       });
//     }
//
//     service.on('stopService').listen((event) {
//       service.stopSelf();
//     });
//
//     // Periodic task
//     // Timer.periodic(const Duration(minutes: 15), (timer) async {
//     //   print("Background service timer running...");
//     //   if (service is AndroidServiceInstance && !(service.isForegroundService == true)) {
//     //     return;
//     //   }
//
//       try {
//         print("Background service ");
//
//         // Ensure location permissions
//         final permission = await Geolocator.checkPermission();
//         if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//           await Geolocator.requestPermission();
//         }
//
//         // Get the current position
//         final position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );
//         print("Location: ${position.latitude}, ${position.longitude}");
//
//         // Use the LocationController to start sending location
//         await locationController.sendLocation();
//         print("Location update: ");
//
//       } catch (e) {
//         print("Error in background service: $e");
//       }
//     // });
//   }
//
//   static bool onIosBackground(ServiceInstance service) {
//     WidgetsFlutterBinding.ensureInitialized();
//     print('iOS Background Task Initialized');
//     return true;
//   }
// }
