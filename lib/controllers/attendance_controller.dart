// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class AttendanceController extends GetxController {
//   var selectedDate = DateTime.now().obs; // Track selected date
//   var checkInTime = ''.obs;
//   var checkOutTime = ''.obs;
//   var startOverTime = ''.obs;
//   var endOverTime = ''.obs;
//   var totalWorkingHours = ''.obs;
//   var breakInTime = [].obs;
//   // Assuming it's a list of break-in times
// void onInit(){
//   super.onInit();
//   fetchAttendanceData();
// }
//   // Method to update the date and fetch the data
//   void updateSelectedDate(DateTime date) {
//     selectedDate.value = date;
//     fetchAttendanceData();
//   }
//
//   // Fetch the attendance data based on the selected date
//   void fetchAttendanceData() {
//     // Simulate API call or logic to fetch data based on the date
//     // In reality, replace this with your API call
//     checkInTime.value = "09:30 am"; // Example data
//     checkOutTime.value = "06:30 pm";
//     totalWorkingHours.value = "8 hours";
//     breakInTime.value = ["10:30 am", "01:00 pm"];
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  var selectedDate = DateTime.now().obs; // Track selected date
  var checkInTime = ''.obs;
  var checkOutTime = ''.obs;
  var startOverTime = ''.obs;
  var endOverTime = ''.obs;
  var totalWorkingHours = ''.obs;
  var payPeriodHours = ''.obs;
  var presence = ''.obs;
  var absence = ''.obs;
  var overtime = ''.obs;
  var breakInTime = [].obs;
  var breakOutTime = [].obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceData();
  }

  // Method to update the date and fetch the data
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    fetchAttendanceData();
  }

  // Fetch the attendance data based on the selected date
  void fetchAttendanceData() {
    // Cancel the timer if it was running
    _timer?.cancel();

    // Dummy data for specific dates
    Map<String, dynamic> dummyData = {
      "2024-09-18": {
        "checkInTime": "09:15 am",
        "checkOutTime": "06:10 pm",
        "startOverTime": "08:00 am",
        "endOverTime": "07:00 pm",
        "totalWorkingHours": "8 hours 55 minutes",
        "payPeriodHours": "160 hours",
        "presence": "100%",
        "absence": "0%",
        "overtime": "2 hours",
        "breakInTimes": ["10:45 am", "01:30 pm"],
        "breakOutTimes": ["11:00 am", "02:00 pm"],
      },
      "2024-09-17": {
        "checkInTime": "09:00 am",
        "checkOutTime": "06:00 pm",
        "startOverTime": "08:30 am",
        "endOverTime": "06:30 pm",
        "totalWorkingHours": "9 hours",
        "payPeriodHours": "160 hours",
        "presence": "95%",
        "absence": "5%",
        "overtime": "1 hour",
        "breakInTimes": ["11:00 am", "02:00 pm"],
        "breakOutTimes": ["11:15 am", "02:30 pm"],
      },
      "2024-09-16": {
        "checkInTime": "09:20 am",
        "checkOutTime": "05:50 pm",
        "startOverTime": "08:45 am",
        "endOverTime": "06:15 pm",
        "totalWorkingHours": "8 hours 30 minutes",
        "payPeriodHours": "160 hours",
        "presence": "90%",
        "absence": "10%",
        "overtime": "1.5 hours",
        "breakInTimes": ["10:30 am", "01:00 pm", "02:45 pm"],
        "breakOutTimes": ["10:45 am", "01:30 pm", "03:00 pm"],
      },
    };

    // Format the selected date to match the keys in the dummy data
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Check if selected date is today
    if (formattedDate == todayDate) {
      // Use dummy check-in time and simulate real-time working hours for today
      checkInTime.value = "09:00 am";
      checkOutTime.value = "06:30 pm"; // No check-out time yet
      startOverTime.value = "06:32 pm";
      endOverTime.value = "07:00 pm";
      payPeriodHours.value = "160 hours";
      presence.value = "100%";
      absence.value = "0%";
      overtime.value = "09Hrs";
      breakInTime.value = ["10:30 am", "01:00 pm"];
      breakOutTime.value = ["11:00 am", "01:30 pm"];

      // Start a timer to update total working hours every minute
      _timer = Timer.periodic(Duration(minutes: 1), (timer) {
       updateWorkingHours();
      });

      // Immediately update total working hours
      updateWorkingHours();
    } else if (dummyData.containsKey(formattedDate)) {
      // Fetch data for previous dates
      var data = dummyData[formattedDate];
      checkInTime.value = data['checkInTime'];
      checkOutTime.value = data['checkOutTime'];
      startOverTime.value = data['startOverTime'];
      endOverTime.value = data['endOverTime'];
      totalWorkingHours.value = data['totalWorkingHours'];
      payPeriodHours.value = data['payPeriodHours'];
      presence.value = data['presence'];
      absence.value = data['absence'];
      overtime.value = data['overtime'];
      breakInTime.value = data['breakInTimes'];
      breakOutTime.value = data['breakOutTimes'];
    } else {
      // If no data exists for the selected date, use default values
      checkInTime.value = "09:18 am";
      checkOutTime.value = "07:15 pm";
      startOverTime.value = "07:16 pm";
      endOverTime.value = "08:00 pm";
      totalWorkingHours.value = "10Hrs";
      payPeriodHours.value = "38Hrs";
      presence.value = "90%";
      absence.value = "10%";
      overtime.value = "04Hrs";
      breakInTime.value = [];
      breakOutTime.value = [];
    }
  }

  // Method to update working hours in real-time


//   void updateWorkingHours() {
//     // Current time
//     DateTime now = DateTime.now();
//     DateFormat timeFormat = DateFormat("hh:mm a"); // Format for both now and check-in time
//
//     // Format 'now' to match the check-in time format
//     String nowStr = timeFormat.format(now);
//     print("Formatted now: $nowStr");
//
//     try {
//       // Ensure the check-in time string is well formatted and trimmed
//       String checkInStr = checkInTime.value.trim().toLowerCase(); // Convert to lowercase
//       nowStr = nowStr.toLowerCase(); // Convert the nowStr to lowercase
//       print("Check-in time string: '$checkInStr'");
//       print("Now time string: '$nowStr'");
//
//       // Check if the check-in time string is valid
//       if (!RegExp(r'^[0-9]{1,2}:[0-9]{2} [APap][Mm]$').hasMatch(checkInStr)) {
//         throw FormatException("Invalid time format: $checkInStr");
//       }
//
//       // Parse the formatted 'now' and 'check-in' times using the same format
//       DateTime checkIn = timeFormat.parse(checkInStr);
//       print("checkIn:$checkIn");
//       DateTime formattedNow = timeFormat.parse(nowStr); // Parse nowStr
// print("formattedNow: $formattedNow");
//       // Calculate the working duration
//       Duration workingDuration = formattedNow.difference(checkIn);
//       print("workingDuration: $workingDuration");
//
//       // Format the working hours into a readable string
//       String formattedWorkingHours =
//           "${workingDuration.inHours}Hrs ${workingDuration.inMinutes.remainder(60)}min";
//
//       totalWorkingHours.value = formattedWorkingHours;
//       print("Total working hours: $formattedWorkingHours");
//     } catch (e) {
//       // Handle any parsing errors
//       print("Error parsing time: $e");
//       totalWorkingHours.value = "09Hrs";
//     }
//   }

  void updateWorkingHours() {
    // Current time
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat("hh:mm a"); // Format for both now and check-in time

    // Format 'now' to match the check-in time format
    String nowStr = timeFormat.format(now).toUpperCase(); // Convert to uppercase
    print("Formatted now: $nowStr");

    try {
      // Ensure the check-in time string is well formatted and trimmed
      String checkInStr = checkInTime.value.trim().toUpperCase(); // Convert to uppercase
      print("Check-in time string: '$checkInStr'");
      print("Now time string: '$nowStr'");

      // Check if the check-in time string is valid
      if (!RegExp(r'^[0-9]{1,2}:[0-9]{2} [APM]{2}$').hasMatch(checkInStr)) {
        throw FormatException("Invalid time format: $checkInStr");
      }

      // Parse the formatted 'now' and 'check-in' times using the same format
      DateTime checkIn = timeFormat.parse(checkInStr);
      print("checkIn: $checkIn");
      DateTime formattedNow = timeFormat.parse(nowStr); // Parse nowStr
      print("formattedNow: $formattedNow");

      // Calculate the working duration
      Duration workingDuration = formattedNow.difference(checkIn);
      print("workingDuration: $workingDuration");

      // Format the working hours into a readable string
      String formattedWorkingHours =
          "${workingDuration.inHours}Hrs ${workingDuration.inMinutes.remainder(60)}min";

      totalWorkingHours.value = formattedWorkingHours;
      print("Total working hours: $formattedWorkingHours");
    } catch (e) {
      // Handle any parsing errors
      print("Error parsing time: $e");
      totalWorkingHours.value = "N/A";
    }
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is closed
    _timer?.cancel();
    super.onClose();
  }
}


