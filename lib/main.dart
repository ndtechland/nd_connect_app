import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
///import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
import 'package:nd_connect_techland/services_apis/local_notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:workmanager/workmanager.dart';
import 'components/styles.dart';
import 'controllers/company_controllers/company_controller.dart';
import 'controllers/company_detail_by_com_id/company_detail_by_id_controller.dart';
import 'controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import 'controllers/employeee_controllersss/payment_get_controller/payment_get_controller.dart';
import 'controllers/location_controller.dart';
import 'controllers/nav_bar_controller/nav_controller.dart';
import 'controllers/user_profile_controller/user_profile_controller.dart';
import 'controllers/view_job_controller/job_controllersss.dart';
import 'test/profile.dart';
import 'package:http/http.dart' as http;
import 'modules/splash_screen/splash_screen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'firebase_options.dart';
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}
void setupLazyLoading() {
  Get.lazyPut(() => BottomNavigationBarController());
  Get.lazyPut(() => AllJibsController());
  //Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => HomedashboardController());
  Get.lazyPut(() => CompanyDetailController());
  Get.lazyPut(() => AllcompanyController());
  // Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => PaymentEmployeeController());
}

// final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
// final FirebaseAnalyticsObserver observer =
// FirebaseAnalyticsObserver(analytics: analytics);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  //LocalNotificationService.initialize();
  setupLazyLoading();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("mytoken${fcmToken}");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  // await GetStorage.init();
  // await initializeService();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  /// await FlutterDownloader.initialize(debug: true);
  /// await requestFilePermission();

  await Permission.storage.request();
  runApp(const MyApp());
}

Future<void> initializeService1() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  print("Background service initialized");
  service.startService();
}

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   await service.configure(
//       androidConfiguration: AndroidConfiguration(
//         // this will be executed when app is in foreground or background in separated isolate
//         onStart: onStart,
//
//         // auto start service
//         autoStart: true,
//         isForegroundMode: true,
//       ),
//       iosConfiguration: IosConfiguration(
//         onForeground: onStart,
//         onBackground: onIosBackground,
//       ),);
// }
//
// bool onIosBackground(ServiceInstance service) {
//   print('iOS background fetch activated');
//   return true;
// }
//
// void onStart(ServiceInstance service) async {
//   print("Service started");
//
//   // Initialize dependencies if needed
//   final prefs = GetStorage();
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   // Periodic task
//   Timer.periodic(const Duration(minutes: 15), (timer) async {
//     try {
//       final userId = prefs.read("userid") ?? '';
//       print("User ID: $userId");
//
//       if (userId.isNotEmpty) {
//         final position = await Geolocator.getCurrentPosition();
//         print("Location: ${position.latitude}, ${position.longitude}");
//
//         // Call your API here
//         print("API call executed for User ID: $userId");
//       } else {
//         print("No user ID found. Skipping API call.");
//       }
//     } catch (e) {
//       print("Error in background service: $e");
//     }
//   });
// }
Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // This will be executed when the app is in foreground or background in a separate isolate
      onStart: onStart,

      // Auto start service
      autoStart: true,
      isForegroundMode: true,

      // Notification for the foreground service
      notificationChannelId: "my_foreground_service",
      initialNotificationTitle: "Background Service",
      initialNotificationContent: "Running in the background",
    ),
    iosConfiguration: IosConfiguration(
      // Runs when the app is in foreground
      onForeground: onStart,

      // Runs when the app is in background
      onBackground: onIosBackground,
    ),
  );
}

bool onIosBackground(ServiceInstance service) {
  print('iOS background fetch activated');
  return true;
}

// void onStart(ServiceInstance service) async {
//   print("Service started");
//
//   // Access SharedPreferences
//   final getStorage =GetStorage();
//   // Access SharedPreferences
//   final prefs = await SharedPreferences.getInstance();
//   final attendanceController = Get.put(AttendanceController());
//   final locationControllr = Get.put(LocationController());
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       print("Set as foreground service");
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       print("Set as background service");
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     print("Service stopped");
//     service.stopSelf();
//   });
//
//   // Polling to check when the user ID is available
//   Timer.periodic(const Duration(seconds: 5), (timer) async {
//     final userId = prefs.getInt("userid");
//     final uId = getStorage.read("userid");
//     print("User ID: $userId");
//     print("uId ID: $uId");
//     if (userId != null && userId > 0) {
//       print("User ID found: $userId. Starting periodic task.");
//       timer.cancel(); // Stop polling once the user ID is found
//
//       // Start the main periodic task
//       Timer.periodic(const Duration(minutes: 15), (innerTimer) async {
//         print("Timer ticked at ${DateTime.now()}");
//         try {
//           if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
//             print("Status: Check-In - Sending location...");
//             await locationControllr.startSendingLocation(); // Call your API logic
//           } else if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
//             print("Status: Check-Out - Stopping timer...");
//             timer.cancel(); // Stop the timer for "Check-Out"
//           } else {
//             print("Unknown status. Timer stopped.");
//             timer.cancel();
//           }
//           // Your periodic task (e.g., send location)
//           print("Valid User ID found. Executing task...");
//           // Call your API or periodic logic here
//           print("Executing API call with User ID: $userId");
//         } catch (e) {
//           print("Error during periodic task: $e");
//         }
//       });
//     } else {
//       print("Waiting for User ID...");
//     }
//   });
// }

void onStart(ServiceInstance service) async {
  print("Service started");
  // final getStorage =GetStorage();
  // Access SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final attendanceController = Get.put(AttendanceController());
  final locationControllr = Get.put(LocationController());
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      print("Set as foreground service");
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      print("Set as background service");
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    print("Service stopped");
    service.stopSelf();
  });
  await locationControllr.startSendingLocation();
  // Periodic task
  // Timer.periodic(const Duration(seconds: 15), (timer) async {
  //   try {
  //     print("Timer ticked at ${DateTime.now()}");
  //
  //     // Retrieve userId from SharedPreferences
  //     final userId = prefs.getInt("userid");
  //     // final uId = getStorage.read("userid");
  //     print("User ID: $userId");
  //     // print("uId ID: $uId");
  //
  //     if (userId != null && userId > 0) {
  //       // if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
  //       print("Status: Check-In - Sending location...");
  //       await locationControllr.sendLocation(); // Call your API logic
  //       // } else if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
  //       //   print("Status: Check-Out - Stopping timer...");
  //       //   timer.cancel(); // Stop the timer for "Check-Out"
  //       // } else {
  //       //   print("Unknown status. Timer stopped.");
  //       //   timer.cancel();
  //       // }
  //       // Your periodic task (e.g., send location)
  //       print("Valid User ID found. Executing task...");
  //       // Add your API call or location logic here
  //     } else {
  //       print("Invalid User ID or not yet saved. Skipping task.");
  //     }
  //   } catch (e) {
  //     print("Error during periodic task: $e");
  //   }
  // });
}





void onStart1(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(minutes: 15), (timer) async {
    var prefs = GetStorage();

    // Read saved user id and token
    final userId = prefs.read("userid").toString();
    // final userId = prefs.getString('userId') ?? '';
    final position = await Geolocator.getCurrentPosition();
    print("main userId :$userId");

    if (userId.isNotEmpty) {
      print("main userId :$userId");
      // Replace with your API endpoint
      await locationController.startSendingLocation();
      print("main userId :${locationController.latitude}");

      // final response = await http.post(
      //   Uri.parse('https://example.com/api/endpoint'),
      //   body: jsonEncode({
      //     'userId': userId,
      //     'latitude': position.latitude,
      //     'longitude': position.longitude,
      //   }),
      //   headers: {
      //     'Content-Type': 'application/json',
      //   },
      // );

      // if (response.statusCode == 200) {
      //   print('API Hit Successful: ${response.body}');
      // } else {
      //   print('API Hit Failed: ${response.statusCode}');
      // }
    } else {
      print('User is not logged in. Skipping API call.');
    }
  });
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("sendLocation execute:");

    // This function will run in the background
    LocationController locationController = LocationController();
    if (task == "sendLocationPeriodic") {
      print("sendLocation :");

      await locationController.startSendingLocation();

    }
    // Call the sendLocation function
    // await locationController.startSendingLocation();
    print("sendLocation in terminated");
    print("sendLocation :${locationController.latitude()}");
    return Future.value(true);
  });
}
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "regular",
        primaryColor: Colors.white,
        //backgroundColor: appColor,
        //dividerColor: Colors.transparent,
      ),
      home: SplashScreen(),
      // Scaffold(
      //   body:
      //
      //       ///HomeEmployee(),
      //       SplashScreen(),
      // ),
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut<BottomNavigationBarController>(
      //       () => BottomNavigationBarController());
      //   Get.lazyPut<AllJibsController>(() => AllJibsController());
      //   Get.lazyPut<ProfileController>(() => ProfileController());
      //   Get.lazyPut<HomedashboardController>(() => HomedashboardController());
      //   Get.lazyPut<AllJibsController>(() => AllJibsController());
      //   Get.lazyPut<CompanyDetailController>(() => CompanyDetailController());
      //   Get.lazyPut<AllcompanyController>(() => AllcompanyController());
      //   Get.lazyPut<ProfileController>(() => ProfileController());
      //
      //   //Profile2Controller
      //   // AllcompanyController _allcompanyController = Get.find();
      //   //   CompanyDetailController _companyDetailController = Get.find();
      //
      //   //HomedashboardController
      // }),
    );
  }
}


// Future<void> requestFilePermission() async {
//   final status = await Permission.storage.request();
//
//   if (status.isGranted) {
//     // Permission granted, proceed with file operations
//     print('Storage permission granted');
//   } else if (status.isDenied) {
//     // Permission denied, but not permanently. You can ask for permission again.
//     print('Storage permission denied');
//   } else if (status.isPermanentlyDenied) {
//     // Permission permanently denied. Show a dialog guiding the user to settings.
//     print('Storage permission permanently denied');
//     // The following part requires context, so it should be called when context is available, e.g., in a widget
//     // showDialog(
//     //   context: context,
//     //   builder: (context) => AlertDialog(
//     //     title: Text('Permission Required'),
//     //     content: Text(
//     //         'This app needs storage access to perform this operation. Please enable it in the app settings.'),
//     //     actions: [
//     //       TextButton(
//     //         onPressed: () {
//     //           Navigator.of(context).pop();
//     //         },
//     //         child: Text('Cancel'),
//     //       ),
//     //       TextButton(
//     //         onPressed: () {
//     //           openAppSettings();
//     //           Navigator.of(context).pop();
//     //         },
//     //         child: Text('Open Settings'),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }


Future<void> requestPermissions() async {
  if (await Permission.storage.request().isGranted) {
    print('Storage permission granted.');
  } else if (await Permission.manageExternalStorage.request().isGranted) {
    print('Manage external storage permission granted.');
  } else {
    print('Permissions denied.');
  }
}