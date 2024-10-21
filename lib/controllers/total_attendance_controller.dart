import 'package:get/get.dart';
import 'package:nd_connect_techland/models/total_attendance_model.dart';

import '../services_apis/api_servicesss.dart';

class TotalAttendanceController extends GetxController{
  final isLoading = false.obs;
  RxList<TotalAttendanceData> attData = <TotalAttendanceData>[].obs;

  Future<void> AttendanceGraphApi() async {
    isLoading.value = true;
    try {
      List<TotalAttendanceData> apiTasks = await ApiProvider.AttendanceGraph();
      if (apiTasks.isNotEmpty) {
        attData.value = apiTasks;

      }
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
