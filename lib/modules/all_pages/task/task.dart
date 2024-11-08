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
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/models/task_model.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task_details_page.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task_history.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../controllers/bottom_nav_controller.dart';
import '../../../controllers/task_history_controller.dart';
import '../../../controllers/task_list_controller.dart';
import '../../bottom_bar/bottom_bar.dart';
import '../pages/willPop_scope_exit.dart';

class TaskList extends StatelessWidget {
  String id ='11';
  TaskList ({super.key, Key,required this.id});
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
    final DateTaskController controller = Get.put(DateTaskController());
    final TaskHistoryController taskHistoryController = Get.put(TaskHistoryController());
    controller.TaskAssignApi();

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
                // bottomNavController.changeTabIndex(0);
                 Get.offAll(()=>BottomBar());
               // Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          actions: [
            IconButton(onPressed: ()async{
              print("taskHistory");
            await taskHistoryController.TaskHistoryApi();
              await Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskHistory()));
              print("taskHistory done");

              },
                icon: Icon(Icons.history_toggle_off,color: Colors.white,))
          ],
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Obx(() {
              final selectedDay = controller.selectedDay.value;
              final focusedDay = controller.focusedDay.value;
              final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

              return Container(
                child: Column(
                      children: [
                        SizedBox(height: 20,),
                        _buildCalendar(controller),
                        SizedBox(height: 20,),

                          _buildTasksList(controller,selectedDay,orientation)

                      ],
                    ),
              );}
            );

          },
        ),
      ),
    );
  }

  Widget _buildCalendar(DateTaskController controller,) {
    final BottomNavController bottomNavController = Get.put(BottomNavController());

    return TableCalendar(
      headerVisible: false,
      focusedDay: controller.focusedDay.value,
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2040, 12, 31),
      calendarFormat: controller.calendarFormat.value,
      selectedDayPredicate: (day) {
        return controller.selectedDay.value?.isSameDayy(day) ?? false;
      },
      onDaySelected: (selectedDay, focusedDay) {
        controller.onDaySelected(selectedDay, focusedDay);
      },
      onFormatChanged: (format) {
        controller.onFormatChanged(format);
      },
      onPageChanged: (focusedDay) {
        controller.onPageChanged(focusedDay);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),

         // shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8),
          // Transparent as custom markers are used
         // shape: BoxShape.circle,
        ),
        defaultDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        weekendDecoration: BoxDecoration(
          color: Colors.red,
        ),
        outsideDecoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),

         // shape: BoxShape.circle,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          final eventModels = events.cast<TasksModells>();

          if (eventModels.isNotEmpty) {
            // Show only one marker if there are events
            return Positioned(
              bottom: 4, // Position at the bottom of the date cell
              child: _buildSingleEventMarker(), // Show the marker
            );
          }
          return SizedBox.shrink(); // No marker if no events
        },
        defaultBuilder: (context, day, focusedDay) {
          final eventDate = DateTime(day.year, day.month, day.day);
          final hasEvent = controller.hasTasks(eventDate);

          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Material(
              elevation: 5,
             borderRadius: BorderRadius.circular(8),

             // shape: CircleBorder(),
              child: Container(
                decoration: BoxDecoration(
                    color: hasEvent
                                  ? Colors.transparent
                                  : Colors.grey[200],
                  // color: hasEvent
                  //     ? Colors.red
                  //     : (controller.selectedDay.value?.isSameDayy(day) ?? false
                  //     ? Colors.redAccent
                  //     : Colors.transparent),
                  borderRadius: BorderRadius.circular(8),

                  // shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    if (hasEvent)
                    Positioned(
                      bottom: 4.0,
                      left: 0.0,
                      right: 0.0,
                      child: Center(
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: Colors.redAccent, // Red dot for task dates
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color:
                          //hasEvent ? Colors.white :
                          Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTasksList(DateTaskController controller, DateTime? selectedDay,Orientation orientation,) {
    if (selectedDay == null) {
      return Center(child: Text("No date selected"));
    }

    List<TasksModells> selectedTasks = controller.getTasksForDay(selectedDay);

    // Debugging
    print('Events for $selectedDay: $selectedTasks');

    if (selectedTasks.isEmpty) {
      return Center(child: Text("No tasks assign for this date"));
    }
print("task Reassigned:${controller.subTaskCompletedModel?.data?.status}");
    return Expanded(
      child: ListView.builder(
        itemCount: selectedTasks.length,
        itemBuilder: (context, index) {
          final task = selectedTasks[index];
          print("taskkk Reassigned:${task.taskStatus}");

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
                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.11 : MediaQuery.of(context).size.height * 0.24, // Adjust height based on orientation
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: colors[index % colors.length],
                      width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.015, // Adjust width based on orientation
                      height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.12 : MediaQuery.of(context).size.width * 0.32, // Adjust height based on orientation
                    ),
                    Expanded(
                      child: Container(
                        //color: Colors.pink,
                        width: MediaQuery.of(context).size.height*0.7,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(12,5,0,5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Project", style:
                              //GoogleFonts.montserrat(textStyle:
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : MediaQuery.of(context).size.height *0.045,)
                                // ),
                              ),
                              Text(
                                task.taskName.toString(),
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : MediaQuery.of(context).size.height * 0.05,)),
                              ),
                              Spacer(),
                              Container(
                                width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width *0.7 : MediaQuery.of(context).size.width *0.4, // Adjust width based on orientation
                                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : MediaQuery.of(context).size.height * 0.06, // Adjust height based on orientation
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : MediaQuery.of(context).size.height * 0.05,
                                    ),
                                    Text(
                                      "End Date : ",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black87)),
                                    ),Text(
                                      "${task.taskEnddate.toString().substring(0,10)}",
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black87)),
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
                      // color: Colors.yellow,
                      width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width * 0.25, // Adjust width based on orientation
                      height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.12 : MediaQuery.of(context).size.height * 0.26, // Adjust height based on orientation
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  // Check task status and display the corresponding icon
                                  task.taskStatus == 'Pending'
                                      ? Icons.pending_rounded // Icon for Pending status
                                      : task.taskStatus == 'Completed'
                                      ? Icons.check_circle // Icon for Completed status
                                      : task.taskStatus == 'Reassigned'
                                      ? Icons.change_circle_rounded // Icon for Reassigned status
                                      : Icons.cancel, // Icon for Uncompleted or other status (default if not Pending, Completed, or Reassigned)
                                  color: task.taskStatus == 'Pending'
                                      ? Colors.orangeAccent // Color for Pending status
                                      : task.taskStatus == 'Completed'
                                      ? Colors.green // Color for Completed status
                                      : task.taskStatus == 'Reassigned'
                                      ? Colors.blue // Color for Reassigned status
                                      : Colors.redAccent, // Color for Uncompleted or other status
                                  size: orientation == Orientation.portrait
                                      ? MediaQuery.of(context).size.height * 0.03
                                      : MediaQuery.of(context).size.height * 0.07, // Adjust size based on orientation
                                ),


                                // Container(
                                //   decoration:BoxDecoration(
                                //     borderRadius: BorderRadius.circular(3),
                                //     color: Colors.red.shade400
                                //   ),
                                //   padding: EdgeInsets.only(left: 4,right: 4),
                                //   child: Text(
                                //     task.taskStatus,
                                //     style: TextStyle(
                                //           color: Colors.white,
                                //           // fontWeight: FontWeight.w600,
                                //           fontSize: orientation ==
                                //               Orientation.portrait ? MediaQuery.of(context).size.height * 0.015 : constraints.maxHeight * 0.07,)),
                                // ),
                              ],
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
                              onTap: ()async {
                                await controller.fetchTaskData(task.id??0);
                                // Navigate to TaskDetailPage and pass the task ID (for example: 'taskId-$index')
                                Get.to(() => TaskDetailPage(taskId: task.id??0));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.036 : MediaQuery.of(context).size.height * 0.063, // Adjust height based on orientation

                                width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width * 0.14, // Adjust width based on orientation

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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildSingleEventMarker() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.rectangle,
      ),
    );
  }
}
extension DateTimeComparison on DateTime {
  bool isSameDayy(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}