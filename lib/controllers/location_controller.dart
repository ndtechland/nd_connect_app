
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nd_connect_techland/controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import 'package:nd_connect_techland/models/company_location_model.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/bottom_bar/bottom_bar.dart';
class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  var distanceFromCompany = 0.0.obs;
  var userId = 0.obs;
  // Company address details
  var companyLatitude = 0.0.obs; // Company's latitude
  var companyLongitude = 0.0.obs;
  Rx<Color> statusColor = Color(0xFFFF0202).obs; // Default to white color
  // Radius in meters for the company boundary
  var companyRadius = 0.0.obs;
  CompanyLocationModel? companyLocationModel;
  ProfileEmployeeController profileEmployeeController = Get.put(ProfileEmployeeController());
  @override
  void onInit() {
    super.onInit();
    getCoordinatesFromAddress();
    restoreCheckInStatus();
    restoreStatusColor();
  }
  Future<void> restoreCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCheckedIn = prefs.getBool('isCheckedIn') ?? false;
    // You can update the UI accordingly based on isCheckedIn
  }

  Future<void> restoreStatusColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedColorValue = prefs.getInt('statusColor') ?? Colors.red.value;
    statusColor.value = Color(savedColorValue); // Restore the color
  }
  Future<void> saveCheckInStatus(bool isCheckedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isCheckedIn', isCheckedIn);
  }

  Future<void> saveStatusColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('statusColor', color.value); // Save the color as an integer
  }

  Future<void> fetchCompanyLocationApi() async {
    await Future.delayed(Duration(seconds: 1));
    isLoading.value = true;
    companyLocationModel = await ApiProvider.CompanyLocation();
    if(companyLocationModel?.data?.companyOfficeLocation == null) {
    print("companyLocation null");
    isLoading(true);
    companyLocationModel = await ApiProvider.CompanyLocation();
    }if (companyLocationModel?.data?.companyOfficeLocation != null){
      print("companyLocation ${companyLocationModel?.data?.companyOfficeLocation}");

      isLoading(false);
      getCoordinatesFromAddress();
    }

    isLoading.value = false;
  }
  // Future<void> checkInApi() async {
  //   print("checkIN Contro");
  //
  // try{
  //   print("checkIN Contro:try");
  //
  //   isLoading.value=false;
  //   final res = await ApiProvider.CheckInApi(latitude.toString(), longitude.toString(), userId as int);
  //   if (res?.statusCode == 200) {
  //     print("checkIN Contro:200");
  //     print("checkIN contro:${res?.body}");
  //     // Navigate to Home Page
  //     Get.off(() => Attendance(id: "13"));
  //   } else {
  //     print("checkIN contro:not 200");
  //
  //     // Handle other status codes or errors
  //     Get.snackbar('Error', 'Failed to checkin. Please try again.');
  //   }
  // } catch (e){
  //   Get.snackbar('Error Contro', 'An unexpected error occurred. Please try again.');
  // } finally {
  //   isLoading.value = false;
  // }
  // }
  Future<void> checkInApi() async {
    await Future.delayed(Duration(seconds: 1));
    print("checkIN Controller");
    try {
      isLoading.value = true;

      // Make sure userId, latitude, and longitude are valid
      // if (userId.value == 0 || latitude.value == 0.0 || longitude.value == 0.0) {
      //   Get.snackbar('Error', 'Invalid data. Ensure location and user ID are available.');
      //   isLoading.value = false;
      //   return;
      // }

      // Make API request
      final response = await ApiProvider.CheckInApiii(
          latitude.toString(),
          longitude.toString(),
      );

     // Check response status code
      if (response?.statusCode == 200) {
        print("Check-in successful: ${response?.body}");
        statusColor.value = Colors.green;
        await saveCheckInStatus(true); // Save the check-in status
        await saveStatusColor(Colors.green);
        // Navigate to the Attendance screen or perform other actions
        Get.to(() => Attendance(id: "13"));

        // Show success toast
        Fluttertoast.showToast(
          msg: "Check-In Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (response?.statusCode == 401) {
        print("Unauthorized access");
        statusColor.value = Colors.red;
        await saveCheckInStatus(false); // Save the check-out status or error state
        await saveStatusColor(Colors.red);
        // Show unauthorized error
        Fluttertoast.showToast(
          msg: "Unauthorized access. Please check your login status.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else if(response?.statusCode ==409){
        statusColor.value = Colors.green;
        await saveCheckInStatus(true);
        await saveStatusColor(Colors.green);
        Get.to(() => Attendance(id: "13"));

        // Show success toast
        Fluttertoast.showToast(
          msg: "You are already Check-In",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }else {
        // Handle other response status codes
        print("Failed to check in: ${response?.statusCode}");
        statusColor.value = Colors.red;
        await saveCheckInStatus(false); // Save the check-out status or error state
        await saveStatusColor(Colors.red);
        // Show generic error message
        Get.snackbar('Error', 'Failed to check in. Please try again.');
        Fluttertoast.showToast(
          msg: "Check-In failed. Status code: ${response?.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during check-in: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      Fluttertoast.showToast(
        msg: "Network error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      // Set loading state to false after the API call completes
      isLoading.value = false;
    }
  }
  Future<void> employeeCheckOut() async{
    try {
      isLoading.value = true;

      // Make sure userId, latitude, and longitude are valid
      // if (userId.value == 0 || latitude.value == 0.0 || longitude.value == 0.0) {
      //   Get.snackbar('Error', 'Invalid data. Ensure location and user ID are available.');
      //   isLoading.value = false;
      //   return;
      // }

      // Make API request
      final response = await ApiProvider.CheckOutApiii(
        latitude.toString(),
        longitude.toString(),
      );

      // Check response status code
      if (response?.statusCode == 200) {
        print("Check-Out successful: ${response?.body}");
        statusColor.value = Colors.red;
        await saveCheckInStatus(false); // Save the check-in status
        await saveStatusColor(Colors.red);
        // Navigate to the Attendance screen or perform other actions
        //Get.offAll(() => BottomBar());
        //
        // // Show success toast
        // Fluttertoast.showToast(
        //   msg: "Check-In Successfully!",
        //   backgroundColor: Colors.green,
        //   textColor: Colors.white,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.CENTER,
        // );
      } else {
        // Handle other response status codes
        print("Failed to check Out: ${response?.statusCode}");
        statusColor.value = Colors.red;

        // Show generic error message
        Get.snackbar('Error', 'Failed to check in. Please try again.');
        Fluttertoast.showToast(
          msg: "Check-In failed. Status code: ${response?.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during check-in: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      Fluttertoast.showToast(
        msg: "Network error: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      // Set loading state to false after the API call completes
      isLoading.value = false;
    }
  }
  Future<void> checkAndRequestLocationPermission() async {
    await Future.delayed(Duration(seconds: 1));
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, fetch the current location
      await fetchCurrentLocation();
    } else if (status.isDenied) {
      errorMessage.value = 'Location permission denied.';
    } else if (status.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      await openAppSettings();
      errorMessage.value = 'Permission permanently denied. Please enable location in settings.';
    }
  }

  Future<void> getCoordinatesFromAddress() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      isLoading(true); // Show loading state
      List<Location> comlocations = await locationFromAddress(companyLocationModel!.data!.companyOfficeLocation.toString());
      if (comlocations.isNotEmpty) {
        companyLatitude.value = comlocations.first.latitude;
        companyLongitude.value = comlocations.first.longitude;
        errorMessage.value = '';

        // Debugging logs to verify the company coordinates
        print("Company Latitude: ${companyLatitude.value}");
        print("Company Longitude: ${companyLongitude.value}");
      } else {
        errorMessage.value = 'No locations found for the provided address.';
      }
    } catch (e) {
      errorMessage.value = 'Failed to get location from address: $e';
    } finally {
      isLoading(false); // Hide loading state
    }
  }

//   // Function to listen to location changes and update the distance dynamically
//   void listenToLocationChanges() {
//     // Request high accuracy updates with small distance intervals
//     Geolocator.getPositionStream(
//       locationSettings: LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 1, // Update the position after the user moves 1 meter
//       ),
//     ).listen((Position position) {
//       latitude.value = position.latitude;
//       longitude.value = position.longitude;
//
//       // Debugging logs to verify user location updates
//       print("update User Latitude: ${latitude.value}");
//       print("update User Longitude: ${longitude.value}");
//
//       // Update the distance from the company as the user moves
//       updateDistanceFromCompany();
//     });
//     // StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
//     //   locationSettings: LocationSettings(
//     //     accuracy: LocationAccuracy.high,
//     //     distanceFilter: 10, // meters between location updates
//     //   ),
//     // ).listen((Position position) {
//     //   latitude.value = position.latitude;
//     //   longitude.value = position.longitude;
//     //   updateDistanceFromCompany(); // Update distance when position changes
//     // });
// }

  Future<void> updateDistanceFromCompany() async {
    await Future.delayed(Duration(seconds: 1));
    print("lattt:${latitude.value}");
    print("longg:${longitude.value}");
    print("companyLatt:${companyLatitude.value}");
    print("companyLongg:${companyLongitude.value}");
    double distance = Geolocator.distanceBetween(
      latitude.value,
      longitude.value,
      companyLatitude.value,
      companyLongitude.value,
    );
    distanceFromCompany.value = distance; // Update the observable distance

    // Debug log for distance
    print('Updated distance from company: $distance meters');
  }

  Future<void> fetchCurrentLocation() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      isLoading(true); // Start loading
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,forceAndroidLocationManager: true,);
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      // Debugging logs to verify the user location
      print("Initial User Latitude: ${latitude.value}");
      print("Initial User Longitude: ${longitude.value}");

      errorMessage.value = ''; // Clear error message
      updateDistanceFromCompany(); // Initial distance calculation
    } catch (e) {
      errorMessage.value = 'Failed to fetch location: $e';
    } finally {
      isLoading(false); // Stop loading
    }
  }

  bool isUserWithinCompanyRadius(double companyLat, double companyLng, String radiusInMeters) {
    double distance = Geolocator.distanceBetween(
      latitude.value,
      longitude.value,
      companyLat,
      companyLng,
    );

    // Debug log for distance and radius check
    print('Calculated distance: $distance meters');
    return distance <= int.parse(radiusInMeters);
  }

}



