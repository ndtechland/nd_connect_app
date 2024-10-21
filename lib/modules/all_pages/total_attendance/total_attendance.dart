// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../components/styles.dart';
// import '../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
//
// class DataItem {
//   int x;
//   double y1;
//   double y2;
//   double y3;
//   DataItem(
//       {required this.x, required this.y1, required this.y2, required this.y3});
// }
// class TotalAttendance extends StatelessWidget {
//   TotalAttendance({Key? key}) : super(key: key);
//   // Generate dummy data to feed the chart
//   final List<DataItem> _myData = List.generate(
//       30,
//           (index) => DataItem(
//         x: index,
//         y1: Random().nextInt(20) + Random().nextDouble(),
//         y2: Random().nextInt(20) + Random().nextDouble(),
//         y3: Random().nextInt(20) + Random().nextDouble(),
//       ));
//   @override
//   Widget build(BuildContext context) {
//     HomedashboardController _homedashboardController = Get.put(HomedashboardController());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//               //bottomNavController.changeTabIndex(0);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             )),
//         backgroundColor: appColor2,
//         title: const Text('Total Attendance',style: TextStyle(
//           color: Colors.white
//         ),),
//       ),
//       body: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 80,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.grey.shade300,width: 1)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 18.0,right: 18.0),
//                   child: Row(
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         height: 50,
//                         width: 50,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.green.shade100,
//                            // border: Border.all(color: Colors.grey.shade300,width: 1)
//                         ),
//                         child: Icon(Icons.insert_chart,color: Colors.teal,size: 25,),
//                       ),
//                       SizedBox(width: 10,),
//                       Container(
//                         height: 50,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                           Text("Total Attendance",style: TextStyle(
//                             color: Colors.grey,fontSize: 14
//                           ),),
//                             RichText(text: TextSpan(text:("${_homedashboardController.dashboardResponse?.data?.totalAttendance} "), style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87
//                               // fontFamily: 'poppins'
//                             ),
//                             children: [
//                               TextSpan(text:("/ year"),style: TextStyle(
//                                   color: Colors.grey,fontSize: 14
//                               ),)
//                             ]),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//
//               Container(
//                 height: 340,
//                 width: 400,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.grey.shade300,width: 1)),
//                 child: BarChart(BarChartData(
//                     borderData: FlBorderData(
//                         border: const Border(
//                           top: BorderSide.none,
//                           right: BorderSide.none,
//                           // left: BorderSide(width: 1),
//                           bottom: BorderSide(width: 1),
//                         )),
//                     groupsSpace: 10,
//                     titlesData: FlTitlesData(
//                       show: false
//                     ),
//                     barGroups: [
//                       BarChartGroupData(x: 1, barRods: [
//                         BarChartRodData(fromY: 0, toY: 10, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 2, barRods: [
//                         BarChartRodData(fromY: 0, toY: 10, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 3, barRods: [
//                         BarChartRodData(fromY: 0, toY: 15, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 4, barRods: [
//                         BarChartRodData(fromY: 0, toY: 10, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 5, barRods: [
//                         BarChartRodData(fromY: 0, toY: 11, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 6, barRods: [
//                         BarChartRodData(fromY: 0, toY: 10, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 7, barRods: [
//                         BarChartRodData(fromY: 0, toY: 10, width: 15, color: appColor2),
//                       ]),
//                       BarChartGroupData(x: 8, barRods: [
//                         BarChartRodData(fromY: 0, toY: 10, width: 15, color: appColor2),
//                       ]),
//                     ])),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../components/styles.dart';
import '../../../constants/app_colorss/app_colorss.dart';
import '../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import 'line-chart.dart';

class TotalAtendance extends StatefulWidget {
   TotalAtendance({super.key});

  final Color barBackgroundColor = AppColors.contentColorWhite.withOpacity(0.3);
  final Color barColor = AppColors.a13;
  @override
  State<TotalAtendance> createState() => _TotalAtendanceState();
}

class _TotalAtendanceState extends State<TotalAtendance> {
  HomedashboardController _homedashboardController = Get.put(HomedashboardController());

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> dummyData1 = List.generate(12, (index) {
      return FlSpot(index.toDouble(), index * Random().nextDouble() * 30);
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: appColor2,
        title: const Text('Total Attendance', style: TextStyle(color: Colors.white)),
      ),
      body: OrientationBuilder(
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
                ? screenWidth * 0.9
                : screenWidth ;
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
                ? screenHeight * 0.7
                : screenHeight ;
            var taskListWidth = orientation == Orientation.portrait
                ? screenWidth * 0.9
                : screenWidth ;
            var taskListHeight = orientation == Orientation.portrait
                ? screenHeight * 0.4
                : screenHeight ;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Container(
                        height: sizeHeight2*0.6,
                        width: sizeWidth2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0),
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade100,
                                ),
                                child: Icon(
                                  Icons.insert_chart,
                                  color: Colors.teal,
                                  size: 25,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Attendance",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "${_homedashboardController
                                            .dashboardResponse?.data
                                            ?.totalAttendance} ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "/ year",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: categoryHeight*0.8,
                         // color: Colors.yellow,
                          child: LineChartWidget()),
                      SizedBox(height: 30),

                      // Material(
                      //   color: AppColors.th1wht2,
                      //   shadowColor: AppColors.black,
                      //   borderRadius: BorderRadius.circular(10),
                      //   elevation: 5,
                      //   child: Container(
                      //     height: size.height * 0.5,
                      //     decoration: BoxDecoration(
                      //       color: AppColors.th1wht2,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     padding: const EdgeInsets.all(2),
                      //     width: double.infinity,
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           height: screenHeight / 2.3,
                      //          // color: Colors.pink,
                      //           width: double.infinity,
                      //           child: LayoutBuilder(
                      //             builder: (context, constraints) {
                      //               return LineChart(
                      //                 LineChartData(
                      //                   titlesData: FlTitlesData(
                      //                     leftTitles: AxisTitles(
                      //                       sideTitles: SideTitles(
                      //                         showTitles: true,
                      //                         interval: 1,
                      //                         getTitlesWidget: (value, meta) {
                      //                           return leftTitleWidgets(value, meta, constraints.maxWidth);
                      //                         },
                      //                         reservedSize: 27,
                      //                       ),
                      //                     ),
                      //                     bottomTitles: AxisTitles(
                      //                       sideTitles: SideTitles(
                      //                         showTitles: true,
                      //                         interval: 1,
                      //                         getTitlesWidget: (value, meta) {
                      //                           return bottomTitleWidgets2(value, meta, constraints.maxWidth);
                      //                         },
                      //                         reservedSize: 20,
                      //                       ),
                      //                     ),
                      //                     rightTitles: AxisTitles(
                      //                       sideTitles: SideTitles(
                      //                         showTitles: false,
                      //                         reservedSize: 30,
                      //                       ),
                      //                     ),
                      //                     topTitles: AxisTitles(
                      //                       sideTitles: SideTitles(
                      //                         showTitles: false,
                      //                         reservedSize: screenHeight / 62,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   borderData: FlBorderData(show: false),
                      //                   lineBarsData: [
                      //                     LineChartBarData(
                      //                       spots: dummyData1,
                      //                       isCurved: false,
                      //                       barWidth: 2,
                      //                       color: Colors.red,
                      //                       belowBarData: BarAreaData(
                      //                         show: true,
                      //                         color: Color(0xffF1F1F1),
                      //                       ),
                      //                     ),
                      //                     LineChartBarData(
                      //                       spots: dummyData1,
                      //                       isCurved: false,
                      //                       barWidth: 2,
                      //                       color: AppColors.graphline,
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          });
        }
      ),
    );
  }
}

