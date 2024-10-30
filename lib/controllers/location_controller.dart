import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nd_connect_techland/controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import 'package:nd_connect_techland/models/company_location_model.dart';
import 'package:nd_connect_techland/modules/all_pages/attendance/attendance.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
import 'package:permission_handler/permission_handler.dart';
import '../modules/bottom_bar/bottom_bar.dart';
import 'attendance_controller.dart';
class LocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  var breakIn = false.obs;
  var breakOut = false.obs;
  var distanceFromCompany = 0.0.obs;
  var userId = 0.obs;
  var companyLatitude = 0.0.obs; // Company's latitude
  var companyLongitude = 0.0.obs;
  var companyRadius = 0.0.obs;
  Timer? _timer;
  CompanyLocationModel? companyLocationModel;
  final AttendanceController attendanceController = Get.put(AttendanceController());
  ProfileEmployeeController profileEmployeeController = Get.put(ProfileEmployeeController());
  @override
  void onInit() {
    super.onInit();
    getCoordinatesFromAddress();
    print("Sending location init");

   startSendingLocation();
  }
  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
  // Future<void> startSendingLocation() async {
  //   print("Sending location ");
  //
  //   // Check if latitude and longitude are 0.0
  //   if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
  //     _timer?.cancel();  // Cancel any existing timer before starting a new one
  //     _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
  //       print("Sending location periodically...");
  //       debugPrint("Sending location periodically - debug");
  //
  //       sendLocation();  // Ensure this is a valid function
  //     });
  //   }  else if (latitude.value == 0.0 && longitude.value == 0.0) {
  //     // Call the API function once if lat/lng are 0.0, regardless of login status
  //     print("Latitude and longitude are 0.0, calling sendLocation once.");
  //     await sendLocation();  // Ensure this is a valid async function
  //   }else if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
  //     print("Sending location Checkout...");
  //
  //     _timer?.cancel();  // Cancel any existing timer before starting a new one
  //
  //   } else {
  //     _timer?.cancel();  // Stop the timer if the status is not "Check-In"
  //   }
  // }

  Future<void> startSendingLocation() async {

    if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
      _timer?.cancel();  // Cancel any existing timer before starting a new one
      _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
        print("Sending location...");
        debugPrint("Sending locationnn debug");
        sendLocation();  // Ensure this is a valid function
      });
    } else if(latitude.value==0.0&& longitude.value==0.0) {
      print("Sending lat:${latitude.value}${longitude.value}");

      _timer?.cancel();  // Stop the timer if the status is not "Check-In"
    } else if(attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
      print("Sending lat:${latitude.value}${longitude.value}");

      _timer?.cancel();  // Stop the timer if the status is not "Check-In"
    } else {
      _timer?.cancel();  // Stop the timer if the status is not "Check-In"
    }
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
      await locationController.fetchCurrentLocation(
        // " C 53, 1st Floor, C Block, Sector 2, Noida, Uttar Pradesh 201301"
      );
      // await locationController.fetchCompanyLocationApi();
      // await locationController.getCoordinatesFromAddress();
      // await attendanceController.AttendanceDetailApi(DateTime.now());
      await attendanceController.updateAttendaneDetail();
      await locationController.startSendingLocation();
     // Check response status code
     //  if (response?.statusCode == 200) {
     //    print("Check-in successful: ${response?.body}");
     //    // statusColor.value = Colors.green;
     //    // await saveCheckInStatus(true); // Save the check-in status
     //    // await saveStatusColor(Colors.green);
     //    await Future.delayed(Duration(seconds: 3));
     //    print("Check-in time: ${attendanceController.attendanceDetailsModel?.data?.checkInTime}");
     //    await attendanceController.AttendanceDetailApi();
     //    // Navigate to the Attendance screen or perform other actions
     //    // Get.to(() => Attendance(id: "13"));
     //
     //    // Show success toast
     //    Fluttertoast.showToast(
     //      msg: "Check-In Successfully!",
     //      backgroundColor: Colors.green,
     //      textColor: Colors.white,
     //      toastLength: Toast.LENGTH_LONG,
     //      gravity: ToastGravity.CENTER,
     //    );
     //  } else if (response?.statusCode == 401) {
     //    print("Unauthorized access");
     //    Fluttertoast.showToast(
     //      msg: "Unauthorized access. Please check your login status.",
     //      backgroundColor: Colors.red,
     //      textColor: Colors.white,
     //      toastLength: Toast.LENGTH_LONG,
     //      gravity: ToastGravity.BOTTOM,
     //    );
     //  } else if(response?.statusCode ==409){
     //    // statusColor.value = Colors.green;
     //    await attendanceController.AttendanceDetailApi();
     //
     //    // Get.to(() => Attendance(id: "13"));
     //
     //    // Show success toast
     //    Fluttertoast.showToast(
     //      msg: "You are already Check-In",
     //      backgroundColor: Colors.green,
     //      textColor: Colors.white,
     //      toastLength: Toast.LENGTH_LONG,
     //      gravity: ToastGravity.CENTER,
     //    );
     //  }else {
     //    // Handle other response status codes
     //    print("Failed to check in: ${response?.statusCode}");
     //    // statusColor.value = Color(0xfff44336);
     //    Get.snackbar('Error', 'Failed to check in. Please try again.');
     //    Fluttertoast.showToast(
     //      msg: "Check-In failed. Status code: ${response?.statusCode}",
     //      backgroundColor: Colors.red,
     //      textColor: Colors.white,
     //      toastLength: Toast.LENGTH_LONG,
     //      gravity: ToastGravity.BOTTOM,
     //    );
     //  }
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

  Future<void> breakInApi() async {
    await Future.delayed(Duration(seconds: 1));
    print("checkIN Controller");
    try {
      isLoading.value = true;
      final response = await ApiProvider.breakIn(
          latitude.toString(),
          longitude.toString(),
          breakIn.value = true,
      );

     // Check response status code
      if (response?.statusCode == 200) {
        print("breakIn successful: ${response?.body}");
        await Future.delayed(Duration(seconds: 3));
        print("Check-in time: ${attendanceController.attendanceDetailsModel?.data?.checkInTime}");
        await attendanceController.AttendanceDetailApi(DateTime.now()
        );
        // Navigate to the Attendance screen or perform other actions
        Get.to(() => BottomBar());

        // Show success toast
        Fluttertoast.showToast(
          msg: "Break-In Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (response?.statusCode == 401) {
        print("Unauthorized access");
        // statusColor.value = Color(0xfff44336);
        // await saveCheckInStatus(false); // Save the check-out status or error state
        // await saveStatusColor(Color(0xfff44336));
        // Show unauthorized error
        Fluttertoast.showToast(
          msg: "Unauthorized access. Please check your login status.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else if(response?.statusCode ==409){
        // statusColor.value = Colors.green;
        await attendanceController.AttendanceDetailApi(DateTime.now());

        Get.to(() => BottomBar());

        // Show success toast
        Fluttertoast.showToast(
          msg: "You are already Break-In",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }else {
        // Handle other response status codes
        print("Failed to check in: ${response?.statusCode}");
        // statusColor.value = Color(0xfff44336);
        // Get.snackbar('Error', 'Failed to check in. Please try again.');
        Fluttertoast.showToast(
          msg: "Break-In failed.Please try again ",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during check-in: $e');
      // Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
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

  Future<void> breakOutApi() async {
    await Future.delayed(Duration(seconds: 1));
    print("breakOut Controller");
    try {
      isLoading.value = true;
      final response = await ApiProvider.breakOut(
          latitude.toString(),
          longitude.toString(),
          breakOut.value = true,
      );

     // Check response status code
      if (response?.statusCode == 200) {
        print("breakOut successful: ${response?.body}");
        await Future.delayed(Duration(seconds: 3));
        print("breakOut time: ${attendanceController.attendanceDetailsModel?.data?.checkInTime}");
        await attendanceController.AttendanceDetailApi(DateTime.now());
        // Navigate to the Attendance screen or perform other actions
        Get.to(() => BottomBar());

        // Show success toast
        Fluttertoast.showToast(
          msg: "Break-Out Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      } else if (response?.statusCode == 401) {
        print("Unauthorized access");
        // statusColor.value = Color(0xfff44336);
        // await saveCheckInStatus(false); // Save the check-out status or error state
        // await saveStatusColor(Color(0xfff44336));
        // Show unauthorized error
        Fluttertoast.showToast(
          msg: "Unauthorized access. Please check your login status.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } else if(response?.statusCode ==409){
        // statusColor.value = Colors.green;
        await attendanceController.AttendanceDetailApi(DateTime.now());

        Get.to(() => BottomBar());

        // Show success toast
        Fluttertoast.showToast(
          msg: "You are already Break-Out",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }else {
        // Handle other response status codes
        print("Failed to check in: ${response?.statusCode}");
        // statusColor.value = Color(0xfff44336);
        // Get.snackbar('Error', 'Failed to check in. Please try again.');
        Fluttertoast.showToast(
          msg: "Break-Out failed.Please try again ",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during Break-Out: $e');
      // Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
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

  Future<void> sendLocation() async {
    await Future.delayed(Duration(seconds: 1));
    print("checkIN Controller");
    try {
      isLoading.value = true;
      final response = await ApiProvider.sendLatLang(
          latitude.toString(),
          longitude.toString(),
      );
      print("send latLang: $latitude,$longitude");
      } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during check-in: $e');
    } finally {
      // Set loading state to false after the API call completes
      isLoading.value = false;
    }
  }
  Future<void> startOverTime() async {
    await Future.delayed(Duration(seconds: 1));
    print("startOverTime Controller");
    try {
      isLoading.value = true;
      final response = await ApiProvider.overtimeApi();
      print("startOverTime ${response?.statusCode}");
      } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during start over time: $e');
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
        // Navigate to the Attendance screen or perform other actions
        Get.offAll(() => BottomBar());

      } else {
        // Handle other response status codes
        print("Failed to check Out: ${response?.statusCode}");
        // statusColor.value = Colors.red;

        // Show generic error message
        // Get.snackbar('Error', 'Failed to check in. Please try again.');
        // Fluttertoast.showToast(
        //   msg: "Check-In failed. Status code: ${response?.statusCode}",
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   toastLength: Toast.LENGTH_LONG,
        //   gravity: ToastGravity.BOTTOM,
        // );
      }
    } catch (e) {
      // Catch and handle any exceptions or network errors
      print('Error during check-in: $e');
      // Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      // Fluttertoast.showToast(
      //   msg: "Network error: $e",
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.BOTTOM,
      // );
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



