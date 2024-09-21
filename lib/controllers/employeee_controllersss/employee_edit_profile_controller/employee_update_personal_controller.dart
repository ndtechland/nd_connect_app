import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../models/city_model.dart';
import '../../../models/employee_model/profile_model/profileUpdateEmployeeModel.dart';
import '../../../models/state_model.dart';
import '../../../modules/all_pages/pages/emploree_pages/home_page_employee.dart';
import '../../../modules/all_pages/pages/emploree_pages/leaves_employee/multiple_day.dart';
import '../../../modules/bottom_bar/bottom_bar.dart';
import '../../../services_apis/api_servicesss.dart';

class EmployeeUpdatePersonalController extends GetxController {
  final isLoading = false.obs;

  final GlobalKey<FormState> personalinfoFormKey = GlobalKey<FormState>();
  var profileUpdateModel = ProfileUpdateEmployeeModel().obs;
  Rx<Gender> selectedGender = Gender.male.obs; // Use enum type

  Rx<CityModell?> selectedCity = (null as CityModell?).obs;
  RxList<CityModell> cities = <CityModell>[].obs;

  Rx<StateModelss?> selectedState = (null as StateModelss?).obs;
  RxList<StateModelss> states = <StateModelss>[].obs;

  Future<void> getStatepi() async {
    states.value = await ApiProvider.getSatesApi1();
  }
  @override
  void onInit() {
    super.onInit();
    getStatepi();
    selectedState.listen((state) {
      if (state != null) {
        print('Selected State: ${state.sName}');
        getCityByStateID(state.id as int);
      } else {
        cities.clear();
      }
    });
  }

  void getCityByStateID(int selectedState) async {
    isLoading(true);
    cities.clear();

    int stateID = selectedState; // Convert to int if coming as string

    final response = await ApiProvider.getCitiesApi(stateID);

    if (response.isNotEmpty) {
      cities.addAll(response);
      print('Cities fetched for State ID $stateID: ${cities.length}');
    } else {
      print('No cities found for State ID $stateID');
    }

    isLoading(false);  // Stop loading state
  }
  Rx<ProfileUpdateEmployeeModel>? employeeDetails = Rx<ProfileUpdateEmployeeModel>(ProfileUpdateEmployeeModel());

  //todAYYY
  // Future<void> updateProfile(Map<String, dynamic> profileData) async {
  //   isLoading.value = true;
  //
  //   ProfileUpdateEmployeeModel? result = await ApiProvider.updateEmployeeProfile(profileData);
  //
  //   if (result != null) {
  //     profileUpdateModel.value = result;
  //     if (result.succeeded ?? false) {
  //       Get.snackbar('Success', result.message ?? 'Profile updated successfully');
  //     } else {
  //       Get.snackbar('Error', result.message ?? 'Failed to update profile');
  //     }
  //   } else {
  //     Get.snackbar('Error', 'Failed to update profile');
  //   }
  //
  //   isLoading.value = false;
  // }

//todayyyy correct for profile and pan
  // Future<void> updateEmployee({
  //   required Map<String, String> formData,
  //   List<Uint8List>? aadharFileContent,
  //   String? Aadharbase64,
  //   Uint8List? panFileContent,
  //   String? Panbase64,
  //   Uint8List? profileFileContent,
  //   String? Profilebase64,
  // }) async {
  //   try {
  //     final response = await ApiProvider.updatePersonal(
  //       formData: formData,
  //       aadharFileContent: aadharFileContent,
  //       Aadharbase64: Aadharbase64,
  //       panFileContent: panFileContent,
  //       Panbase64: Panbase64,
  //       profileFileContent: profileFileContent,
  //       Profilebase64: Profilebase64,
  //     );
  //
  //     // Log the raw response
  //     print('profileRes:${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       print('profileImage:${profileFileContent}');
  //       print('profileImage:${Profilebase64}');
  //       print("_dateOfBirthController:${formData}");
  //
  //       // Parse the response body
  //      // final responseBody = jsonDecode(response.body);
  //      // print("responseBody:$responseBody");
  //       // Check if the API call was successful
  //      // if (responseBody['succeeded'] == true) {
  //         // Success handling
  //         Fluttertoast.showToast(
  //           msg: 'Profile updated successfullyyyyy!',
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.CENTER,
  //         );
  //
  //         // Navigate or perform further actions
  //         Get.dialog(
  //           Center(child: CircularProgressIndicator()),
  //           barrierDismissible: false,
  //         );
  //
  //         Future.delayed(Duration(seconds: 1), () {
  //           Get.back(); // Close the loading dialog
  //           Get.off(BottomBar()); // Navigate to Home screen
  //         });
  //       // }
  //       // else {
  //       // //  print("responseBodyElse:$responseBody");
  //       //   // Error handling
  //       //   Fluttertoast.showToast(
  //       //     msg: 'Failed to update profile. ${response['message']}',
  //       //     backgroundColor: Colors.red,
  //       //     textColor: Colors.white,
  //       //     toastLength: Toast.LENGTH_LONG,
  //       //     gravity: ToastGravity.BOTTOM,
  //       //   );
  //       // }
  //     } else {
  //       // Handle unexpected status codes
  //       Fluttertoast.showToast(
  //         msg: 'Failed to update profile. Status code: ${response.statusCode}',
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     print("error:$e");
  //     Fluttertoast.showToast(
  //       msg: 'Network error. Please try again.${e}',
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  Future<void> updateEmployee({
    required Map<String, String> formData,
    List<Uint8List>? aadharFileContent,
    List<String>? Aadharbase64, // Corrected to List for multiple Aadhaar images
    Uint8List? panFileContent,
    String? Panbase64,
    Uint8List? profileFileContent,
    String? Profilebase64,
  }) async {
    try {
      final response = await ApiProvider.updatePersonal(
        formData: formData,
        aadharFileContent: aadharFileContent,
        Aadharbase64: Aadharbase64,
        panFileContent: panFileContent,
        Panbase64: Panbase64,
        profileFileContent: profileFileContent,
        Profilebase64: Profilebase64,
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        Fluttertoast.showToast(
          msg: 'Profile updated successfully!',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false);
        Future.delayed(Duration(seconds: 1), () {
          Get.back(); // Close the loading dialog
          Get.off(BottomBar()); // Navigate to Home screen
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to update profile. Status code: ${response.statusCode}',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: 'Network error. Please try again. $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }


  // Future<void> updateEmployee1({
  //   String? fullName,
  //   String? workEmail,
  //   String? mobileNumber,
  //   String? dateOfBirth,
  //   String? stateid,
  //   String? cityid,
  //   String? address1,
  //   String? address2,
  //   String? pincode,
  //   String? personalEmailAddress,
  //   String? dateOfJoining,
  //   String? departmentName,
  //   String? designationName,
  //   String? companyName,
  //   String? companyLocationName,
  //   String? panNo,
  //   String? aadharNo,
  //   String? empProfile,
  //   String? aadharImage,
  //   String? panbaseImage,
  // }) async {
  //   try {
  //     final result = await ApiProvider.updateEmployeeDetails(
  //       fullName: fullName,
  //       workEmail: workEmail,
  //       mobileNumber: mobileNumber,
  //       dateOfBirth: dateOfBirth,
  //       stateid: stateid,
  //       cityid: cityid,
  //       address1: address1,
  //       address2: address2,
  //       pincode: pincode,
  //       personalEmailAddress: personalEmailAddress,
  //       dateOfJoining: dateOfJoining,
  //       departmentName: departmentName,
  //       designationName: designationName,
  //       companyName: companyName,
  //       companyLocationName: companyLocationName,
  //       panNo: panNo,
  //       aadharNo: aadharNo,
  //       empProfile: empProfile,
  //       aadharImage: aadharImage,
  //       panbaseImage: panbaseImage,
  //     );
  //     employeeDetails?.value = result;
  //
  //     if (result.succeeded == true) {
  //       // Handle successful response
  //       print("Employee details updated successfully");
  //       print('Profile Update successfully!');
  //       Fluttertoast.showToast(
  //         msg: 'Profile updated successfully!',
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 0, // Show toast for 1 second
  //       );
  //       // Show loading dialog before navigating
  //       Get.dialog(
  //         Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //         barrierDismissible: false,
  //       );
  //
  //       // Navigate to Home screen after a short delay (simulating asynchronous operation)
  //       Future.delayed(Duration(seconds: 1), () {
  //         Get.back(); // Close the loading dialog
  //         //Get.off(HomeEmployee()); // Navigate to Home screen
  //         Get.off(BottomBar()); // Nav
  //     } );
  //     }else {
  //       // Handle failure response
  //       print("Failed to update employee details: ${result.message}");
  //       print('Error Update Profile: ${result.statusCode}');
  //       Fluttertoast.showToast(
  //         msg: 'Failed to update profile. Status code: ${result.statusCode}',
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     // Handle any exceptions
  //     print("Error: $e");
  //     print('Network error: $e');
  //     Fluttertoast.showToast(
  //       msg: 'Network error. Please try again.',
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> updateProfilePersonalApi({
    required String fullName,
    required String workEmail,
    required String mobileNumber,
    required String dateOfBirth,
    required String stateid,
    required String cityid,
    required String addressLine1,
    required String addressLine2,
    required String pincode,
    required String personalEmailAddress,
    required String dateOfJoining,
     required String departmentName,
    required String designationName,
    required String companyName,
    required String companyLocationName,
    required String pAN,
    required String aadharNo,
    //
    //
    // required String age,
    // required String fatherName,
    //
    //

   List<Uint8List>? aadharFileContent,
    String? Aadharbase64,
    Uint8List? panFileContent,
    String? Panbase64,
    Uint8List? profileFileContent,
    String? Profilebase64,
  }) async {
    try {
      isLoading(true);

      final Map<String, String> formData = {
        'FullName': fullName,
        'WorkEmail': workEmail,
        'MobileNumber': mobileNumber,
        'DateOfBirth': dateOfBirth,
        'Stateid': stateid,
        'Cityid': cityid,
        'Address1': addressLine1,
        'Address2': addressLine2,
        'Pincode': pincode,
        'PersonalEmailAddress': personalEmailAddress,
        'DateOfJoining': dateOfJoining,
        'DepartmentName': departmentName,
        'DesignationName': designationName,
        'CompanyName': companyName,
        'CompanyLocationName': companyLocationName,
        'PanNo': pAN,
        'AadharNo': aadharNo,
        // 'Age': age,
        // 'FatherName': fatherName,
};

      final response = await ApiProvider.updatePersonal1(
        formData,
        aadharFileContent,
        Aadharbase64,
        panFileContent,
        Panbase64,
        profileFileContent,
        Profilebase64,
      );

      if (response.statusCode == 200) {
        print('Profile Update successfully!');
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
          //Get.off(HomeEmployee()); // Navigate to Home screen
          Get.off(BottomBar()); // Navigate to Home screen
        });
        print(response.body);
      } else {
        print('Error Update Profile: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Failed to update profile. Status code: ${response.statusCode}',
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

  // @override
  // void onInit() {
  //   super.onInit();
  //   getStatepi();
  //   selectedState.listen((p0) {
  //     if (p0 != null) {
  //       getCityByStateID("${p0.id}");
  //     }
  //   });
  // }
}
