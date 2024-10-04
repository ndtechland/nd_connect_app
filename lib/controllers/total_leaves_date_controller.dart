import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class TotalLeavesDateController extends GetxController {
  // Initialize selectedDate with the current date
  var selectedDate = DateTime.now().obs;
  //var selectedDate = Rxn<DateTime>();

  // List of tasks for the selected date
  var leaveList = <TotalLeavesDate>[].obs;
  var selectedLeaveIndex = (-1).obs; // New observable to track selected index

  // All tasks (this would typically come from a data source)
  final allLeave = <TotalLeavesDate>[
    TotalLeavesDate(name: 'TotalLeaves 1',leaveType: 'full day' ,date: DateTime(2024, 9, 1)),
    TotalLeavesDate(name: 'TotalLeaves 2',leaveType: 'half day' ,date: DateTime(2024, 9, 24)),
    TotalLeavesDate(name: 'TotalLeaves 3',leaveType: 'half day' ,date: DateTime(2024, 9, 20)),
    TotalLeavesDate(name: 'TotalLeaves 4',leaveType: 'full day' ,date: DateTime(2024, 9, 22)),
 //   TotalLeavesDate(name:'TotalLeaves 4.1,leaveType: 'full day', date: DateTime(2024, 9, 10)),
    TotalLeavesDate(name: 'TotalLeaves 5',leaveType: 'full day' ,date: DateTime(2024, 9, 15)),
  ];

  @override
  void onInit() {
    super.onInit();
    // Select the nearest TotalLeavesDate date
    selectNearestLeaveDate();
    leaveList.addAll(allLeave);
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    // Update TotalLeavesDate list based on selected date
    updateLeaveForSelectedDate();
  }

  void selectNearestLeaveDate() {
    // Find the nearest TotalLeavesDate date
    final today = DateTime.now();
    final nearestTask = allLeave
        .where((TotalLeavesDate) => TotalLeavesDate.date.isAfter(today))
        .toList()..sort((a, b) => a.date.compareTo(b.date));

    if (nearestTask.isNotEmpty) {
      selectedDate.value = nearestTask.first.date;
      updateLeaveForSelectedDate();
    }
  }
  void updateLeaveForSelectedDate() {
    // If the selected date is null or not selected, show all leaves
    leaveList.clear();
    if (selectedDate.value == null) {
      leaveList.addAll(allLeave);
    } else {
      leaveList.addAll(allLeave.where((TotalLeavesDate leave) => isSameDay(leave.date, selectedDate.value)).toList());
    }
  }
  // // Clear the selected date and show full leave list
  // void clearSelectedDate() {
  //   selectedDate.value = null;
  //   updateLeaveForSelectedDate();
  // }
  // void updateLeaveForSelectedDate() {
  //   // Update tasks for the selected date
  //   leaveList.clear();
  //   leaveList.addAll(allLeave
  //       .where((TotalLeavesDate) => isSameDay(TotalLeavesDate.date, selectedDate.value))
  //       .toList());
  // }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
  void selectTask(int index) {
    selectedLeaveIndex.value = index;
  }
}

class TotalLeavesDate {
  final String name;
  final String leaveType;
  final DateTime date;

  TotalLeavesDate({required this.name,required this.leaveType, required this.date});
}