import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';
import 'package:workmanager/workmanager.dart';
import '../../../components/styles.dart';
import '../../../models/employee_model/autologin_employee_model.dart';
import '../../../services_apis/api_servicesss.dart';
import '../../../services_apis/auto_login_employee.dart';
import '../../employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../location_controller.dart';
import '../employee_dashboard_controller/employee_dashboardcontroller.dart';


// class EmployeeLoginController extends GetxController {
// //   final EmployeeProfileController _employeeprofileController =
// //       Get.put(EmployeeProfileController());
//
//   final ProfileEmployeeController _getprofileepersonal =
//       Get.put(ProfileEmployeeController());
//   HomedashboardController _homedashboardController =
//       Get.put(HomedashboardController());
//   final PaymentEmployeeController _employeeController =
//       Get.put(PaymentEmployeeController());
//
//   final GlobalKey<FormState> loginFormKey2 = GlobalKey<FormState>();
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final RxBool isLoading = false.obs;
//
//   Future<void> loginemployeeApi() async {
//     try {
//       isLoading.value = true;
//
//       final response = await ApiProvider.EmployeeLoginApi(
//         usernameController.text,
//         passwordController.text,
//       );
//       if (response.statusCode == 200) {
//         Get.off(() => BottomBar());
//
//         final accountData = employeeLoginFromJson(response.body);
//
//     //     if (accountData.loginemp?.status == "200") {
//     //       // Fetch profile and dashboard data if login is successful
//     //       _getprofileepersonal.profileemployeeApi();
//     //       _getprofileepersonal.update();
//     //
//     //       await accountService2.setAccountData2(accountData);
//     //       await _homedashboardController.dashboarddApi();
//     //       //Get.off(() => HomeEmployee2());
//     //       Get.off(() => BottomBar());
//     //
//     //       // Navigate based on isPayment status
//     //       // if (accountData.loginemp?.isPayment == true) {
//     //       //   Get.off(() => HomeEmployee());
//     //       // } else {
//     //       //   await _employeeController.paymentemployeeApi();
//     //       //   _employeeController.onInit();
//     //       //   Get.off(() => GetPaymentPage());
//     //       // }
//     //     } else {
//     //       Get.snackbar('Error', 'Failed to login. Status is false.');
//     //     }
//     //   } else {
//     //     Get.snackbar('Error', 'Failed to login. Please try again.');
//     }
//     }
//     catch (e) {
//       print('Error during login: $e');
//       Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
//     } finally {
//       isLoading.value = false;
//     }
//     ///
//
//     //   if (response.statusCode == 200) {
//     //     final accountData2 = employeeLoginFromJson(response.body);
//     //
//     //     if (accountData2.loginemp?.status == "true") {
//     //       // Fetch profile and dashboard data if login is successful
//     //       _getprofileepersonal.profileemployeeApi();
//     //       _getprofileepersonal.update();
//     //
//     //       final accountData2 = employeeLoginFromJson(response.body);
//     //       await accountService2.setAccountData2(accountData2);
//     //       await _homedashboardController.dashboarddApi();
//     //
//     //       // Navigate to HomeEmployee page
//     //       Get.off(() => HomeEmployee());
//     //     } else {
//     //       await _employeeController.paymentemployeeApi();
//     //       _employeeController.onInit();
//     //       // await Navigator.push(context,
//     //       //     MaterialPageRoute(builder: (context) => GetPaymentPage()));
//     //       // Navigate to OtherPage if login is unsuccessful
//     //       Get.off(() => GetPaymentPage());
//     //       // Get.snackbar('Do Payment', 'Do Your payment.');
//     //     }
//     //   } else {
//     //     Get.snackbar('Error', 'Failed to login. Please try again.');
//     //   }
//     // } catch (e) {
//     //   print('Error during login: $e');
//     //   // Get.off(() => HomeEmployee());
//     //
//     //   // Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
//     // } finally {
//     //   isLoading.value = false;
//     // }
//     isLoading.value = false;
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize controllers, listeners, etc.
//   }
//
//   String? validateUser(String value) {
//     if (value.isEmpty) {
//       return 'Please provide a username';
//     }
//     return null;
//   }
//
//   String? validatePassword(String value) {
//     if (value.length < 4) {
//       return 'Please provide a valid password';
//     }
//     return null;
//   }
//
//   void checkemployeeLogin() {
//     if (loginFormKey2.currentState!.validate()) {
//       loginFormKey2.currentState!.save();
//       loginemployeeApi();
//     }
//   }
// }

class EmployeeLoginController extends GetxController {
  var isLoading = false.obs;

  final GlobalKey<FormState> loginFormKey2 = GlobalKey<FormState>();
  late TextEditingController usernameController, passwordController;
  final ProfileEmployeeController _profileEmployeeController = Get.put(ProfileEmployeeController());
  HomedashboardController _homedashboardController = Get.put(HomedashboardController());
  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    callbackDispatcher();
  }

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      print("sendLocation execute login:");

      // This function will run in the background
      LocationController locationController = LocationController();
      if (task == "sendLocationPeriodic") {
        print("sendLocation login:");

        await locationController.startSendingLocation();

      }
      // Call the sendLocation function
      // await locationController.startSendingLocation();
      print("sendLocation in terminated");
      print("sendLocation :${locationController.latitude()}");
      return Future.value(true);
    });
  }
  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Employee login function
  Future<void> checkemployeeLogin() async {
    if (!loginFormKey2.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      final response = await ApiProvider.EmployeeLoginApi(
        usernameController.text,
        passwordController.text,
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var userId = responseData['response']['data']['userid'];
        var token = responseData['token'];
        var refToken = responseData['refreshToken'];

        // Save the login data in SharedPreferences for auto-login
        EmployeeLogin loginData = EmployeeLogin(
          response: Loginemp(
            data: Data(userid: userId),
          ),
          token: token,
          refreshToken: refToken
        );
        await accountService2.setAccountData2(loginData);

        Get.snackbar("Success", "Logged in successfully!",backgroundColor: Colors.white,colorText: appColor2);
        // Redirect to Dashboard or Home page
        await Future.delayed(Duration(seconds: 2));
        await deviceTokenId();
        await _homedashboardController.dashboarddApi();
        await _profileEmployeeController.profileemployeeApi();
        await _profileEmployeeController.profileEmployeBankApi();

        // await _homedashboardController.dashboarddApi();

        Get.off(() => BottomBar());
        await Get.dialog(
          // bool barrierDismissible = true

          AlertDialog(

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container(),
                const Text('ND Connect'),
                Container(
                  height: 40,width: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('lib/assets/logo/logoo.png')),
                      color: Colors.white
                  ),)
              ],
            ),
            content: const Text( '''By granting location access in this application, you allow us to collect and use your location data, including GPS coordinates, Wi-Fi network information, and cellular data. This information helps determine your presence within the designated workplace area, even when the app runs in the background. We only use this data to confirm attendance and ensure accurate time tracking in compliance with workplace policies.'''
                //"""When you grant permission for  location access in our application, we may collect and process certain information related to your geographical location. This includes GPS coordinates, Wi-Fi network information, cellular tower data, Background Location, and other relevant data sources to determine your device's location."""
            ),
            actions: [
              TextButton(
                child: const Text("Reject"),
                onPressed: () => Get.back(),
              ),
              TextButton(
                child: const Text("Accept"),
                onPressed: () async{
                  locationController.checkAndRequestLocationPermission();
                  Get.back();

                },
              ),
            ],
          ),
          barrierDismissible: false,
        );
      }
    } catch (error) {
      Get.snackbar('Error', 'An error occurred during login: $error',backgroundColor: Colors.red,colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deviceTokenId() async{
    var deviceToken = await ApiProvider.DeviceID();
    print("deviceToken:$deviceToken");
  }
  String? validateUser(String value) {
    if (value.isEmpty) {
      return 'Please provide a username';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 4) {
      return 'Please provide a valid password';
    }
    return null;
  }

  // void checkemployeeLogin() {
  //   if (loginFormKey2.currentState!.validate()) {
  //     loginFormKey2.currentState!.save();
  //     loginemployeeApi();
  //   }
  // }
}
