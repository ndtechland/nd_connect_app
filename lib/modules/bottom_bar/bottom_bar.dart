import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import 'package:nd_connect_techland/controllers/task_list_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:nd_connect_techland/services_apis/notification_service.dart';
import '../../controllers/bottom_nav_controller.dart';
import '../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../controllers/employeee_controllersss/timer_controller.dart';
import '../../controllers/events_controller.dart';
import '../../controllers/location_controller.dart';
import '../../services_apis/local_notification_service.dart';
import '../../widget/upload_button.dart';
import '../all_pages/attendance/attendanceBottomSheet.dart';
import '../all_pages/events/events_calender.dart';
import '../all_pages/pages/emploree_pages/home_page_employee2.dart';
import '../all_pages/task/task.dart';
import '../all_pages/pages/settings.dart';
import 'package:get/get.dart';

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

const task = 'firstTask';

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

  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isActive = ValueNotifier<bool>(false);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final DateTimeController dateTimeController = Get.put(DateTimeController());
  final DateTaskController dateTaskController = Get.put(DateTaskController());
  final EventsController eventsController = Get.put(EventsController());

  @override
  void initState() {
    super.initState();
    // Initial data fetching
    dateTimeController.currentTime.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dateTaskController.TaskAssignApi();
      print("events: ${eventsController.events}");
      eventsController.EventsApi();
      attendanceController.AttendanceDetailApi();
      _homedashboardController.dashboarddApi();
      locationController.fetchCurrentLocation();
      // locationController.startSendingLocation();
      locationController.getCoordinatesFromAddress();
      locationController.updateDistanceFromCompany();
      notificationService.notificationRequestPermission();
      notificationService.getDeviceToken();
      locationController.fetchCurrentLocation();
      locationController.fetchCompanyLocationApi();
      locationController.updateDistanceFromCompany();
      attendanceController.fetchAttendanceData();
      attendanceController.EmpActivityApi();
      LocalNotificationService.initialize(context);
    });

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
              return Settings(id: '14');
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
              if (index == 2) {
                showAttendanceBottomSheet(context);
              } else {
                setState(() {
                  selectedIndex.value = index;
                });
              }
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

// class BottomBar extends StatefulWidget {
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }
//
// class _BottomBarState extends State<BottomBar> {
//   final BottomNavController controller = Get.put(BottomNavController());
//   ProfileEmployeeController profileEmployeeController = Get.put(ProfileEmployeeController());
//   HomedashboardController _homedashboardController = Get.put(HomedashboardController());
//   final LocationController locationController = Get.put(LocationController());
//   NotificationService notificationService = NotificationService();
//   final AttendanceController attendanceController = Get.put(AttendanceController());
// @override
// void initState(){
//   super.initState();
//   _homedashboardController.dashboarddApi();
//   // locationController.isUserWithinCompanyRadius(locationController.companyLatitude.value, locationController.companyLongitude.value, locationController.companyRadius.string);
//   // if(locationController.distanceFromCompany > locationController.companyRadius.value){}
//   locationController.fetchCurrentLocation();
//   locationController.getCoordinatesFromAddress();
//   locationController.updateDistanceFromCompany();
//   print("distanceeee:${locationController.distanceFromCompany.value}");
//   notificationService.notificationRequestPermission();
//   notificationService.getDeviceToken();
//   locationController.fetchCurrentLocation(
//     // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
//   );
//   locationController.fetchCompanyLocationApi();
//   locationController.getCoordinatesFromAddress();
//   // _homedashboardController.dashboarddApi();
//   //FcmService.firebaseInit();
//   attendanceController.fetchAttendanceData();
//   LocalNotificationService.initialize(context);
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     LocalNotificationService.createanddisplaynotification(message);
//   });
//   FirebaseMessaging.instance.getInitialMessage().then(
//         (message) {
//       print("FirebaseMessaging.instance.getInitialMessage");
//       if (message != null) {
//         print("New Notification");
//         _handleMessage(message);
//         // if (message.data['_id'] != null) {
//         //   Navigator.of(context).push(
//         //     MaterialPageRoute(
//         //       builder: (context) => DemoScreen(
//         //         id: message.data['_id'],
//         //       ),
//         //     ),
//         //   );
//         // }
//       }
//     },
//   );
//
//   // 2. This method only call when App in forground it mean app must be opened
//   FirebaseMessaging.onMessage.listen(
//         (message) {
//       print("FirebaseMessaging.onMessage.listen");
//       if (message.notification != null) {
//         print(message.notification!.title);
//         print(message.notification!.body);
//         print("message.data11 ${message.data}");
//         LocalNotificationService.createanddisplaynotification(message);
//
//       }
//     },
//   );
//
//   // 3. This method only call when App in background and not terminated(not closed)
//   FirebaseMessaging.onMessageOpenedApp.listen(
//         (message) {
//       print("FirebaseMessaging.onMessageOpenedApp.listen");
//       if (message.notification != null) {
//         print(message.notification!.title);
//         print(message.notification!.body);
//         print("message.data22 ${message.data['_id']}");
//         _handleMessage(message);
//
//       }
//     },
//   );
// }
//   void _handleMessage(RemoteMessage message) {
//     if (message.data.containsKey('id')) {
//       String id = message.data['id'];
//       // Navigate to a specific page based on the id
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => BottomBar(id: id), // Pass the id to your page
//       //   ),
//       // );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//   // LocalNotificationService.initialize(context);
//     // Function to show the right-side modal in landscape
//     void showModalRightSheet(BuildContext context) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.6,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                // color: Colors.yellow,
//                 borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0)),
//               ),
//               child: AttendanceBottomSheet(),
//             ),
//           );
//         },
//       );
//     }
//     void showAttendanceBottomSheet(BuildContext context) {
//       final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//       if (isLandscape) {
//         // Open a bottom sheet from the right side in landscape mode
//         print("Opening bottom sheet from right side in landscape mode");
//         showModalRightSheet(context);
//       } else {
//         // Open a bottom sheet from the bottom in portrait mode
//         print("Opening bottom sheet for attendance in portrait mode");
//         showModalBottomSheet(
//           context: context,
//           isScrollControlled: true,
//           backgroundColor: Colors.transparent,
//           builder: (context) {
//             return DraggableScrollableSheet(
//               initialChildSize: 0.5,
//               minChildSize: 0.3,
//               maxChildSize: 0.8,
//               builder: (_, controller) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     //color: Colors.yellow,
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
//                   ),
//                   child: AttendanceBottomSheet(),
//                 );
//               },
//             );
//           },
//         );
//       }
//     }
//
//     return Scaffold(
//       body:
//       Obx(() {
//         switch (controller.selectedIndex.value) {
//           case 0:
//             return HomeEmployee2();
//           case 1:
//             return Settings(id: '14',);
//           case 2:
//             return Attendance(id: '13',); // Background screen when bottom sheet opens
//           case 3:
//             return EventCalendarScreen(id: '12',);
//           case 4:
//             //return UpdateButton();
//             return TaskList(id: '11',);
//           default:
//             return HomeEmployee2();
//         }
//       }),
//       bottomNavigationBar: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           //Obx(() =>
//               BottomNavigationBar(
//             backgroundColor: appColor2,
//             currentIndex: controller.selectedIndex.value,
//             onTap: (index) {
//               if (index == 2) {
//                 print("Middle button tapped!"); // Debug print statement
//                 showAttendanceBottomSheet(context); // Open the bottom sheet
//               } else {
//                 print("Tab changed to index $index");
//                 controller.changeTabIndex(index);
//               }
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.settings),
//                 label: 'Settings',
//               ),
//               BottomNavigationBarItem(
//                 icon: SizedBox.shrink(), // Placeholder for middle tab
//                 label: '',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.event),
//                 label: 'Events',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.task_outlined),
//                 label: 'Task',
//               ),
//             ],
//             selectedItemColor: Colors.white,
//             unselectedItemColor: Colors.grey,
//             type: BottomNavigationBarType.fixed,
//             selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//           ),
//          // ),
//           Positioned(
//             bottom: 20,
//             left: MediaQuery.of(context).size.width / 2 - 30,
//             child: GestureDetector(
//               onTap: () async{
//                 print("Middle button tapped!");
//                 // WidgetsBinding.instance.addPostFrameCallback((_) async {
//                 //   await locationController.checkAndRequestLocationPermission();
//                 //   await locationController.fetchCurrentLocation();
//                 //   await locationController.fetchCompanyLocationApi();
//                 //   await locationController.getCoordinatesFromAddress();
//                 //   showAttendanceBottomSheet(context);
//                 // });
//                 await locationController.checkAndRequestLocationPermission();
//                 //await locationController;
//                 await locationController.fetchCurrentLocation(
//                    // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
//                 );
//                 await locationController.fetchCompanyLocationApi();
//                 await locationController.getCoordinatesFromAddress();
//
//                 showAttendanceBottomSheet(context);
//                await locationController.updateDistanceFromCompany();
//
//               },
//               child:
//               //Obx(() =>
//                   Material(
//                 shape: CircleBorder(),
//                 elevation: 0,
//                 child: Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     color: controller.isActive.value ? Colors.white : appColor2,
//                     border: Border.all(color: Colors.white,width: 4),
//                     shape: BoxShape.circle,
//                     // boxShadow: [
//                     //   BoxShadow(
//                     //     color: Colors.black26,
//                     //     blurRadius: 8,
//                     //   ),
//                     // ],
//                   ),
//                   child:
//                  Obx(() =>
//                   (locationController.isLoading.value)
//     ? Center(child: CircularProgressIndicator(
//                     color: Colors.white,
//                   )) :
//                   Icon(
//                       Icons.location_on,
//                       color: controller.isActive.value ? appColor2 : Colors.grey,
//                       size: 36,
//                     ),
//                  ),
//                 ),
//               )
//               //),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



