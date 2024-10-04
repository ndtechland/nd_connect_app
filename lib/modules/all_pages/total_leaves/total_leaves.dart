import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/controllers/total_leaves_date_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/total_leaves/leaves_detail_page.dart';
import '../../../components/styles.dart';
import '../../../controllers/bottom_nav_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class TotalLeaves extends StatelessWidget {
  const TotalLeaves({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController());
    final TotalLeavesDateController totalLeavesDateController =
        Get.put(TotalLeavesDateController());
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    CalendarFormat calendarFormat =
        isPortrait ? CalendarFormat.week : CalendarFormat.week;
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.pink,
      Colors.yellow,
      Colors.orange,
      Colors.red,
      Colors.brown,
      Colors.deepPurple,
      Colors.cyan,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: Text(
          'Total Leaves',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              // bottomNavController.changeTabIndex(0);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return LayoutBuilder(
            builder: (context, constraints) {
              var screenWidth = constraints.maxWidth;
              var screenHeight = constraints.maxHeight;

              var imageWidth = orientation == Orientation.portrait
                  ? screenWidth * 0.55
                  : screenWidth * 0.25;
              var imageHeight = orientation == Orientation.portrait
                  ? screenHeight * 0.2
                  : screenHeight * 0.5;

              var imageWidth2 = orientation == Orientation.portrait
                  ? screenWidth * 0.3
                  : screenWidth * 0.19;
              var imageHeight2 = orientation == Orientation.portrait
                  ? screenHeight * 0.32
                  : screenHeight * 0.8;

              var categoryWidth = orientation == Orientation.portrait
                  ? screenWidth * 0.5
                  : screenWidth * 0.28;
              var categoryHeight = orientation == Orientation.portrait
                  ? screenHeight * 0.4
                  : screenHeight * 0.9;
              var taskListWidth = orientation == Orientation.portrait
                  ? screenWidth * 0.5
                  : screenWidth * 0.28;
              var taskListHeight = orientation == Orientation.portrait
                  ? screenHeight * 0.3
                  : screenHeight * 0.9;
              return Column(
                children: [
                  // Calendar Widget
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 14),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                width: 288,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(18),
                                    border:
                                        Border.all(color: Colors.grey.shade300)),
                                child: Text(
                                  DateFormat('d MMM y').format(
                                      totalLeavesDateController
                                          .selectedDate.value!),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            // IconButton(
                            //   onPressed: () async {
                            //     DateTime? pickedDate = await showDatePicker(
                            //       context: context,
                            //       initialDate: totalLeavesDateController.selectedDate.value,
                            //       firstDate: DateTime(2020),
                            //       lastDate: DateTime(2040),
                            //       builder: (context, child) {
                            //         return Theme(
                            //           data: Theme.of(context).copyWith(
                            //             colorScheme: ColorScheme.light(
                            //               primary: appColor2, // Header background color
                            //               onPrimary: Colors.white, // Header text color
                            //               onSurface: Colors.black, // Body text color
                            //             ),
                            //             textButtonTheme: TextButtonThemeData(
                            //               style: TextButton.styleFrom(
                            //                 foregroundColor: Colors.blue[900], // Button text color
                            //               ),
                            //             ),
                            //           ),
                            //           child: child!,
                            //         );
                            //       },
                            //
                            //       selectableDayPredicate: (day) {
                            //         // This predicate is used to customize the appearance of days
                            //         bool hasTask = totalLeavesDateController.allTasks
                            //             .any((task) => totalLeavesDateController.isSameDay(task.date, day));
                            //
                            //         // Highlight today's date
                            //         if (totalLeavesDateController.isSameDay(day, DateTime.now())) {
                            //           return true; // Allow selection of today
                            //         }
                            //
                            //         // Highlight days with tasks by returning true
                            //         return hasTask;
                            //       },
                            //     );
                            //
                            //     if (pickedDate != null) {
                            //       totalLeavesDateController.selectDate(pickedDate);
                            //     }
                            //   },
                            //   icon: Icon(Icons.calendar_month),
                            // ),

                            // IconButton(
                            //     onPressed: () async {
                            //       DateTime? pickedDate = await showDatePicker(
                            //         context: context,
                            //         initialDate:
                            //         totalLeavesDateController.selectedDate.value, // Use the selected date from the calendar
                            //         firstDate: DateTime(2020),
                            //         lastDate: DateTime(2040),
                            //         builder: (context, child) {
                            //           return Theme(
                            //             data: Theme.of(context).copyWith(
                            //               colorScheme: ColorScheme.light(
                            //                 primary: appColor2, // Header background color
                            //                 onPrimary: Colors.white, // Header text color
                            //                 onSurface: Colors.black, // Body text color
                            //               ),
                            //               textButtonTheme: TextButtonThemeData(
                            //                 style: TextButton.styleFrom(
                            //                   foregroundColor: Colors.blue[900], // Button text color
                            //                 ),
                            //               ),
                            //             ),
                            //             child: child!,
                            //           );
                            //         },
                            //       );
                            //
                            //       if (pickedDate != null) {
                            //         String formattedDate =
                            //         DateFormat('yyyy-MM-dd').format(pickedDate);
                            //         totalLeavesDateController.selectDate(pickedDate);
                            //       }
                            //     },
                            //     icon: Icon(Icons.calendar_month)),
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Obx(() => TableCalendar(
                                                  focusedDay:
                                                      totalLeavesDateController
                                                          .selectedDate.value,
                                                  firstDay: DateTime(2020),
                                                  lastDay: DateTime(2040),
                                                  calendarFormat:
                                                      CalendarFormat.month,
                                                  startingDayOfWeek:
                                                      StartingDayOfWeek.monday,
                                                  headerStyle: HeaderStyle(
                                                    formatButtonVisible: false,
                                                    titleCentered: true,
                                                    titleTextStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  onDaySelected: (selectedDay,
                                                      focusedDay) {
                                                    totalLeavesDateController
                                                        .selectDate(
                                                            selectedDay);
                                                    Navigator.pop(
                                                        context); // Close the dialog after selecting the date
                                                  },
                                                  selectedDayPredicate: (day) {
                                                    return totalLeavesDateController
                                                        .isSameDay(
                                                            totalLeavesDateController
                                                                .selectedDate
                                                                .value!,
                                                            day);
                                                  },
                                                  calendarStyle: CalendarStyle(
                                                    isTodayHighlighted: true,
                                                    todayDecoration:
                                                        BoxDecoration(
                                                      color: Colors.orange,
                                                      shape: BoxShape.circle,
                                                      // Set a fixed size using width and height in the builder
                                                    ),
                                                    selectedDecoration:
                                                        BoxDecoration(
                                                      color: Colors.blue[900],
                                                      shape: BoxShape.circle,
                                                      // Set a fixed size using width and height in the builder
                                                    ),
                                                    defaultDecoration:
                                                        BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    outsideDaysVisible: false,
                                                  ),
                                                  calendarBuilders:
                                                      CalendarBuilders(
                                                    defaultBuilder: (context,
                                                        day, focusedDay) {
                                                      bool hasTask =
                                                          totalLeavesDateController
                                                              .allLeave
                                                              .any((task) =>
                                                                  totalLeavesDateController
                                                                      .isSameDay(
                                                                          task.date,
                                                                          day));

                                                      return Stack(
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              '${day.day}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          if (totalLeavesDateController
                                                              .isSameDay(
                                                                  day,
                                                                  totalLeavesDateController
                                                                      .selectedDate
                                                                      .value!))
                                                            Center(
                                                              child: Container(
                                                                width:
                                                                    40, // Set width for selected date circle
                                                                height:
                                                                    40, // Set height for selected date circle
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .blue[
                                                                      900],
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    '${day.day}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (totalLeavesDateController
                                                              .isSameDay(
                                                                  day,
                                                                  DateTime
                                                                      .now()))
                                                            Center(
                                                              child: Container(
                                                                width:
                                                                    40, // Set width for today's date circle
                                                                height:
                                                                    40, // Set height for today's date circle
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .orange,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    '${day.day}',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (hasTask)
                                                            Positioned(
                                                              bottom: 4.0,
                                                              left: 0,
                                                              right: 0,
                                                              child: Center(
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      4.0, // Bigger dot for leaves
                                                                  height: 4.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red, // Red dot for days with leaves
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                )),
                                            SizedBox(height: 16.0),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Close the dialog without selecting any date
                                              },
                                              child: Text(
                                                "CLOSE",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )),
                  // Obx(()=>
                  //    Padding(
                  //     padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                  //     child: Row(
                  //       children: [
                  //         Container(
                  //           alignment: Alignment.centerLeft,
                  //           padding: EdgeInsets.fromLTRB(12,8,12,8),
                  //           width: 240,
                  //         height: 40,
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey[200],
                  //           borderRadius: BorderRadius.circular(18)
                  //         ),
                  //           child: Text(
                  //             DateFormat('d MMM y').format(totalLeavesDateController.selectedDate.value),
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 15,
                  //                 color: Colors.black),),
                  //         ),
                  //         IconButton(onPressed: ()async{
                  //           DateTime? pickedDate = await showDatePicker(
                  //             context: context,
                  //             initialDate: DateTime.now(),
                  //             firstDate: DateTime(1950),
                  //             lastDate: DateTime(2100),
                  //             selectableDayPredicate: (day) {
                  //               return totalLeavesDateController.isSameDay(
                  //                   totalLeavesDateController.selectedDate.value,
                  //                   day);
                  //             },
                  //
                  //           );
                  //
                  //           if (pickedDate != null) {
                  //             String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  //             totalLeavesDateController.selectDate(pickedDate);
                  //           }
                  //         }, icon: Icon(Icons.calendar_month))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 16.0),
                  // Task List
                  totalLeavesDateController.allLeave.isEmpty
                      ? const Center(child: Text("No Leave Found"))
                      : Expanded(
                          child: Obx(() => ListView.builder(
                                itemCount: totalLeavesDateController.leaveList.length,
                                itemBuilder: (context, index) {
                                  final task = totalLeavesDateController.leaveList[index];
                                  // Ensure leaveType is not null
                                  String leaveType = task.leaveType ??""; // Default value if null
                                  return Padding(padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        totalLeavesDateController.selectTask(index);
                                        Get.to(() => LeaveDetailPage(taskId: '$index'));
                                      },
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 2,
                                        child: Container(
                                          height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.11
                                              : constraints.maxHeight * 0.32, // Adjust height based on orientation
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: totalLeavesDateController.selectedLeaveIndex.value == index ? Colors.red : Colors.transparent, // Set border color based on selection
                                              width: totalLeavesDateController.selectedLeaveIndex.value == index ? 2.0 : 0.0,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color: leaveType == "full day" ? Colors.red : Colors.orangeAccent,
                                                //colors[index % colors.length],
                                                width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.025 : constraints.maxWidth * 0.015,
                                                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.12 : constraints.maxHeight * 0.32,),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(task.date.toString().substring(0, 10),
                                                          style: GoogleFonts.montserrat(textStyle: TextStyle(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : constraints.maxHeight * 0.06,
                                                          )),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          task.name,
                                                          style: GoogleFonts.montserrat(
                                                          textStyle:TextStyle(
                                                            fontWeight:FontWeight.w600,
                                                            fontSize: orientation ==Orientation.portrait? MediaQuery.of(context).size.height * 0.02
                                                                : constraints.maxHeight * 0.07,
                                                          )),
                                                        ),
                                                        Spacer(),
                                                        SizedBox(
                                                          width: orientation == Orientation.portrait
                                                              ? MediaQuery.of(context).size.width * 0.3
                                                              : constraints.maxWidth * 0.4, // Adjust width based on orientation
                                                          height: orientation == Orientation.portrait
                                                              ? MediaQuery.of(context).size.height * 0.02
                                                              : constraints.maxHeight * 0.06, // Adjust height based on orientation
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.alarm,
                                                                size: orientation == Orientation.portrait
                                                                    ? MediaQuery.of(context).size.height * 0.02
                                                                    : constraints.maxHeight * 0.05,
                                                              ),
                                                              Text(
                                                                "9:30 - 6:30",
                                                                style: GoogleFonts.lato(
                                                                    textStyle: TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 12,
                                                                        color: Colors.black87)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                //  color: Colors.yellow,
                                                width: orientation == Orientation.portrait
                                                    ? MediaQuery.of(context).size.width * 0.3
                                                    : constraints.maxWidth * 0.25, // Adjust width based on orientation
                                                height: orientation == Orientation.portrait
                                                    ? MediaQuery.of(context).size.height * 0.12
                                                    : constraints.maxHeight * 0.26, // Adjust height based on orientation
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(task.leaveType),
                                                      // Icon(
                                                      //   Icons.timelapse,
                                                      //   color: Colors.green,
                                                      //   size: orientation ==
                                                      //       Orientation.portrait
                                                      //       ? MediaQuery.of(context)
                                                      //       .size
                                                      //       .height *
                                                      //       0.03
                                                      //       : constraints.maxHeight *
                                                      //       0.09, // Adjust size based on orientation
                                                      // ),

                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(() => LeaveDetailPage(taskId: '$index'));

                                                          // Navigate to TaskDetailPage and pass the task ID (for example: 'taskId-$index')
                                                          // Get.to(() => TaskDetailPage(taskId: '$index'));
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: imageHeight * 0.2,
                                                          width: imageWidth * 0.4,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16),
                                                            border: Border.all(color: appColor2,width: 1),
                                                          ),
                                                          child: Text(
                                                            "See Details",
                                                            style: TextStyle(fontFamily: 'poppins',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
