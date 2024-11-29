import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/location_controller.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';
import 'package:workmanager/workmanager.dart';
import '../../controllers/attendance_controller.dart';
import '../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../controllers/splash_controller/splash_controllers.dart';
import '../../services_apis/api_servicesss.dart';
import '../../services_apis/auto_login_employee.dart';
import '../../test/profileUpdate_controller.dart';
import '../all_pages/pages/login.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final EmployeeLoginController employeeLoginController = Get.put(EmployeeLoginController());
  final LocationController locationController = Get.put(LocationController());
  // final ProfileController _profileController = Get.put(ProfileController());
  final ProfileEmployeeController _getprofileepersonal =
      Get.put(ProfileEmployeeController());
  final HomedashboardController _homedashboardController =
      Get.put(HomedashboardController());
  final ProfileUpdateController profileController = Get.put(
      ProfileUpdateController(apiService: ApiProvider()));
  final AttendanceController attendanceController = Get.put(AttendanceController());

  Future<void> callbackDispatcher() async {
    Workmanager().executeTask((task, inputData) async {
      print("sendLocation execute:");

      // This function will run in the background
      LocationController locationController = LocationController();
      if (task == "sendLocationPeriodic") {
        print("sendLocation splash :");

        await locationController.startSendingLocation();

      }
      // Call the sendLocation function
      // await locationController.startSendingLocation();
      print("sendLocation in terminated");
      print("sendLocation splash:${locationController.latitude()}");
      return Future.value(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenControllers>(
        init: SplashScreenControllers(),
        builder: (controller) {
          if (controller.animation.status == AnimationStatus.completed) {
            Timer(Duration(seconds: 2), () async {
              try {
                final accountData2 = await accountService2.getAccountData2;
                if (accountData2 != null) {
                  await ApiProvider.RefreshToken();
                  await attendanceController.AttendanceDetailApi(DateTime.now());

                  // Auto-login and fetch the necessary data
                  await _getprofileepersonal.profileemployeeApi();
                 // await locationController.checkAndRequestLocationPermission();

                  // await locationController.fetchCurrentLocation(
                  //   // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
                  // );
                  // await locationController.fetchCompanyLocationApi();
                  // await locationController.getCoordinatesFromAddress();
                  await _homedashboardController.dashboarddApi();
                  // await attendanceController.AttendanceDetailApi(DateTime.now());
                //  await attendanceController.updateAttendaneDetail();
                  await locationController.startSendingLocation();
                  await _getprofileepersonal.profileEmployeBankApi();
                  await employeeLoginController.deviceTokenId();
                  await callbackDispatcher();
                  print("Sending splash.");
                  print("attendance activity:${attendanceController.attendanceDetailsModel?.data?.loginStatus}");
                  _homedashboardController.update();
                  Future.delayed(Duration(seconds: 1));
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomBar()),
                  );
                } else {
                  await attendanceController.AttendanceDetailApi(DateTime.now());
                  print("attendance activity:${attendanceController.attendanceActivityModel?.data?.loginStatus}");
                  // Navigate to the login page if no account is stored
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
              } catch (error) {
                print('Error in SplashScreen: $error');
                // Handle error accordingly
              }
            });

          }

          return Center(
            child: AnimatedBuilder(
              animation: controller.animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: controller.animation.value * 2,
                  child: Image.asset(
                    'lib/assets/logo/logoo.png',
                    width: 150,
                    height: 200,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
