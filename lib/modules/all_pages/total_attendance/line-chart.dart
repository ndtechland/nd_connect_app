import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nd_connect_techland/controllers/total_attendance_controller.dart';
import 'package:get/get.dart';
import '../../../components/styles.dart';
import '../../../constants/app_colorss/app_colorss.dart';
import '../../../models/total_attendance_model.dart';

class LineChartWidget extends StatelessWidget {
   LineChartWidget({super.key});
  final TotalAttendanceController totalAttendanceController = Get.put(TotalAttendanceController());
   List<int> monthNumbers=[];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(
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
                : screenHeight * 0.186;
            var fontsize = orientation == Orientation.portrait
                ? screenHeight * 0.1
                : screenHeight * 0.3;

            var categoryWidth = orientation == Orientation.portrait
                ? screenWidth * 0.5
                : screenWidth * 0.5;
            var categoryHeight = orientation == Orientation.portrait
                ? screenHeight * 0.9
                : screenHeight * 0.9;
            var taskListWidth = orientation == Orientation.portrait
                ? screenWidth * 0.9
                : screenWidth ;
            var taskListHeight = orientation == Orientation.portrait
                ? screenHeight * 0.4
                : screenHeight ;
            return Obx( () {
              if (totalAttendanceController.isLoading.value) {
                return CircularProgressIndicator();
              } else if (totalAttendanceController.attData.isEmpty) {
                return Text('No data available');
              } else {
                // String yearr = totalAttendanceController.attData.map((f)=>f.year).toString();
                return Material(
                  color: AppColors.th1wht2,
                  shadowColor: AppColors.black,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  child: Container(
                    height: categoryHeight * 0.55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: AppColors.th1wht2,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      //  border: Border.all(color: Colors.grey,width: 1)
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        Text("${totalAttendanceController.totalAttendanceData?.year.toString()}", style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600
                        ),),
                        SizedBox(
                          height: sizeHeight2 * 4.5,
                          // color: Colors.pink,
                          child: LayoutBuilder(
                              builder: (context, constraints) {
                                return LineChart(
                                  LineChartData(
                                    lineTouchData: lineTouchData(),
                                    gridData: gridData(),
                                    titlesData: titlesData(),
                                    borderData: borderData(),
                                    lineBarsData: lineBarsData(),
                                    minX: 0,
                                    maxX: 11,
                                    minY: 0,
                                    maxY: 30,
                                  ),
                                );
                              }
                          ),)
                      ],
                    ),
                  ),
                );
              }
            });
          });
        }
    );
  }
  // LineTouchData lineTouchData() => const LineTouchData(
  //   handleBuiltInTouches: true,
  // );
   LineTouchData lineTouchData() => LineTouchData(
     handleBuiltInTouches: true,
     touchTooltipData: LineTouchTooltipData(
       // tooltipBgColor: Colors.blueAccent.withOpacity(0.9),  // Tooltip background color
       tooltipRoundedRadius: 8,
       getTooltipItems: (List<LineBarSpot> touchedSpots) {
         return touchedSpots.map((LineBarSpot touchedSpot) {
           return LineTooltipItem(
             'Value: ${touchedSpot.y}',  // Tooltip text
             TextStyle(
               color: Colors.white,  // Text color inside tooltip
               fontWeight: FontWeight.bold,
             ),
           );
         }).toList();
       },
     ),
   );


   FlGridData gridData() => FlGridData(
    show: true,
    drawVerticalLine: true,
    horizontalInterval: 5,
    verticalInterval: 1,
    getDrawingHorizontalLine: (double _) => FlLine(
      color: Colors.black87.withOpacity(0.2),
      strokeWidth: 1,
    ),
    getDrawingVerticalLine: (double _) => FlLine(
      color: Colors.black87.withOpacity(0.2),
      strokeWidth: 1,
    ),
  );

  FlTitlesData titlesData() => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles(),
    ),
    rightTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: true,
        getTitlesWidget: rightTitleWidgets,
        reservedSize: 10,),
    ),
    topTitles:  AxisTitles(
      sideTitles: SideTitles(showTitles: true,
        getTitlesWidget: topTitleWidgets,
        reservedSize: 10,
      ),
    ),
    leftTitles:AxisTitles(
   sideTitles:  SideTitles(
      showTitles: true,
      interval: 5, // Show Y-axis labels at intervals of 5 (you can adjust as needed)
     reservedSize: 30,
      getTitlesWidget: (value, meta) {
        return Text('${value.toInt()}',textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black87,
          ),); // Display the Y-axis value as an integer
      },
    ),)
    // leftTitles: AxisTitles(
    //   sideTitles: leftTitles(),
    // ),
  );
  Text topTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '';
        break;
      case 6:
        text = '';
        break;
      case 7:
        text = '';
        break;
      default:
        text = '';
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }
  Text rightTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '';
        break;
      case 2:
        text = '';
        break;
      case 3:
        text = '';
        break;
      case 4:
        text = '';
        break;
      case 5:
        text = '';
        break;
      case 6:
        text = '';
        break;
      case 7:
        text = '';
        break;
      default:
        text = '';
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }
  SideTitles bottomTitles() => SideTitles(
    getTitlesWidget: bottomTitleWidgets,
    interval: 1,
    reservedSize: 50,
    showTitles: true,
  );

  SideTitleWidget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'J';
        break;
      case 1:
        text = 'F';
        break;
      case 2:
        text = 'M';
        break;
      case 3:
        text = 'A';
        break;
      case 4:
        text = 'M';
        break;
      case 5:
        text = 'J';
        break;
      case 6:
        text = 'J';
        break;
        case 7:
        text = 'A';
        break;
        case 8:
        text = 'S';
        break;
        case 9:
        text = 'O';
        break;
        case 10:
        text = 'N';
        break;
        case 11:
        text = 'D';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    interval: 5,
    reservedSize: 30,
    showTitles: true,
  );

  Text leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '5';
        break;
      case 2:
        text = '10';
        break;
      case 3:
        text = '15';
        break;
      case 4:
        text = '20';
        break;
      case 5:
        text = '25';
        break;
      case 6:
        text = '30';
        break;
      case 7:
        text = '35';
        break;
      default:
        text = '';
    }
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  FlBorderData borderData() => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
          color: Colors.black87
      //  color: const Color(0xFF50E4FF).withOpacity(0.2),
      //  width: 4,
      ),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  List<LineChartBarData> lineBarsData1() => [
  //  lineChartBarDataCurrentWeek(),
    lineChartBarDataPreviousWeek(),
  ];

   List<LineChartBarData> lineBarsData() {
     if (totalAttendanceController.attData.isEmpty) {
       return []; // No data yet
     }

     // Map months to X-axis indexes (starting from 0 for January)
     Map<String, double> monthToIndex = {
       "January": 0,
       "February": 1,
       "March": 2,
       "April": 3,
       "May": 4,
       "June": 5,
       "July": 6,
       "August": 7,
       "September": 8,
       "October": 9,
       "November": 10,
       "December": 11,
     };

     return [
       LineChartBarData(
         isCurved: true,
         color: appColor2,
         barWidth: 4,
         dotData: FlDotData(
           show: true,
           // getDotPainter: (FlSpot spot, double xPercentage, LineChartBarData bar, int index) {
           //   return FlDotCirclePainter(
           //     radius: 4,  // Size of the dot
           //     color: Colors.red,  // Fill color of the dot
           //     strokeColor: Colors.white,  // Border color of the dot
           //     strokeWidth: 2,  // Width of the dot border
           //   );
           // },
         ),
         belowBarData: BarAreaData(show: true, color: Colors.white.withOpacity(0.1)),
         spots: totalAttendanceController.attData.map((data) {
           // Map the month string to the corresponding X-axis index
           double xValue = monthToIndex[data.month] ?? 0.0;
           double yValue = data.value!.toDouble(); // Directly use the value for Y-axis
           print("Graph Month: ${data.month}, X: $xValue, Y: $yValue");

           return FlSpot(xValue, yValue);
         }).toList(),
       ),
     ];
   }

   LineChartBarData lineChartBarDataPreviousWeek() => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
  color: appColor2,
  //  color: Colors.deepOrangeAccent.withOpacity(0.8),
    barWidth: 2,
    belowBarData: BarAreaData(
      show: true,
    //  color: Colors.grey.shade50,
    ),
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
   // belowBarData: BarAreaData(show: false),
    spots:  [
      FlSpot(0, 0),
      FlSpot(1, 1),
      FlSpot(2, 2),
      FlSpot(3, 4),
      FlSpot(4, 5),
      FlSpot(5, 4),
      FlSpot(6, 1),
      FlSpot(7, 2),
      FlSpot(8, 4),
      FlSpot(9, 5),
      FlSpot(10, 5),
      FlSpot(11, 6),
    ],
  );
}
