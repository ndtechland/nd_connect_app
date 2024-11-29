import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import 'package:nd_connect_techland/controllers/login_controllers/login_controllersss.dart';
import 'package:nd_connect_techland/controllers/task_list_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
import 'package:nd_connect_techland/services_apis/notification_service.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import '../../controllers/bottom_nav_controller.dart';
import '../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../controllers/employeee_controllersss/timer_controller.dart';
import '../../controllers/event_controller2.dart';
import '../../controllers/events_controller.dart';
import '../../controllers/location_controller.dart';
import '../../main.dart';
import '../../services_apis/local_notification_service.dart';
import '../../widget/upload_button.dart';
import '../all_pages/attendance/attendanceBottomSheet.dart';
import '../all_pages/background_service/background_service.dart';
import '../all_pages/events/events_calender.dart';
import '../all_pages/pages/emploree_pages/home_page_employee2.dart';
import '../all_pages/task/task.dart';
import '../all_pages/pages/settings.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
// class BottomBar extends StatelessWidget {
//   final List<Widget> pages = [
//       HomeEmployee2(),
//       Settings(),
//       SupportViewHirejobComman(),
//       EventCalendarScreen(),
//       PersonalUpdateProfile()
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final BottomNavController bottomNavController = Get.put(BottomNavController());
//
//     return Scaffold(
//       body: Obx(() => pages[bottomNavController.selectedIndex.value]),
//       bottomNavigationBar: CustomBottomNavBar(),
//     );
//   }
// }


class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final BottomNavController controller = Get.put(BottomNavController());
  ProfileEmployeeController profileEmployeeController = Get.put(ProfileEmployeeController());
  HomedashboardController _homedashboardController = Get.put(HomedashboardController());
  final LocationController locationController = Get.put(LocationController());
  NotificationService notificationService = NotificationService();
  final AttendanceController attendanceController = Get.put(AttendanceController());
  final EmployeeLoginController employeeLoginController = Get.put(EmployeeLoginController());

  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isActive = ValueNotifier<bool>(false);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final DateTaskController dateTaskController = Get.put(DateTaskController());
  final EventsController eventsController = Get.put(EventsController());
  final EventController2 eventsController2 = Get.put(EventController2());
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;



  @override
  void initState() {
    attendanceController.AttendanceDetailApi(DateTime.now());
    ApiProvider.AttendancedatailUpdate(DateTime.now());
    print("bottomBar");
    // BackgroundService.initializeService();
    // Initial data fetching
    var prefs = GetStorage();
    FlutterBackgroundService();
    //initAutoStart();
    // Read saved user id and token
    final userId = prefs.read("userid").toString();
    // final userId = prefs.getString('userId') ?? '';
    print("bottomBar userId :$userId");
    dateTimeController.currentTime.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationController.fetchCurrentLocation();
      dateTaskController.TaskAssignApi();
      _checkForAppUpdate();
      print("events: ${eventsController.events}");
      eventsController.EventsApi();
      eventsController2.EventsHolidayApi();
      print("attendanceStatusINit:${attendanceController.attendanceDetailsModel?.data?.loginStatus}");
      _homedashboardController.dashboarddApi();
      employeeLoginController.deviceTokenId();
      locationController.fetchCurrentLocation();
      locationController.startSendingLocation();
      locationController.getCoordinatesFromAddress();
      locationController.updateDistanceFromCompany();
      notificationService.notificationRequestPermission();
      notificationService.getDeviceToken();
      locationController.fetchCurrentLocation();
      locationController.fetchCompanyLocationApi();
      locationController.updateDistanceFromCompany();
      attendanceController.fetchAttendanceData();
      attendanceController.EmpActivityApi();
     // attendanceController.updateAttendaneDetail();
      // _homedashboardController.dashboarddApi();

      LocalNotificationService.initialize(context);
      _getLocation();
      _listenLocation();
    });
    var uniqueIdentifier = DateTime.now().second.toString();
    // A perriodic task
    //  Workmanager().registerPeriodicTask(
    //   uniqueIdentifier, taskName, // The task name you defined before
    //   frequency: const Duration(seconds: 15),
    //   // constraints: Constraints(
    //   //   networkType: NetworkType.connected,
    //   // ),
    //   initialDelay: const Duration(seconds: 15),
    // );
    // Firebase notification listeners
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.createanddisplaynotification(message);
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        _handleMessage(message);
      }
    });
    FirebaseMessaging.instance.getToken().then((deviceId) {
      print("Device ID (FCM Token): $deviceId");
    });

    super.initState();
  }
  // Future<void> initAutoStart() async {
  //   try {
  //     //check auto-start availability.
  //     // var test = await (isAutoStartAvailable as FutureOr<bool>);
  //     // print(test);
  //     //if available then navigate to auto-start setting page.
  //     //if (test)
  //     await getAutoStartPermission();
  //   } on PlatformException catch (e) {
  //     print(e);
  //   }
  //   if (!mounted) return;
  // }

  // void onStart(ServiceInstance service) async {
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
  //   Timer.periodic(const Duration(minutes: 15), (timer) async {
  //     var prefs = GetStorage();
  //
  //     // Read saved user id and token
  //     final userId = prefs.read("userid").toString();
  //     // final userId = prefs.getString('userId') ?? '';
  //     final position = await Geolocator.getCurrentPosition();
  //     print("bottom userId :$userId");
  //
  //  //   if (userId.isNotEmpty) {
  //       print("main userId :$userId");
  //       // Replace with your API endpoint
  //       await locationController.startSendingLocation();
  //       print("main userId 1:${locationController.latitude}");
  //
  //     // } else {
  //     //   print('User is not logged in. Skipping API call.');
  //     // }
  //   });
  // }

  // var prefs = GetStorage();
  //
  // // Read saved user id and token
  // final userId = prefs.read("userid").toString();
  // // final userId = prefs.getString('userId') ?? '';
  // // print("bottomBar userId :$userId");
  // void startBackgroundService() async {
  //   final service = FlutterBackgroundService();
  //   service.startService();
  //
  //   // Configure periodic task for background service
  //   service.onStart = () async {
  //     Timer.periodic(Duration(minutes: 15), (timer) async {
  //       if (userId != null) {
  //         // Get the current location
  //         final position = await Geolocator.getCurrentPosition();
  //
  //         // Hit your API with userId and location
  //         final response = await http.post(
  //           Uri.parse("https://example.com/api/endpoint"),
  //           body: jsonEncode({
  //             'userId': userId,
  //             'latitude': position.latitude,
  //             'longitude': position.longitude,
  //           }),
  //           headers: {
  //             'Content-Type': 'application/json',
  //           },
  //         );
  //
  //         if (response.statusCode == 200) {
  //           print("Background API Success: ${response.body}");
  //         } else {
  //           print("Background API Error: ${response.statusCode}");
  //         }
  //       } else {
  //         print("User not logged in. Skipping API call.");
  //       }
  //     });
  //   };}

  _getLocation() async {
    try {
      print("firestore get try");
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('${profileEmployeeController.getprofileemployeeModel?.data?.userid}').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'id': '${profileEmployeeController.getprofileemployeeModel?.data?.userid}'
      }, SetOptions(merge: true));
      print("firestore get");

    } catch (e) {
      print("firestore :$e");
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('${profileEmployeeController.getprofileemployeeModel?.data?.userid}').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': '${profileEmployeeController.getprofileemployeeModel?.data?.fullName}'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
  void _checkForAppUpdate() async {
    try {
      print("update check");
      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        print("update check updateAvailability");

        // For Android (using in_app_update)
        if (updateInfo.immediateUpdateAllowed || updateInfo.flexibleUpdateAllowed) {
          print("update check immediateUpdateAllowed");
          _showUpdateDialog(
              context, 'https://play.google.com/store/apps/details?id=com.ndconnect.nd_connect_techland'); // Play Store URL
        }
      }
      // else {
      //   print("update check else");
      //   // For iOS or manual update flow
      //   _showUpdateDialog(
      //       context, 'https://apps.apple.com/us/app/your-app-id'); // App Store URL
      // }
    } catch (e) {
      print("Error checking for updates: $e");
    }
  }

  void _showUpdateDialog(BuildContext context, String updateUrl) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text(
              'A new version of the app is available. Please update to the latest version for the best experience.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Later'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _launchUpdateUrl(updateUrl); // Open the update URL
              },
              child: Text('Update Now'),
            ),
          ],
        );
      },
    );
  }

  void _launchUpdateUrl(String updateUrl) async {
    if (await canLaunch(updateUrl)) {
      await launch(updateUrl); // Open the update URL
    } else {
      print('Could not launch $updateUrl');
    }
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data.containsKey('id')) {
      String id = message.data['id'];
      // Handle navigation based on the notification
    }
  }

  void showModalRightSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0)),
            ),
            child: AttendanceBottomSheet(),
          ),
        );
      },
    );
  }

  void showAttendanceBottomSheet(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) {
      showModalRightSheet(context);
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (_, controller) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                ),
                child: AttendanceBottomSheet(),
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, index, child) {
          switch (index) {
            case 0:
              return HomeEmployee2();
            case 1:
              return Settingss(id: '14');
            case 2:
              return Attendance(id: '13'); // Background screen when bottom sheet opens
            case 3:
              return EventCalendarScreen(id: '12');
            case 4:
              return TaskList(id: '11');
            default:
              return HomeEmployee2();
          }
        },
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            backgroundColor: appColor2,
            currentIndex: selectedIndex.value,
            onTap: (index) {
              // if (index == 2) {
              //   showAttendanceBottomSheet(context);
              // } else {
                setState(() {
                  selectedIndex.value = index;
                });
             // }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Placeholder for middle tab
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_outlined),
                label: 'Task',
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () async {
                print("Middle button Tapped");
                 locationController.fetchCompanyLocationApi();
                 locationController.getCoordinatesFromAddress();
                _getLocation();
                // await attendanceController.AttendanceDetailApi(DateTime.now());
                Get.to(() => Attendance(id: '13'));
                // Set loading state to true
                // isLoading.value = true;
                // isActive.value = true;
                // try {
                //   if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
                //     await locationController.checkAndRequestLocationPermission();
                //     Get.to(() => Attendance(id: '13'));
                //   } else if(attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
                //     await locationController.checkAndRequestLocationPermission();
                //     await locationController.fetchCurrentLocation();
                //     await locationController.fetchCompanyLocationApi();
                //     await locationController.getCoordinatesFromAddress();
                //     showAttendanceBottomSheet(context);
                //
                //     // Fetch and update distance
                //     await locationController.updateDistanceFromCompany();
                //   }
                //   else{
                //     Get.to(() => Attendance(id: '13'));
                //   }
                // } catch (e) {
                //   print("Error during attendance process: $e");
                // } finally {
                //   // Reset the loading state after operations are complete
                //   isLoading.value = false;
                //   isActive.value = false;
                // }
                print("login status: ${attendanceController.attendanceActivityModel?.data?.loginStatus}");
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: isActive,
                builder: (context, isActiveValue, child) {
                  return Material(
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: isActiveValue ? Colors.white : appColor2,
                        border: Border.all(color: isActiveValue ? appColor2 : Colors.white, width: 4),
                        shape: BoxShape.circle,
                      ),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (context, isLoadingValue, child) {
                          if (isLoadingValue) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: appColor2,
                              ),
                            );
                          } else {
                            return Icon(
                              Icons.location_on,
                              color: isActiveValue ? appColor2 : Colors.grey,
                              size: 36,
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}




