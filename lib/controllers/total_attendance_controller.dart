import 'package:get/get.dart';
import 'package:nd_connect_techland/models/total_attendance_model.dart';

import '../services_apis/api_servicesss.dart';

class TotalAttendanceController extends GetxController{
  final isLoading = false.obs;
  RxList<Graphlist> attData = <Graphlist>[].obs;
  var attYear = "".obs;
  TotalAttendanceData? totalAttendanceData;
  Future<void> AttendanceGraphApi() async {
    isLoading.value = true;
    try {
      List<Graphlist> apiTasks = await ApiProvider.AttendanceGraph();
      if (apiTasks.isNotEmpty) {
        attData.value = apiTasks;
        // attYear.value= apiTasks
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> AttendanceGraphApi1() async {
    isLoading.value = true;
    try {
      totalAttendanceData = await ApiProvider.AttendanceGraph1();
      // if (totalAttendanceData?.isNotEmpty) {
      //   attYear.value = year as String;
      //   // attYear.value= apiTasks
      // }
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
