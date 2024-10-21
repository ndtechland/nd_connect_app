import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/constants/themes/theme_colors.dart';
import 'package:nd_connect_techland/models/task_model.dart';
import 'package:nd_connect_techland/services_apis/api_servicesss.dart';
// class DateTaskController extends GetxController {
//   // Initialize selectedDate with the current date
//   var selectedDate = DateTime.now().obs;
//   final isLoading = false.obs;
//
//   // List of tasks for the selected date
//   var taskList = <Task>[].obs;
//   RxList<TasksModells> tasks = <TasksModells>[].obs;
//
//
//   // All tasks (this would typically come from a data source)
//   final allTasks = <Task>[
//     Task(name: 'Task 1', date: DateTime(2024, 9, 1)),
//     Task(name: 'Task 2', date: DateTime(2024, 9, 3)),
//     Task(name: 'Task 3', date: DateTime(2024, 9, 5)),
//     Task(name: 'Task 4', date: DateTime(2024, 9, 10)),
//     Task(name: 'Task 4.1', date: DateTime(2024, 9, 10)),
//     Task(name: 'Task 5', date: DateTime(2024, 9, 15)),
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Select the nearest task date
//     selectNearestTaskDate();
//   }
//   Future<void> TaskAssignApi() async{
//     isLoading == true;
//     try{
//       tasks.value = await ApiProvider.getTaskAssign();
//     }catch(e){}
//   }
//   void selectDate(DateTime date) {
//     selectedDate.value = date;
//     // Update task list based on selected date
//     updateTasksForSelectedDate();
//   }
//
//   void selectNearestTaskDate() {
//     // Find the nearest task date
//     final today = DateTime.now();
//     final nearestTask = allTasks
//         .where((task) => task.date.isAfter(today))
//         .toList()
//       ..sort((a, b) => a.date.compareTo(b.date));
//
//     if (nearestTask.isNotEmpty) {
//       selectedDate.value = nearestTask.first.date;
//       updateTasksForSelectedDate();
//     }
//   }
//
//   void updateTasksForSelectedDate() {
//     // Update tasks for the selected date
//     taskList.clear();
//     taskList.addAll(allTasks
//         .where((task) => isSameDay(task.date, selectedDate.value))
//         .toList());
//   }
//
//   bool isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
// }
//
// class Task {
//   final String name;
//   final DateTime date;
//
//   Task({required this.name, required this.date});
// }

class DateTaskController extends GetxController {
  var selectedDate = DateTime.now().obs;
  final isLoading = false.obs;
  var taskList = <Task>[].obs;
  var taskData = {}.obs;
  var taskHisData = [].obs;
  RxList<TasksModells> tasks = <TasksModells>[].obs;
  final RxMap<DateTime, List<TasksModells>> taskts =
      <DateTime, List<TasksModells>>{}.obs;
  final allTasks = <Task>[
    // Task(name: 'Task 1', date: DateTime(2024, 10, 1), taskStatus: 'Pending', taskTitle: 'ND Connect', taskDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
    // Task(name: 'Task 2', date: DateTime(2024, 10, 3),taskStatus: 'Pending', taskTitle: 'ND Connect', taskDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
    // Task(name: 'Task 3', date: DateTime(2024, 10, 5),taskStatus: 'Pending', taskTitle: 'ND Connect', taskDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
    // Task(name: 'Task 4', date: DateTime(2024, 10, 6),taskStatus: 'Pending', taskTitle: 'ND Connect', taskDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
    // Task(name: 'Task 4.1', date: DateTime(2024, 10, 7),taskStatus: 'Pending', taskTitle: 'ND Connect', taskDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
    // Task(name: 'Task 5', date: DateTime(2024, 9, 30),taskStatus: 'Pending', taskTitle: 'ND Connect', taskDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'),
  ];
  @override
  void onInit() {
    super.onInit();
    selectNearestTaskDate();
    TaskAssignApi();
  }

  // Task Assign API function
  Future<void> TaskAssignApi() async {
    isLoading.value = true;
    try {
      List<TasksModells> apiTasks = await ApiProvider.getTaskAssign();
      if (apiTasks.isNotEmpty) {
        tasks.value = apiTasks;
        updateTasksForSelectedDate();
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTaskData(int idd) async {
    isLoading(true);
    try {
      var response = await ApiProvider.getTaskDetail(idd);
      if (response['succeeded']) {
        taskData.value = response['data'];
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (error) {
      Get.snackbar('Error', 'An error occurred: $error');
    } finally {
      isLoading(false);
    }
  }

  // Future<void> fetchTaskHisDetailData(int idd) async {
  //   isLoading(true);
  //   try {
  //     var response = await ApiProvider.getTaskHisDetail(idd);
  //     if (response['succeeded']) {
  //       taskHisData.value = response['data'];
  //     } else {
  //       Get.snackbar('Error', response['message']);
  //     }
  //   } catch (error) {
  //     Get.snackbar('Error', 'An error occurred: $error',backgroundColor: Colors.red,colorText: Colors.white);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  // Function to select a specific date
  void selectDate(DateTime date) {
    selectedDate.value = date;
    updateTasksForSelectedDate();
  }
  bool hasEvents(DateTime day) {
    final eventDate = DateTime(day.year, day.month, day.day);
    return taskts.containsKey(eventDate);
  }
  void selectNearestTaskDate() {
    final today = DateTime.now();
    final nearestTask = tasks.where((task) {
      return task.taskstartdate!.isAfter(today);
    }).toList()
      ..sort((a, b) => a.taskstartdate!.compareTo((b.taskstartdate!)));

    if (nearestTask.isNotEmpty) {
      selectedDate.value = nearestTask.first.taskstartdate!;
      updateTasksForSelectedDate();
    }
  }

  void updateTasksForSelectedDate() {
    taskList.clear();
    taskList.addAll(tasks.where((task) {
      return isSameDay(task.taskstartdate!, selectedDate.value);
    }).map((task) => Task(id: task.id!,name: task.taskName!, date1: task.taskstartdate!,date2: task.taskEnddate!,taskStatus: task.taskStatus.toString(),taskTitle: task.taskTittle.toString(),taskDescription: task.taskDescription.toString()))
        .toList());
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}

class Task {
  final int id;
  final String name;
  final String taskStatus;
  final String taskTitle;
  final String taskDescription;
  final DateTime date1;
  final DateTime date2;

  Task({required this.id,required this.name, required this.date1,required this.date2,required this.taskStatus,required this.taskTitle, required this.taskDescription});
}
