import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/models/task_history_model.dart';

import '../models/task_his_detail_model.dart';
import '../services_apis/api_servicesss.dart';
class TaskHistoryController extends GetxController{
  final isLoading = false.obs;
  TaskHistoryModel? taskHistoryModel;
  var taskList = <TaskHis>[].obs;
  var selectedDate = DateTime.now().obs;

  RxList<Completed> taskCom = RxList<Completed>([]);
  RxList<Completed> taskReassign = RxList<Completed>([]);
  RxList<Completed> taskUncom = RxList<Completed>([]);
  var taskHisData = [].obs;
  var taskTittle = ''.obs;
  var taskDescription = ''.obs;
  var taskDuration = ''.obs;
  RxList<TaskHisDetailData> tasks = <TaskHisDetailData>[].obs;

  @override
  void onInit() {
    super.onInit();
    TaskHistoryApi();
  }
  Future<void> TaskHistoryApi() async{
    isLoading.value = true;
    try{
      taskHistoryModel= await ApiProvider.TaskHistory();
      if(taskHistoryModel?.data?.completed==null){
        print("task history null");
        isLoading(true);
        taskHistoryModel= await ApiProvider.TaskHistory();
      }
      if(taskHistoryModel?.data?.completed!=null) {
        print("task history :${taskHistoryModel?.data}");
        taskCom.value = taskHistoryModel!.data!.completed!;
        taskReassign.value = taskHistoryModel!.data!.reassigned!;
        taskUncom.value = taskHistoryModel!.data!.unCompleted!;

        isLoading(false);
      }
      isLoading(false);

    }catch(e){
      print("Error fetching task history:$e");

    }
  }
  Future<void> fetchTaskHisDetailData(int idd) async {
    isLoading(true);
    try {
      print(" try succeeded");

      var response = await ApiProvider.getTaskHisDetail(idd);
      if (response['succeeded']) {
        print("succeeded");
        taskHisData.value = response['data'];
        // taskTittle.value = response['data']['taskTittle'];
        // taskDescription.value = response['data']['taskDescription'];
        // taskDuration.value = response['data']['duration'];
        // print("taskHisData contro:$taskHisData");
        // print("taskTittle contro:$taskTittle");
        // print("taskDescription contro:$taskDescription");
        // print("taskDuration contro:$taskDuration");
      } else {
        Get.snackbar('Error', response['message']);
      }
    } catch (error) {
      Get.snackbar('Error', 'An error occurred: $error',backgroundColor: Colors.red,colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
  void selectDate(DateTime date) {
    selectedDate.value = date;
   // updateTasksForSelectedDate();
  }


  // void updateTasksForSelectedDate() {
  //   taskHisData.clear();
  //   taskHisData.addAll(tasks.where((task) {
  //     return isSameDay(task!, selectedDate.value);
  //   }).map((task) => Task(id: task.id!,name: task.taskName!, date1: task.taskstartdate!,date2: task.taskEnddate!,taskStatus: task.taskStatus.toString(),taskTitle: task.taskTittle.toString(),taskDescription: task.taskDescription.toString()))
  //       .toList());
  // }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}

class TaskHis {
  final int id;
  final String duration;
  final String taskStatus;
  final String taskTitle;
  final String taskSubTitle;
  final String taskDescription;


  TaskHis({required this.id,required this.duration,required this.taskStatus,required this.taskTitle, required this.taskSubTitle, required this.taskDescription});
}