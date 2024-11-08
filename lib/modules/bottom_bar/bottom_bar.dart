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
import '../../controllers/event_controller2.dart';
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
  final EventController2 eventsController2 = Get.put(EventController2());

  @override
  void initState() {
    super.initState();
    // Initial data fetching
    dateTimeController.currentTime.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dateTaskController.TaskAssignApi();
      print("events: ${eventsController.events}");
      eventsController.EventsApi();
      eventsController2.EventsHolidayApi();
      attendanceController.AttendanceDetailApi(DateTime.now());
      print("attendanceStatusINit:${attendanceController.attendanceDetailsModel?.data?.loginStatus}");
      _homedashboardController.dashboarddApi();
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
                await attendanceController.AttendanceDetailApi(DateTime.now());
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




