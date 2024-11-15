import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
///import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
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
import 'modules/splash_screen/splash_screen.dart';


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
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  //LocalNotificationService.initialize();
  setupLazyLoading();
 // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("mytoken${fcmToken}");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();

 // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  /// await FlutterDownloader.initialize(debug: true);
  /// await requestFilePermission();

  await Permission.storage.request();


  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // This function will run in the background
    LocationController locationController = LocationController();
    //if (task == "sendLocationPeriodic") {
    print("sendLocation :");

      await locationController.startSendingLocation();

   // }
    // Call the sendLocation function
    // await locationController.startSendingLocation();
print("sendLocation in terminated");
print("sendLocation :${locationController.startSendingLocation()}");
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
