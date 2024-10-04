import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';


import '../../../components/styles.dart';
import '../../../models/employee_model/autologin_employee_model.dart';

import '../../../services_apis/api_servicesss.dart';
import '../../../services_apis/auto_login_employee.dart';
import '../../employee_controller/profile_controller/profile_info_employee_controller.dart';
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
        await _homedashboardController.dashboarddApi();
        await _profileEmployeeController.profileemployeeApi();
        // await _homedashboardController.dashboarddApi();

        Get.off(() => BottomBar());
      } else if (response.statusCode == 401) {
        Get.snackbar('Error', 'Unauthorized: ${response.body}',backgroundColor: Colors.red,colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Login failed: ${response.body}',backgroundColor: Colors.red,colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar('Error', 'An error occurred during login: $error',backgroundColor: Colors.red,colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
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
