// import 'package:nd_connect_techland/components/styles.dart';
// import 'package:nd_connect_techland/modules/all_pages/events/events_calender.dart';
// import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/employee_profile_nd.dart';
// import 'package:nd_connect_techland/modules/all_pages/pages/profile.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:flutter/material.dart';
// import '../all_pages/pages/emploree_pages/home_page_employee.dart';
// import '../all_pages/pages/emploree_pages/home_page_employee2.dart';
// import '../all_pages/pages/emploree_pages/profile_employee/profile_employee.dart';
// import '../all_pages/pages/emploree_pages/profile_employee/update_add_profile/personal_information_update.dart';
// import '../all_pages/pages/emploree_pages/support_comman_page.dart';
// import '../all_pages/pages/settings.dart';
//
//
// class BottomBar extends StatelessWidget {
//    BottomBar({super.key});
//   List<PersistentBottomNavBarItem> _navBarItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: "Home",
//         activeColorPrimary: appColor2,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.settings,),
//         title: ("Settings"),
//         activeColorPrimary: logocolorlite,
//         activeColorSecondary: appColor2,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.location_on,color: Colors.white,),
//         title: ("Location"),
//         activeColorPrimary: logocolorlite,
//         activeColorSecondary: appColor2,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.event,),
//         title: ("Events"),
//         activeColorPrimary: logocolorlite,
//         activeColorSecondary: appColor2,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.dehaze_rounded),
//         title: ("More"),
//         activeColorPrimary: appColor2,
//         inactiveColorPrimary: Colors.grey,
//       ),
//     ];
//   }
//   PersistentTabController _controller =
//   PersistentTabController(initialIndex: 0);
//   List<Widget> _screens() {
//     return [
//       HomeEmployee2(),
//       Settings(),
//       SupportViewHirejobComman(),
//       EventCalendarScreen(),
//       PersonalUpdateProfile()
//    //   EmployeeProfileNd(),
//       // HomeScreen(),    SearchScreen(),    ProfileScreen(),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     PersistentTabView _buildScreens() {
//       return PersistentTabView(
//         context,
//         controller: _controller,
//         screens: _screens(),
//       );
//     }
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _screens(),
//       items: _navBarItems(),
//       confineToSafeArea: true,
//       backgroundColor: Colors.white, // Default is Colors.white.
//       handleAndroidBackButtonPress: true, // Default is true.
//       resizeToAvoidBottomInset:
//       true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//       stateManagement: true, // Default is true.
//     //  hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         colorBehindNavBar: Colors.white,
//       ),
//       // popAllScreensOnTapOfSelectedTab: true,
//       // popActionScreens: PopActionScreensType.all,
//       // itemAnimationProperties: const ItemAnimationProperties(
//       //   // Navigation Bar's items animation properties.
//       //   duration: Duration(milliseconds: 200),
//       //   curve: Curves.ease,
//       // ),
//       // screenTransitionAnimation: const ScreenTransitionAnimation(
//       //   // Screen transition animation on change of selected tab.
//       //   animateTabTransition: true,
//       //   curve: Curves.ease,
//       //   duration: Duration(milliseconds: 200),
//       // ),
//       navBarStyle:
//       NavBarStyle.style15, // Choose the nav bar style with this property.
//     );
//     }
//   }
//
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:nd_connect_techland/services_apis/fcm.dart';
import 'package:nd_connect_techland/services_apis/notification_service.dart';

import '../../controllers/bottom_nav_controller.dart';
import '../../controllers/location_controller.dart';
import '../../services_apis/local_notification_service.dart';
import '../../widget/upload_button.dart';
import '../all_pages/attendance/attendanceBottomSheet.dart';
import '../all_pages/events/events_calender.dart';
import '../all_pages/pages/emploree_pages/home_page_employee2.dart';
import '../all_pages/pages/emploree_pages/task.dart';
import '../all_pages/pages/emploree_pages/profile_employee/update_add_profile/personal_information_update.dart';
import '../all_pages/pages/emploree_pages/support_comman_page.dart';
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
import 'custom_bottom_bar.dart';

// class BottomBar extends StatelessWidget {
//   final BottomNavController controller = Get.put(BottomNavController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         switch (controller.selectedIndex.value) {
//           case 0:
//             return HomeEmployee2();
//           case 1:
//             return Settings();
//           case 2:
//             return Attendance();
//           case 3:
//             return EventCalendarScreen();
//           case 4:
//             return TaskList();
//           default:
//             return HomeEmployee2();
//         }
//       }),
//       bottomNavigationBar: Stack(
//         clipBehavior: Clip.none, // Allows part of the button to overflow
//         children: [
//           // Bottom Navigation Bar for the 4 normal tabs
//           Obx(() => BottomNavigationBar(
//             backgroundColor: appColor2,
//             currentIndex: controller.selectedIndex.value,
//             onTap: (index) {
//               if (index == 2) {
//                 // Open the bottom sheet for attendance
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   backgroundColor: Colors.transparent, // Make background transparent
//                   builder: (BuildContext context) {
//                     return DraggableScrollableSheet(
//                       initialChildSize: 0.5, // Set to half the screen
//                       minChildSize: 0.3,
//                       maxChildSize: 0.8,
//                       builder: (_, controller) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//                           ),
//                           child: AttendanceBottomSheet(), // The content of the bottom sheet
//                         );
//                       },
//                     );
//                   },
//                 );
//               } else {
//                 // Change tab index for other tabs
//                 controller.changeTabIndex(index);
//               }
//               // if (index != 2) {
//               //   controller.changeTabIndex(index);
//               // }
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
//                 icon: SizedBox.shrink(), // Empty space for middle tab
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
//             selectedLabelStyle: TextStyle(
//               fontWeight: FontWeight.w600
//             ),
//           )),
//           // Elevated middle tab (action button)
//           Positioned(
//             bottom: 20, // Adjust to lift the button above the bottom navigation bar
//             left: MediaQuery.of(context).size.width / 2 - 30, // Center it
//             child: GestureDetector(
//               onTap: () {
//                 controller.changeTabIndex(2);
//               },
//               child: Obx(() => Container(
//                 height: 60, // Adjust height for the button
//                 width: 60, // Adjust width for the button
//                 decoration: BoxDecoration(
//                   // gradient: controller.isActive.value ?
//                   // LinearGradient(
//                   //   begin: Alignment.topCenter,
//                   //     end: Alignment.bottomCenter,
//                   //     colors: [
//                   //   linkedinColor,
//                   //   appColor2
//                   // ]): LinearGradient(
//                   //     begin: Alignment.topCenter,
//                   //     end: Alignment.bottomCenter,
//                   //     colors: [
//                   //   appColor2,
//                   //   linkedinColor
//                   // ]),
//                   color: controller.isActive.value ? Colors.white : appColorr2, // Change color based on isActive
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 8,
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.location_on,
//                   color: controller.isActive.value ? appColor2 : Colors.grey,
//                   size: 36,
//                 ),
//               )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// @pragma('vm:entry-point')
// Future<void> _firebaseBackgroundHandler() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// }

const task = 'firstTask';
class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final BottomNavController controller = Get.put(BottomNavController());

  final LocationController locationController = Get.put(LocationController());
  NotificationService notificationService = NotificationService();
  final AttendanceController attendanceController = Get.put(AttendanceController());
@override
void initState(){
  super.initState();
  notificationService.notificationRequestPermission();
  notificationService.getDeviceToken();
  //FcmService.firebaseInit();
  attendanceController.fetchAttendanceData();
  LocalNotificationService.initialize(context);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotificationService.createanddisplaynotification(message);
  });
  FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");
        _handleMessage(message);
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => DemoScreen(
        //         id: message.data['_id'],
        //       ),
        //     ),
        //   );
        // }
      }
    },
  );

  // 2. This method only call when App in forground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
        (message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);

      }
    },
  );

  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("message.data22 ${message.data['_id']}");
        _handleMessage(message);

      }
    },
  );
}
  void _handleMessage(RemoteMessage message) {
    if (message.data.containsKey('id')) {
      String id = message.data['id'];
      // Navigate to a specific page based on the id
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => BottomBar(id: id), // Pass the id to your page
      //   ),
      // );
    }
  }


  @override
  Widget build(BuildContext context) {
  // LocalNotificationService.initialize(context);
    // Function to show the right-side modal in landscape
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
               // color: Colors.yellow,
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
        // Open a bottom sheet from the right side in landscape mode
        print("Opening bottom sheet from right side in landscape mode");
        showModalRightSheet(context);
      } else {
        // Open a bottom sheet from the bottom in portrait mode
        print("Opening bottom sheet for attendance in portrait mode");
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
                    //color: Colors.yellow,
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

    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return HomeEmployee2();
          case 1:
            return Settings(id: '14',);
          case 2:
            return Attendance(id: '13',); // Background screen when bottom sheet opens
          case 3:
            return EventCalendarScreen(id: '12',);
          case 4:
            //return UpdateButton();
            return TaskList(id: '11',);
          default:
            return HomeEmployee2();
        }
      }),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(() => BottomNavigationBar(
            backgroundColor: appColor2,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              if (index == 2) {
                print("Middle button tapped!"); // Debug print statement
                showAttendanceBottomSheet(context); // Open the bottom sheet
              } else {
                print("Tab changed to index $index");
                controller.changeTabIndex(index);
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
          )),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () async{
                print("Middle button tapped!");
                await locationController.getCoordinatesFromAddress(
                   // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
                );
                showAttendanceBottomSheet(context);
              },
              child: Obx(() => Material(
                shape: CircleBorder(),
                elevation: 0,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: controller.isActive.value ? Colors.white : appColor2,
                    border: Border.all(color: Colors.white,width: 4),
                    shape: BoxShape.circle,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black26,
                    //     blurRadius: 8,
                    //   ),
                    // ],
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: controller.isActive.value ? appColor2 : Colors.grey,
                    size: 36,
                  ),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}



