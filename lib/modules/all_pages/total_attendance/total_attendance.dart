import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/styles.dart';
import '../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
class TotalAttendance extends StatelessWidget {
  const TotalAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    HomedashboardController _homedashboardController = Get.put(HomedashboardController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: Text(
          'Total Attendance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              //bottomNavController.changeTabIndex(0);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total Attendance in Year"),
            Text("${_homedashboardController.dashboardResponse?.data?.totalAttendance}/300",style: TextStyle(
              fontSize: 25,fontWeight: FontWeight.w500
            ),),
          ],
        ),
      ),
    );
  }
}
