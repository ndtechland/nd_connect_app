import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/bottom_bar/bottom_bar.dart';
import '../../services_apis/api_servicesss.dart';
class TasksController extends GetxController{
  final isLoading = false.obs;
  var taskId = 0.obs;
  var subTaskId = 0.obs;
  var reason = ''.obs;
  var completedTasks = <int, bool>{}.obs; // Observable map to track task completion status

  @override
  void onInit(){
    super.onInit();

  }

  Future<void> submitTask(int taskId, Map<String, int> formData) async {
    var response = await ApiProvider.subTaskCompleted(formData);
    if (response.statusCode == 200) {
      completedTasks[taskId] = true; // Mark task as completed for this ID
    } else {
      completedTasks[taskId] = false; // Mark task as not completed or failed
    }
  }
  Future<void> SubTaask({
    required int subTaskId,
  }) async{
    try{
      isLoading(true);

      final Map<String, int> formData = {
        'subtaskid': subTaskId,
      };
      final response = await ApiProvider.subTaskCompleted(formData);

      if (response.statusCode == 200) {
        print('taskk successfully!');
        // Get.offAll(Login());
        //Get.offAll(() => HomeEmployee());
        Get.offAll(() => BottomBar());
        print(response.body);
      } else {
        print('Error Apply Leave: ${response.statusCode}');
      }
    }catch(e) {
      print('Network error task: $e');
    } finally {
      isLoading(false);
    }

  }
  Future<void> CompletedTaask({
    required int taskId,
  }) async{
    try{
      isLoading(true);

      final Map<String, int> formData = {
        'taskid': taskId,
      };
      final response = await ApiProvider.TaskCompleted(formData);

      if (response.statusCode == 200) {
        print('taskk compl successfully!');
        // Get.offAll(Login());
        //Get.offAll(() => HomeEmployee());
        Get.offAll(() => BottomBar());
        print(response.body);
      } else {
        print('Error taskCompl Leave: ${response.statusCode}');
      }
    }catch(e) {
      print('Network error task: $e');
    } finally {
      isLoading(false);
    }

  }


  Future<void> InCompletedTaask({
    required String subtaskid,
    required String reason,
  }) async{
    try{
      isLoading(true);

      final Map<String, String> formData = {
        'subtaskid': subtaskid,
        'Taskreason': reason,
      };
      final response = await ApiProvider.UnCompletedTask(formData);

      if (response.statusCode == 200) {
        print('taskk Uncompl!');
        // Get.offAll(Login());
        //Get.offAll(() => HomeEmployee());
        Get.offAll(() => BottomBar());
        print(response.body);
      } else {
        print('Error UnCompl : ${response.statusCode}');
      }
    }catch(e) {
      print('Network error task: $e');
    } finally {
      isLoading(false);
    }

  }
}

