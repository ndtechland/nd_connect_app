// // lib/controllers/profile_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services_apis/api_servicesss.dart';


class ProfileUpdateController extends GetxController {
  final ApiProvider apiService;

  ProfileUpdateController({required this.apiService});
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  Future<void> updateProfile({
     String? id,
     String? fullName,
     String? phoneNumber,
     String? email,
     String? address,
     String? pinCode,
     String? dob,
     String? profileImagePath,
    required File profileImage,
  }) async {
    try {
      var response = await apiService.updateProfile(
        id: id,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
        pinCode: pinCode,
        dob: dob,
        profileImagePath: profileImagePath,
        profileImage: profileImage,
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully: $response');
      } else {
        print('Failed to update profile: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }
}

// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:hirejobindia/services_apis/api_servicesss.dart';
//
// class ProfileUpdateController extends GetxController {
//   final ApiProvider apiService;
//
//   ProfileUpdateController({required this.apiService});
//   final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
//
//   Future<void> updateProfile({
//     required String id,
//     required String fullName,
//     required String phoneNumber,
//     required String email,
//     required String address,
//     required String pinCode,
//     required String dob,
//     required String profileImagePath,
//     required File profileImage,
//   }) async {
//     try {
//       var response = await apiService.updateProfile(
//         id: id,
//         fullName: fullName,
//         phoneNumber: phoneNumber,
//         email: email,
//         address: address,
//         pinCode: pinCode,
//         dob: dob,
//         profileImagePath: profileImagePath,
//         profileImage: profileImage,
//       );
//
//       if (response.statusCode == 200) {
//         print('Profile updated successfully: $response');
//       } else {
//         print('Failed to update profile: ${response.statusCode}');
//         print('Response body: ${response.body}');
//         throw Exception('Failed to update profile: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error updating profile: $e');
//     }
//   }
// }
//
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:hirejobindia/services_apis/api_servicesss.dart';
//
// class ProfileUpdateController extends GetxController {
//   final ApiProvider apiService;
//
//   ProfileUpdateController({required this.apiService});
//   final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
//
//   Future<void> updateProfile({
//     required String id,
//     required String fullName,
//     required String phoneNumber,
//     required String email,
//     required String address,
//     required String pinCode,
//     required String dob,
//     required String profileImagePath,
//     required File profileImage,
//   }) async {
//     try {
//       var response = await apiService.updateProfile(
//         id: id,
//         fullName: fullName,
//         phoneNumber: phoneNumber,
//         email: email,
//         address: address,
//         pinCode: pinCode,
//         dob: dob,
//         profileImagePath: profileImagePath,
//         profileImage: profileImage,
//       );
//
//       // Print the success message
//       print('Profile updated successfully: $response');
//     } catch (e) {
//       // Print the error message
//       print('Error updating profile: $e');
//     }
//   }
// }






// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class ProfileUpdateeeController extends GetxController {
//   final ApiProvider apiService;
//   final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
//
//   ProfileUpdateeeController({required this.apiService});
//
//   Future<void> updateProfile({
//     required String id,
//     required String fullName,
//     required String phoneNumber,
//     required String email,
//     required String address,
//     required String pinCode,
//     required String dob,
//     required String profileImagePath,
//     required File profileImage,
//   }) async {
//     print("Profile update started");
//
//     try {
//       // Construct API request
//       final uri = Uri.parse('https://api.luckysix.in/api/Account/UpdateProfile');
//       final request = http.MultipartRequest('POST', uri);
//
//       request.fields['id'] = id;
//       request.fields['full_name'] = fullName;
//       request.fields['phone_number'] = phoneNumber;
//       request.fields['email'] = email;
//       request.fields['address'] = address;
//       request.fields['pin_code'] = pinCode;
//       request.fields['dob'] = dob;
//
//       if (profileImage.existsSync()) {
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'profile_image',
//             profileImage.path,
//           ),
//         );
//       }
//
//       // Send the request
//       print("Sending API request");
//       final response = await request.send();
//       print("API request sent");
//
//       if (response.statusCode == 200) {
//         print("Profile update success");
//       } else {
//         print("Profile update failed with status: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Profile update failed with error: $e");
//       rethrow;
//     }
//   }
// }
