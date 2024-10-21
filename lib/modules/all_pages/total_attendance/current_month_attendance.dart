import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../components/styles.dart';
import '../../../controllers/attendance_controller.dart';
import '../../../controllers/current_month_controller.dart';
import '../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
class CurrentMonthAttendance extends StatelessWidget {
  const CurrentMonthAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    HomedashboardController _homedashboardController = Get.put(HomedashboardController());
    final AttendanceController attendanceController = Get.put(AttendanceController());
    final CurrentMonthController currentMonthController = Get.put(CurrentMonthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: Text(
          'Current Month Attendance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 17),
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
      body:OrientationBuilder(
        builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        var screenWidth = constraints.maxWidth;
        var screenHeight = constraints.maxHeight;

        var imageWidth = orientation == Orientation.portrait
            ? screenWidth * 0.55
            : screenWidth * 0.25;
        var imageHeight = orientation == Orientation.portrait
            ? screenHeight * 0.2
            : screenHeight * 0.5;

        var sizeWidth2 = orientation == Orientation.portrait
            ? screenWidth * 0.3
            : screenWidth * 0.19;
        var sizeHeight2 = orientation == Orientation.portrait
            ? screenHeight * 0.2
            : screenHeight * 0.4;
        var fontsize = orientation == Orientation.portrait
            ? screenHeight * 0.1
            : screenHeight * 0.3;

        var categoryWidth = orientation == Orientation.portrait
            ? screenWidth * 0.5
            : screenWidth * 0.5;
        var categoryHeight = orientation == Orientation.portrait
            ? screenHeight * 0.4
            : screenHeight * 0.9;
        var taskListWidth = orientation == Orientation.portrait
            ? screenWidth * 0.9
            : screenWidth ;
        var taskListHeight = orientation == Orientation.portrait
            ? screenHeight * 0.4
            : screenHeight ;
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Attendance Summary"  ,
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,fontSize: 17),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: categoryHeight * 0.5,
                      width: categoryWidth * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month_outlined,size: 30,color: Colors.blue,),
                            SizedBox(
                              height: sizeHeight2 * 0.1,
                            ),
                            Text(
                              "Total Attendance",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            SizedBox(height: 7,),
                            Text(
                              "${currentMonthController.currentMonthAttendanceModel?.data?.totalWorkingDays}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: categoryHeight * 0.5,
                      width: categoryWidth * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add_rounded,size: 30,color: Colors.green,),
                            SizedBox(
                              height: sizeHeight2 * 0.1,
                            ),
                            Text(
                              "Present",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "${currentMonthController.currentMonthAttendanceModel?.data?.totalPresentDays}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: categoryHeight * 0.5,
                      width: categoryWidth * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_add_disabled,size: 30,color: Colors.redAccent,),
                            SizedBox(
                              height: sizeHeight2 * 0.1,
                            ),
                            Text(
                              "Absence",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "${currentMonthController.currentMonthAttendanceModel?.data?.totalAbsentDays}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: categoryHeight * 0.5,
                      width: categoryWidth * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.incomplete_circle,size: 30,color: Colors.orangeAccent,),
                            SizedBox(
                              height: sizeHeight2 * 0.1,
                            ),
                            Text(
                              "Attendance",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "${currentMonthController.currentMonthAttendanceModel?.data?.attendance}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      });
        }
      ),
    );
  }
}