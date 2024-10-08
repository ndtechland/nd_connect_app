// // // import 'package:flutter/material.dart';
// // // import 'package:nd_connect_techland/components/styles.dart';
// // // import 'package:get/get.dart';
// // //
// // // import '../../../../controllers/bottom_nav_controller.dart';
// // // class Task extends StatelessWidget {
// // //   const Task({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final BottomNavController bottomNavController = Get.find<BottomNavController>();
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: appColor2,
// // //         leading: IconButton(onPressed: (){
// // //           bottomNavController.changeTabIndex(0);
// // //         }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
// // //         centerTitle: true,
// // //         title: Text("Task",style: TextStyle(
// // //             color: Colors.white,fontSize: 20
// // //         ),),
// // //       ),
// // //       body: Center(
// // //         child: Container(
// // //           child: Text("Task",style: TextStyle(
// // //               color: Colors.black,fontSize: 20
// // //           ),),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// //
// // class TaskList extends StatefulWidget {
// //   const TaskList({Key? key}) : super(key: key);
// //
// //   @override
// //   _TaskListState createState() => _TaskListState();
// // }
// //
// // class _TaskListState extends State<TaskList> {
// //   DateTime selectedDate = DateTime.now();
// //   List<Task> tasks = [
// //     Task(
// //         date: DateTime(2023, 8, 19),
// //         title: 'Research Process',
// //         time: '07:00 - 09:00'),
// //     Task(
// //         date: DateTime(2023, 8, 19),
// //         title: 'Moodboard Search',
// //         time: '09:00 - 12:00'),
// //     // ... Add more tasks here
// //   ];
// //
// //   void _selectDate(DateTime newDate) {
// //     setState(() {
// //       selectedDate = newDate;
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           // Top bar with date selection
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               IconButton(
// //                 icon: const Icon(Icons.arrow_back),
// //                 onPressed: () {
// //                   // Implement navigation logic here
// //                 },
// //               ),
// //               Text(
// //                 selectedDate.toString().substring(0, 10),
// //                 style: const TextStyle(fontSize: 18),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.calendar_today),
// //                 onPressed: () async {
// //                   final DateTime? pickedDate = await showDatePicker(
// //                     context: context,
// //                     initialDate: selectedDate,
// //                     firstDate: DateTime(2023, 8, 1),
// //                     lastDate: DateTime(2023, 12, 31),
// //                   );
// //                   if (pickedDate != null) {
// //                     _selectDate(pickedDate);
// //                   }
// //                 },
// //               ),
// //             ],
// //           ),
// //
// //           // Task list
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: tasks.where((task) => task.date == selectedDate).length,
// //               itemBuilder: (context, index) {
// //                 final task = tasks.firstWhere(
// //                         (task) => task.date == selectedDate,
// //                     orElse: () => Task(date: DateTime.now(), title: '', time: ''));
// //                 return ListTile(
// //                   title: Text(task.title),
// //                   subtitle: Text(task.time),
// //                   onTap: () {
// //                     // Implement task details or action logic here
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class Task {
// //   final DateTime date;
// //   final String title;
// //   final String time;
// //
// //   Task({required this.date, required this.title, required this.time});
// // }
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nd_connect_techland/components/styles.dart';
// import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/task_details_page.dart';
// import '../../../../controllers/bottom_nav_controller.dart';
// import '../../../../controllers/task_list_controller.dart';
// import 'package:intl/intl.dart';
//
// class TaskList extends StatelessWidget {
//   final DateTaskController dateTaskController = Get.put(DateTaskController());
//   final BottomNavController bottomNavController = Get.find<BottomNavController>();
//   List<Color> colorrs=[
//     Colors.blue,
//     Colors.green,
//     Colors.pink,
//     Colors.yellow,
//     Colors.orange,
//     Colors.red,
//     Colors.brown,
//     Colors.deepPurple,
//     Colors.cyan,
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: appColor2,
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 bottomNavController.changeTabIndex(0);
//               },
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               )),
//           title: Text(
//             'Task Calendar',
//             style: TextStyle(color: Colors.white,
//                 fontFamily: 'poppins',fontWeight: FontWeight.w600
//             ),
//           )),
//       body: OrientationBuilder(builder: (context, orientation) {
//         return LayoutBuilder(builder: (context, constraints) {
//           var screenWidth = constraints.maxWidth;
//           var screenHeight = constraints.maxHeight;
//
//           var imageWidth = orientation == Orientation.portrait
//               ? screenWidth * 0.55
//               : screenWidth * 0.25;
//           var imageHeight = orientation == Orientation.portrait
//               ? screenHeight * 0.2
//               : screenHeight * 0.5;
//
//           var imageWidth2 = orientation == Orientation.portrait
//               ? screenWidth * 0.3
//               : screenWidth * 0.19;
//           var imageHeight2 = orientation == Orientation.portrait
//               ? screenHeight * 0.32
//               : screenHeight * 0.8;
//
//           var categoryWidth = orientation == Orientation.portrait
//               ? screenWidth * 0.5
//               : screenWidth * 0.28;
//           var categoryHeight = orientation == Orientation.portrait
//               ? screenHeight * 0.4
//               : screenHeight * 0.9;
//           var taskListWidth = orientation == Orientation.portrait
//               ? screenWidth * 0.5
//               : screenWidth * 0.28;
//           var taskListHeight = orientation == Orientation.portrait
//               ? screenHeight * 0.3
//               : screenHeight * 0.9;
//
//           // Format current month name
//           final currentMonth = DateFormat('MMMM yyyy').format(dateTaskController.selectedDate.value);
//
//           return SingleChildScrollView(
//             child: Container(
//               height: screenHeight,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 15,
//                   ),
//                   // Display month name
//                   Padding(
//                     padding: const EdgeInsets.only(left: 14.0),
//                     child: Text(
//                       currentMonth,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'poppins'
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   // Horizontally scrollable date calendar
//                   Container(
//                     height: categoryHeight * 0.28,
//                     child: Obx(() {
//                       return ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: dateTaskController.dates.length,
//                         itemBuilder: (context, index) {
//                           final date = dateTaskController.dates[index];
//                           final isSelected = dateTaskController.isSameDay(
//                             dateTaskController.selectedDate.value,
//                             date,
//                           );
//                           final weekday = DateFormat('EEEE').format(date);
//                           return GestureDetector(
//                               onTap: () {
//                                 // Update the selected date
//                                 dateTaskController.selectedDate.value =
//                                     dateTaskController.stripTime(date);
//                               },
//                               child: Container(
//                                 width: categoryWidth * 0.3,
//                                 margin: EdgeInsets.symmetric(horizontal: 8.0),
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? appColor2
//                                       : Colors.grey[
//                                   200], // Highlight the selected date
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: isSelected
//                                       ? Border.all(
//                                       color: appColor2,
//                                       width: 2) // Border for selected date
//                                       : Border.all(
//                                       color: Colors.transparent, width: 2),
//                                 ),
//                                 child: Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "${date.day}",
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? Colors.white
//                                               : Colors
//                                               .black, // Change text color for selected date
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       Text(
//                                         weekday.substring(0,3),
//                                         style: TextStyle(
//                                           color: isSelected
//                                               ? Colors.white
//                                               : Colors
//                                               .black, // Change text color for selected date
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ));
//                         },
//                       );
//                     }),
//                   ),
//                   SizedBox(height: 20),
//
//                   // Task list for the selected date
//                   Expanded(
//                     child: Obx(() {
//                       final tasks = dateTaskController
//                           .getTasksForDate(dateTaskController.selectedDate.value);
//
//                       if (tasks.isEmpty) {
//                         return Center(child: Text('No tasks for this date'));
//                       }
//
//                       return ListView.builder(
//                         itemCount: tasks.length,
//                         itemBuilder: (context, index) {
//                           final task = tasks[index];
//                           return Padding(
//                             padding: const EdgeInsets.fromLTRB(14.0,0,14,14),
//                             child: Card(
//                               clipBehavior: Clip.antiAlias,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               elevation: 2,
//                               child: Container(
//                                 height: taskListHeight*0.5,
//                                 decoration: BoxDecoration(
//                                   //color: Colors.pink,
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       color: colorrs[index],
//                                       width: imageWidth2*0.1,
//                                       height: taskListHeight*0.5,
//                                     ),
//                                     // Expanded(
//                                     //   child: ListTile(
//                                     //     title: Text(task),
//                                     //   ),
//                                     // ),
//                                     Expanded(
//                                       child: Container(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(12.0),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text("Project",style: GoogleFonts.montserrat(
//                                                     textStyle: TextStyle(
//                                                       fontWeight: FontWeight.w500,
//                                                       fontSize: 14
//                                                     )
//                                                   ),),
//                                                   Text(task,
//                                                     style: GoogleFonts.montserrat(
//                                                         textStyle: TextStyle(
//                                                             fontWeight: FontWeight.w600,
//                                                             fontSize: 18
//                                                         )
//                                                     ),),
//                                                   Spacer(),
//                                                   Row(
//                                                     children: [
//                                                       Icon(Icons.access_time,color: Colors.black87,
//                                                       size: 14,),
//                                                       SizedBox(width: 5,),
//                                                       Text("9:30 - 6:30",style: GoogleFonts.lato(
//                                                           textStyle: TextStyle(
//                                                               fontWeight: FontWeight.w500,
//                                                               fontSize: 12,
//                                                             color: Colors.black87
//                                                           )
//                                                       ),)
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                               Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                                 children: [
//                                                   Container(
//                                                     height: imageHeight2*0.1,
//                                                     width: imageWidth2*0.2,
//                                                     decoration: BoxDecoration(
//                                                     // color: Colors.pink,
//                                                      //  image: DecorationImage(image:
//                                                      //  AssetImage("lib/assets/icon/progress.png"),
//                                                      //    //colorFilter: ColorFilter.mode(Colors.green.withOpacity(0.7), BlendMode.color),
//                                                      //  )
//                                                     ),
//                                                     child: Image.asset("lib/assets/icon/progress.png",color: Colors.green,),
//                                                   ),
//                                                   Spacer(),
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       // Navigate to TaskDetailPage and pass the task ID (for example: 'taskId-$index')
//                                                       Get.to(() => TaskDetailPage(taskId: '$index'));
//                                                     },
//                                                     child: Container(
//                                                       alignment: Alignment.center,
//                                                       height: imageHeight * 0.2,
//                                                       width: imageWidth * 0.4,
//                                                       decoration: BoxDecoration(
//                                                         borderRadius: BorderRadius.circular(16),
//                                                         border: Border.all(color: appColor2, width: 1),
//                                                       ),
//                                                       child: Text(
//                                                         "See Details",
//                                                         style: TextStyle(
//                                                           fontFamily: 'poppins',
//                                                           fontSize: 12,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controllers/bottom_nav_controller.dart';
import '../../../controllers/task_list_controller.dart';
import '../pages/willPop_scope_exit.dart';

class TaskList extends StatelessWidget {
  String id ='11';
  TaskList ({super.key, Key,required this.id});
  final DateTaskController controller = Get.put(DateTaskController());
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

  @override
  Widget build(BuildContext context) {
    bool shouldPop = true;
    // Determine the calendar format based on the screen orientation
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    CalendarFormat calendarFormat =
        isPortrait ? CalendarFormat.week : CalendarFormat.week;
    final BottomNavController bottomNavController = Get.find<BottomNavController>();
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      // onWillPop: () async {
      //   bottomNavController.changeTabIndex(0);
      //   return shouldPop;
      // },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColor2,
          title: Text(
            'Task Manager',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                bottomNavController.changeTabIndex(0);
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
                    Obx(() => TableCalendar(
                          focusedDay: controller.selectedDate.value,
                          firstDay: DateTime(2020),
                          lastDay: DateTime(2040),
                          calendarFormat: calendarFormat,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: (selectedDay, focusedDay) {
                            controller.selectDate(selectedDay);
                          },
                          selectedDayPredicate: (day) {
                            return controller.isSameDay(
                                controller.selectedDate.value, day);
                          },
                          calendarStyle: CalendarStyle(
                            isTodayHighlighted: true,
                            selectedDecoration: BoxDecoration(
                              color: Colors
                                  .blue[900], // Dark color for selected date
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.5), // Shadow color
                                  offset: Offset(0, 3), // Shadow offset
                                  blurRadius: 4, // Shadow blur radius
                                ),
                              ],
                            ),
                            todayDecoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            defaultDecoration: BoxDecoration(
                              color: Colors
                                  .transparent, // Default transparent for unselected dates
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            // Customize day builder
                            defaultBuilder: (context, day, focusedDay) {
                              // Check if the day has a task
                              bool hasTask = controller.allTasks.any(
                                  (task) => controller.isSameDay(task.date, day));

                              return Container(
                                margin: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  color: controller.isSameDay(
                                          day, controller.selectedDate.value)
                                      ? Colors
                                          .transparent // Transparent for selected date
                                      : Colors.grey[
                                          200], // Light color for unselected dates
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Rounded corners
                                  border: Border.all(
                                    color: controller.isSameDay(
                                            day, controller.selectedDate.value)
                                        ? Colors
                                            .black // Border color for the selected date
                                        : Colors
                                            .transparent, // Transparent border for non-selected dates
                                    width: 2.0, // Border width
                                  ),
                                  boxShadow: controller.isSameDay(
                                          day, controller.selectedDate.value)
                                      ? [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.5), // Shadow color
                                            offset: Offset(0, 3), // Shadow offset
                                            blurRadius: 4, // Shadow blur radius
                                          ),
                                        ]
                                      : [], // No shadow for unselected dates
                                ),
                                child: Stack(
                                  children: [
                                    // Centered red marker
                                    if (hasTask)
                                      Positioned(
                                        bottom:
                                            4.0, // Adjust the position as needed
                                        left: 0.0,
                                        right: 0.0,
                                        child: Center(
                                          child: Container(
                                            width: 8.0,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              color: Colors.red, // Marker color
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Center(
                                      child: Text(
                                        '${day.day}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                        )),
                    SizedBox(height: 16.0),
                    // Task List
                    Obx(()=>
                    controller.taskList.isEmpty ? const Center(child: Text("No Task Assigned")) :
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.taskList.length,
                        itemBuilder: (context, index) {
                          final task = controller.taskList[index];
                          return Padding(
                            padding:
                            const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 2,
                              child: Container(
                                height: orientation == Orientation.portrait
                                    ? MediaQuery.of(context).size.height *
                                    0.11
                                    : constraints.maxHeight *
                                    0.3, // Adjust height based on orientation
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      color: colors[index % colors.length],
                                      width: orientation ==
                                          Orientation.portrait
                                          ? MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.03
                                          : constraints.maxWidth *
                                          0.015, // Adjust width based on orientation
                                      height: orientation ==
                                          Orientation.portrait
                                          ? MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.12
                                          : constraints.maxHeight *
                                          0.32, // Adjust height based on orientation
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Project",
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: orientation ==
                                                        Orientation.portrait
                                                        ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.02
                                                        : constraints.maxHeight *
                                                        0.06,)),
                                            ),
                                            Text(
                                              task.name,
                                              style: GoogleFonts.montserrat(
                                                  textStyle: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: orientation ==
                                                        Orientation.portrait
                                                        ? MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.02
                                                        : constraints.maxHeight *
                                                        0.07,)),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: orientation ==
                                                  Orientation.portrait
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.3
                                                  : constraints.maxWidth *
                                                  0.4, // Adjust width based on orientation
                                              height: orientation ==
                                                  Orientation.portrait
                                                  ? MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02
                                                  : constraints.maxHeight *
                                                  0.06, // Adjust height based on orientation
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.alarm,
                                                    size: orientation ==
                                                        Orientation
                                                            .portrait
                                                        ? MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.02
                                                        : constraints
                                                        .maxHeight *
                                                        0.05,
                                                  ),
                                                  Text(
                                                    "9:30 - 6:30",
                                                    style: GoogleFonts.lato(
                                                        textStyle: TextStyle(
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                            fontSize: 12,
                                                            color: Colors
                                                                .black87)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: orientation ==
                                            Orientation.portrait
                                            ? MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.2
                                            : constraints.maxWidth *
                                            0.25, // Adjust width based on orientation
                                        height: orientation ==
                                            Orientation.portrait
                                            ? MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.12
                                            : constraints.maxHeight *
                                            0.26, // Adjust height based on orientation
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.timelapse,
                                                color: Colors.green,
                                                size: orientation ==
                                                    Orientation.portrait
                                                    ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.03
                                                    : constraints.maxHeight *
                                                    0.09, // Adjust size based on orientation
                                              ),
                                              // InkWell(
                                              //   onTap: () {
                                              //     Get.to(() => TaskDetailPage(
                                              //         taskId: '$index'));
                                              //   },
                                              //   child: Container(
                                              //     width: orientation ==
                                              //             Orientation.portrait
                                              //         ? MediaQuery.of(context)
                                              //                 .size
                                              //                 .width *
                                              //             0.2
                                              //         : constraints.maxWidth *
                                              //             0.13, // Adjust width based on orientation
                                              //     height: orientation ==
                                              //             Orientation.portrait
                                              //         ? MediaQuery.of(context)
                                              //                 .size
                                              //                 .height *
                                              //             0.03
                                              //         : constraints
                                              //                 .maxHeight *
                                              //             0.07, // Adjust height based on orientation
                                              //     decoration: BoxDecoration(
                                              //         borderRadius:
                                              //             BorderRadius
                                              //                 .circular(20),
                                              //         border: Border.all(
                                              //             color: Colors
                                              //                 .blue.shade900,
                                              //             width: 1.3)),
                                              //     child: Center(
                                              //       child: Text("See Details",
                                              //           style: GoogleFonts.montserrat(
                                              //               textStyle: TextStyle(
                                              //                   fontWeight:
                                              //                       FontWeight
                                              //                           .w500,
                                              //                   fontSize:
                                              //                       11))),
                                              //     ),
                                              //   ),
                                              // ),
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigate to TaskDetailPage and pass the task ID (for example: 'taskId-$index')
                                                  Get.to(() => TaskDetailPage(taskId: '$index'));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: imageHeight * 0.2,
                                                  width: imageWidth * 0.4,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(16),
                                                    border: Border.all(color: appColor2, width: 1),
                                                  ),
                                                  child: Text(
                                                    "See Details",
                                                    style: TextStyle(
                                                      fontFamily: 'poppins',
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                    //),
                    ),

                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
