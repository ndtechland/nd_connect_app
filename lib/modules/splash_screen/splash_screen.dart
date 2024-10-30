import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/location_controller.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';



import '../../controllers/attendance_controller.dart';
import '../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../controllers/splash_controller/splash_controllers.dart';
import '../../controllers/user_profile_controller/user_profile_controller.dart';
import '../../services_apis/api_servicesss.dart';
import '../../services_apis/auto_login_employee.dart';
import '../../services_apis/autologin_services.dart';
import '../../test/profileUpdate_controller.dart';
import '../all_pages/pages/emploree_pages/home_page_employee.dart';
import '../all_pages/pages/emploree_pages/home_page_employee2.dart';
import '../all_pages/pages/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenControllers>(
        init: SplashScreenControllers(),
        builder: (controller) {
          if (controller.animation.status == AnimationStatus.completed) {
            // Start the timer
            // Timer(Duration(seconds: 2), () async {
            //   try {
            //     // final accountData = await accountService.getAccountData;
            //     final accountData2 = await accountService2.getAccountData2;
            //     // print("AccountData: $accountData");
            //   //  print("AccountData2: $accountData2");
            //
            //     if ( accountData2 != null) {
            //
            //       await _getprofileepersonal.profileemployeeApi();
            //       await _homedashboardController.dashboarddApi();
            //       _homedashboardController.update();
            //       await Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => BottomBar()),
            //       );
            //     }
            //     // else if (accountData2 != null) {
            //     //   await _getprofileepersonal.profileemployeeApi();
            //     //   await _homedashboardController.dashboarddApi();
            //     //   _homedashboardController.update();
            //     //   await Navigator.pushReplacement(
            //     //     context,
            //     //     MaterialPageRoute(builder: (context) => BottomBar()),
            //     //   );
            //     // }
            //     // else if (accountData != null) {
            //     //   await _profileController.profileApi();
            //     //   Navigator.pushReplacement(
            //     //     context,
            //     //     MaterialPageRoute(builder: (context) => Home()),
            //     //   );
            //     // }
            //     else {
            //       await _getprofileepersonal.profileemployeeApi();
            //       await _homedashboardController.dashboarddApi();
            //       _homedashboardController.update();
            //      // await _profileController.profileApi();
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => Login()),
            //       );
            //     }
            //   } catch (error) {
            //     print('Error in SplashScreen: $error');
            //     // Handle error accordingly
            //   }
            // });
            Timer(Duration(seconds: 2), () async {
              try {
                final accountData2 = await accountService2.getAccountData2;
                if (accountData2 != null) {
                  await ApiProvider.RefreshToken();
                  // Auto-login and fetch the necessary data
                  await _getprofileepersonal.profileemployeeApi();
                 // await locationController.checkAndRequestLocationPermission();

                  await locationController.fetchCurrentLocation(
                    // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
                  );
                  await locationController.fetchCompanyLocationApi();
                  await locationController.getCoordinatesFromAddress();
                  await _homedashboardController.dashboarddApi();
                  await attendanceController.AttendanceDetailApi(DateTime.now());
                  await attendanceController.updateAttendaneDetail();
                  await locationController.startSendingLocation();
                  print("Sending splash.");

                  print("attendance activity:${attendanceController.attendanceDetailsModel?.data?.loginStatus}");
                  _homedashboardController.update();
                  Future.delayed(Duration(seconds: 1));
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomBar()),
                  );
                } else {
                  await attendanceController.EmpActivityApi();
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
