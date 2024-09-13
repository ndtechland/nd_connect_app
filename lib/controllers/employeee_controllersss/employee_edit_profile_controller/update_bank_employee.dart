import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';

import '../../../modules/all_pages/pages/emploree_pages/home_page_employee.dart';
import '../../../services_apis/api_servicesss.dart';

class BankEmployeeUodateController extends GetxController {
  final isLoading = false.obs;

  var selectedGender = ''.obs;

  final GlobalKey<FormState> bankemployeeFormKey = GlobalKey<FormState>();

  //final selectedGender = Gender.male.obs; // Add observable for selected gender

  onChangeShifts(String servicee) {
    selectedGender.value = servicee;
  }

  Future<void> updateBankProfile({
    required String accountHolderName,
    required String bankname,
    required String accountNumber,
    required String reEnterAccountNumber,
    required String ifsc,
    required var accountTypeId,
    required String epfNumber,
    String? deductionCycle,
    String? employeeContributionRate,
    required String nominee,
    required Uint8List cvFileContent,
    required String Chequebase64, // Add this parameter
  }) async {
    try {
      isLoading(true);

      final Map<String, String> formData = {
        'AccountHolderName': accountHolderName,
        'BankName': bankname,
        'AccountNumber': accountNumber,
        'ReEnterAccountNumber': reEnterAccountNumber,
        'Ifsc': ifsc,
        'AccountTypeId': accountTypeId,
        'EpfNumber': epfNumber,
        'Nominee': nominee,
      };

      if (deductionCycle != null) {
        formData['DeductionCycle'] = deductionCycle;
      }

      if (employeeContributionRate != null) {
        formData['employeeContributionRate'] = employeeContributionRate;
      }

      // Make API call
      final response = await ApiProvider.updateBankEmployeeApi(
          formData, cvFileContent, Chequebase64);

      print(response.body);

      if (response.statusCode == 200) {
        print('Bank Update successfully!');

        Fluttertoast.showToast(
          msg: 'Profile updated successfully!',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 0, // Show toast for 1 second
        );
        // Show loading dialog before navigating
        Get.dialog(
          Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false,
        );

        // Navigate to Home screen after a short delay (simulating asynchronous operation)
        Future.delayed(Duration(seconds: 1), () {
          Get.back(); // Close the loading dialog
         // Get.off(HomeEmployee()); // Navigate to Home screen
          Get.off(BottomBar()); // Navigate to Home screen
        });
        // Get.offAll(Login());
        //Get.offAll(() => Login());
        print(response.body);
      } else {
        print('Error Update Profile: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Failed to update bank. Status code: ${response.statusCode}',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (error) {
      print('Network error: $error');
      Fluttertoast.showToast(
        msg: 'Network error. Please try again.',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();

    //getNurseTypeApi();
    // selectedState.listen((p0) {
    //   // if (p0 != null) {
    //   //   getCityByStateIDLab("${p0.id}");
    //   // }
    // });
  }
}
