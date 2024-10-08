// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';
// //
// // class DateTaskController extends GetxController {
// //   var selectedDate = DateTime.now().obs;
// //   var dates = <DateTime>[].obs;
// //
// //   // Sample task data by date
// //   final Map<String, List<String>> tasksByDate = {
// //     '2024-09-10': ['Task 1', 'Task 2'],
// //     '2024-09-11': ['Task 3', 'Task 4'],
// //     '2024-09-12': ['Task 5', 'Task 6'],
// //     '2024-09-13': ['Task 7'],
// //   };
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     generateDatesForMonths(3); // Generate dates for 3 months
// //   }
// //
// //   // Function to generate all dates for a specific month and year
// //   List<DateTime> getDatesInMonth(int month, int year) {
// //     List<DateTime> dates = [];
// //     int daysInMonth = DateTime(year, month + 1, 0).day; // Get the number of days in the month
// //
// //     for (int i = 1; i <= daysInMonth; i++) {
// //       dates.add(DateTime(year, month, i));
// //     }
// //
// //     return dates;
// //   }
// //
// //   // Generate dates for the next n months
// //   void generateDatesForMonths(int numberOfMonths) {
// //     DateTime currentDate = DateTime.now();
// //     dates.clear();
// //
// //     for (int i = 0; i < numberOfMonths; i++) {
// //       int currentMonth = currentDate.month + i;
// //       int currentYear = currentDate.year;
// //
// //       // Adjust the year if the month exceeds 12
// //       if (currentMonth > 12) {
// //         currentMonth -= 12;
// //         currentYear += 1;
// //       }
// //
// //       dates.addAll(getDatesInMonth(currentMonth, currentYear));
// //     }
// //   }
// //
// //   // Get tasks for the selected date
// //   List<String> getTasksForDate(DateTime date) {
// //     String formattedDate = DateFormat('yyyy-MM-dd').format(date);
// //     return tasksByDate[formattedDate] ?? [];
// //   }
// // }
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class DateTaskController extends GetxController {
//   var selectedDate = DateTime.now().obs;  // Initially the current date
//   var dates = <DateTime>[].obs;
//
//   // Sample task data by date
//   final Map<String, List<String>> tasksByDate = {
//     '2024-09-10': ['Task 1', 'Task 2'],
//     '2024-09-11': ['Task 3', 'Task 4'],
//     '2024-09-12': ['Task 5', 'Task 6'],
//     '2024-09-13': ['Task 7'],
//   };
//
//   @override
//   void onInit() {
//     super.onInit();
//     generateDatesForMonths(3); // Generate dates for 3 months
//     // Ensure the initial task list is for today's date
//     selectedDate.value = stripTime(DateTime.now());
//   }
//
//   // Function to generate all dates for a specific month and year
//   List<DateTime> getDatesInMonth(int month, int year) {
//     List<DateTime> dates = [];
//     int daysInMonth = DateTime(year, month + 1, 0).day; // Get the number of days in the month
//
//     for (int i = 1; i <= daysInMonth; i++) {
//       dates.add(DateTime(year, month, i)); // Generate dates without time
//     }
//
//     return dates;
//   }
//
//   // Generate dates for the next n months
//   void generateDatesForMonths(int numberOfMonths) {
//     DateTime currentDate = DateTime.now();
//     dates.clear();
//
//     for (int i = 0; i < numberOfMonths; i++) {
//       int currentMonth = currentDate.month + i;
//       int currentYear = currentDate.year;
//
//       // Adjust the year if the month exceeds 12
//       if (currentMonth > 12) {
//         currentMonth -= 12;
//         currentYear += 1;
//       }
//
//       dates.addAll(getDatesInMonth(currentMonth, currentYear));
//     }
//   }
//
//   // Get tasks for the selected date
//   List<String> getTasksForDate(DateTime date) {
//     String formattedDate = DateFormat('yyyy-MM-dd').format(date);
//     return tasksByDate[formattedDate] ?? [];
//   }
//
//   // Strip time from DateTime for accurate comparison
//   DateTime stripTime(DateTime dateTime) {
//     return DateTime(dateTime.year, dateTime.month, dateTime.day);
//   }
//
//   // Helper method to compare two DateTime objects and check if they represent the same day
//   bool isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
// }
//
//
//
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DateTaskController extends GetxController {
  // Initialize selectedDate with the current date
  var selectedDate = DateTime.now().obs;

  // List of tasks for the selected date
  var taskList = <Task>[].obs;

  // All tasks (this would typically come from a data source)
  final allTasks = <Task>[
    Task(name: 'Task 1', date: DateTime(2024, 9, 1)),
    Task(name: 'Task 2', date: DateTime(2024, 9, 3)),
    Task(name: 'Task 3', date: DateTime(2024, 9, 5)),
    Task(name: 'Task 4', date: DateTime(2024, 9, 10)),
    Task(name: 'Task 4.1', date: DateTime(2024, 9, 10)),
    Task(name: 'Task 5', date: DateTime(2024, 9, 15)),
  ];

  @override
  void onInit() {
    super.onInit();
    // Select the nearest task date
    selectNearestTaskDate();
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    // Update task list based on selected date
    updateTasksForSelectedDate();
  }

  void selectNearestTaskDate() {
    // Find the nearest task date
    final today = DateTime.now();
    final nearestTask = allTasks
        .where((task) => task.date.isAfter(today))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (nearestTask.isNotEmpty) {
      selectedDate.value = nearestTask.first.date;
      updateTasksForSelectedDate();
    }
  }

  void updateTasksForSelectedDate() {
    // Update tasks for the selected date
    taskList.clear();
    taskList.addAll(allTasks
        .where((task) => isSameDay(task.date, selectedDate.value))
        .toList());
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

class Task {
  final String name;
  final DateTime date;

  Task({required this.name, required this.date});
}