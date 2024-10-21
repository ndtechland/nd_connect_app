import 'package:get/get.dart';
import 'package:nd_connect_techland/models/current_month_attendance_model.dart';

import '../services_apis/api_servicesss.dart';
class CurrentMonthController extends GetxController{
  final isLoading = false.obs;
  CurrentMonthAttendanceModel? currentMonthAttendanceModel;
  @override
  void onInit() {
    super.onInit();
    AttendanceCurrentApi();
  }
  Future<void> AttendanceCurrentApi() async{
    isLoading.value = true;
    try{
      currentMonthAttendanceModel= await ApiProvider.CurrentMonthAttendance();
      if(currentMonthAttendanceModel?.data?.attendance==null){
        print("attendance detail null");
        isLoading(true);
        currentMonthAttendanceModel= await ApiProvider.CurrentMonthAttendance();
      }
      if(currentMonthAttendanceModel?.data?.attendance!=null) {
        print("attendance detail :${currentMonthAttendanceModel?.data}");
        isLoading(false);
      }
      isLoading(false);

    }catch(e){
      print("Error fetching details:$e");

    }
  }
}