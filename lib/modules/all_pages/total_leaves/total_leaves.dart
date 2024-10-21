import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/controllers/total_leaves_date_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/total_leaves/leaves_detail_page.dart';
import '../../../components/styles.dart';
import '../../../controllers/bottom_nav_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class TotalLeaves extends StatelessWidget {
  final RxBool isLoading = false.obs;
  
   TotalLeaves({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController());
    final TotalLeavesDateController totalLeavesDateController =
        Get.put(TotalLeavesDateController());
    print("leaves found :${totalLeavesDateController.foundLeaves.length}");

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
    final List<Color> bgcolors = [
      Colors.blue.shade50,
      Colors.green.shade100,
      Colors.pink.shade50,
      Colors.yellow.shade50,
      Colors.orange.shade100,
      Colors.red.shade50,
      Colors.brown.shade50,
      Colors.deepPurple.shade50,
      Colors.cyan.shade50,
    ];
    final List<Color> iconColors = [
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
              return Obx(() => (totalLeavesDateController.isLoading.value ||
                  isLoading.value)
                  ? const Center(child: CircularProgressIndicator())
                  : SafeArea(
                    child: Column(
                                    children: [
                    // Calendar Widget
                    // Padding(
                    //       padding: const EdgeInsets.only(
                    //           left: 12.0, right: 12.0, top: 14),
                    //       child: Row(
                    //         children: [
                    //           Expanded(
                    //             child: GestureDetector(
                    //               onTap:() async {
                    //                 await showDialog(
                    //                   context: context,
                    //                   builder: (context) {
                    //                     return Dialog(
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius: BorderRadius.circular(12),
                    //                       ),
                    //                       child: Container(
                    //                         padding: EdgeInsets.all(16.0),
                    //                         child: Column(
                    //                           mainAxisSize: MainAxisSize.min,
                    //                           children: [
                    //                             Obx(() => TableCalendar(
                    //                               focusedDay:
                    //                               totalLeavesDateController.selectedDate.value,
                    //                               firstDay: DateTime(2020),
                    //                               lastDay: DateTime(2040),
                    //                               calendarFormat:
                    //                               CalendarFormat.month,
                    //                               startingDayOfWeek:
                    //                               StartingDayOfWeek.monday,
                    //                               headerStyle: HeaderStyle(
                    //                                 formatButtonVisible: false,
                    //                                 titleCentered: true,
                    //                                 titleTextStyle: TextStyle(
                    //                                   fontSize: 16,
                    //                                   fontWeight:
                    //                                   FontWeight.w600,
                    //                                 ),
                    //                               ),
                    //                               onDaySelected: (selectedDay,
                    //                                   focusedDay) {
                    //                                 totalLeavesDateController.selectDate(selectedDay);
                    //                                 Navigator.pop(context); // Close the dialog after selecting the date
                    //                               },
                    //                               selectedDayPredicate: (day) {
                    //                                 return totalLeavesDateController.isSameDay(totalLeavesDateController.selectedDate.value!, day);
                    //                               },
                    //                               calendarStyle: CalendarStyle(
                    //                                 isTodayHighlighted: true,
                    //                                 todayDecoration: BoxDecoration(
                    //                                   color: Colors.orange,
                    //                                   shape: BoxShape.circle,
                    //                                   // Set a fixed size using width and height in the builder
                    //                                 ),
                    //                                 selectedDecoration: BoxDecoration(
                    //                                   color: Colors.blue[900],
                    //                                   shape: BoxShape.circle,
                    //                                   // Set a fixed size using width and height in the builder
                    //                                 ),
                    //                                 defaultDecoration: BoxDecoration(
                    //                                   shape: BoxShape.circle,
                    //                                 ),
                    //                                 outsideDaysVisible: false,
                    //                               ),
                    //                               calendarBuilders:
                    //                               CalendarBuilders(
                    //                                 defaultBuilder: (context, day, focusedDay) {
                    //                                   bool hasTask = totalLeavesDateController.allLeave.any((task) => totalLeavesDateController.isSameDay(task.date, day));
                    //                                   return Stack(
                    //                                     children: [
                    //                                       Center(child: Text('${day.day}', style: TextStyle(color: Colors.black,),
                    //                                         ),
                    //                                       ),
                    //                                       if (totalLeavesDateController.isSameDay(day, totalLeavesDateController.selectedDate.value!))
                    //                                         Center(
                    //                                           child: Container(
                    //                                             width: 40, // Set width for selected date circle
                    //                                             height: 40, // Set height for selected date circle
                    //                                             decoration: BoxDecoration(
                    //                                               color: Colors.blue[900],
                    //                                               shape: BoxShape.circle,),
                    //                                             child: Center(
                    //                                               child: Text(
                    //                                                 '${day.day}',
                    //                                                 style:
                    //                                                 TextStyle(color: Colors.white,
                    //                                                 ),
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                         ),
                    //                                       if (totalLeavesDateController.isSameDay(day, DateTime.now()))
                    //                                         Center(
                    //                                           child: Container(
                    //                                             width: 40, // Set width for today's date circle
                    //                                             height: 40, // Set height for today's date circle
                    //                                             decoration: BoxDecoration(
                    //                                               color: Colors.orange,
                    //                                               shape: BoxShape.circle,
                    //                                             ),
                    //                                             child: Center(
                    //                                               child: Text('${day.day}',
                    //                                                 style: TextStyle(color: Colors.white,),
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                         ),
                    //                                       if (hasTask)
                    //                                         Positioned(
                    //                                           bottom: 4.0,
                    //                                           left: 0,
                    //                                           right: 0,
                    //                                           child: Center(
                    //                                             child:
                    //                                             Container(
                    //                                               width: 4.0, // Bigger dot for leaves
                    //                                               height: 4.0,
                    //                                               decoration: BoxDecoration(
                    //                                                 color: Colors.red, // Red dot for days with leaves
                    //                                                 shape: BoxShape.circle,
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                         ),
                    //                                     ],
                    //                                   );
                    //                                 },
                    //                               ),
                    //                             )),
                    //                             SizedBox(height: 16.0),
                    //                             TextButton(
                    //                               onPressed: () {
                    //                                 Navigator.pop(context); // Close the dialog without selecting any date
                    //                               },
                    //                               child: Text(
                    //                                 "CLOSE",
                    //                                 style: TextStyle(
                    //                                   color: Colors.red,
                    //                                   fontWeight: FontWeight.bold,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                 );
                    //               },
                    //               child: Container(
                    //                 alignment: Alignment.centerLeft,
                    //                 padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    //                 width: 288,
                    //                 height: 40,
                    //                 decoration: BoxDecoration(
                    //                     color: Colors.grey[200],
                    //                     borderRadius: BorderRadius.circular(18),
                    //                     border: Border.all(color: Colors.grey.shade300)),
                    //                 child: Text(
                    //                   DateFormat('d MMM y').format(totalLeavesDateController.selectedDate.value!),
                    //                   style: TextStyle(
                    //                       fontWeight: FontWeight.w500,
                    //                       fontSize: 15,
                    //                       color: Colors.black),
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           IconButton(
                    //             onPressed: () async {
                    //               await showDialog(
                    //                 context: context,
                    //                 builder: (context) {
                    //                   return Dialog(
                    //                     shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.circular(12),
                    //                     ),
                    //                     child: Container(
                    //                       padding: EdgeInsets.all(16.0),
                    //                       child: Column(
                    //                         mainAxisSize: MainAxisSize.min,
                    //                         children: [
                    //                           Obx(() => TableCalendar(
                    //                                 focusedDay: totalLeavesDateController.selectedDate.value,
                    //                                 firstDay: DateTime(2020),
                    //                                 lastDay: DateTime(2040),
                    //                                 calendarFormat: CalendarFormat.month,
                    //                                 startingDayOfWeek: StartingDayOfWeek.monday,
                    //                                 headerStyle: HeaderStyle(
                    //                                   formatButtonVisible: false,
                    //                                   titleCentered: true,
                    //                                   titleTextStyle: TextStyle(
                    //                                     fontSize: 16, fontWeight: FontWeight.w600,
                    //                                   ),
                    //                                 ),
                    //                                 onDaySelected: (selectedDay, focusedDay) {
                    //                                   totalLeavesDateController.selectDate(selectedDay);
                    //                                   Navigator.pop(context); // Close the dialog after selecting the date
                    //                                 },
                    //                                 selectedDayPredicate: (day) {
                    //                                   return totalLeavesDateController.isSameDay(totalLeavesDateController.selectedDate.value!, day);
                    //                                 },
                    //                                 calendarStyle: CalendarStyle(
                    //                                   isTodayHighlighted: true,
                    //                                   todayDecoration: BoxDecoration(
                    //                                     color: Colors.orange,
                    //                                     shape: BoxShape.circle,
                    //                                     // Set a fixed size using width and height in the builder
                    //                                   ),
                    //                                   selectedDecoration: BoxDecoration(
                    //                                     color: Colors.blue[900],
                    //                                     shape: BoxShape.circle,
                    //                                     // Set a fixed size using width and height in the builder
                    //                                   ),
                    //                                   defaultDecoration:
                    //                                       BoxDecoration(shape: BoxShape.circle,),
                    //                                   outsideDaysVisible: false,
                    //                                 ),
                    //                                 calendarBuilders: CalendarBuilders(
                    //                                   defaultBuilder: (context, day, focusedDay) {
                    //                                     bool hasTask = totalLeavesDateController.allLeave.any((task) => totalLeavesDateController.isSameDay(task.date, day));
                    //                                     return Stack(
                    //                                       children: [
                    //                                         Center(child: Text('${day.day}',
                    //                                             style: TextStyle(
                    //                                               color: Colors.black,
                    //                                             ),
                    //                                           ),
                    //                                         ),
                    //                                         if (totalLeavesDateController.isSameDay(day, totalLeavesDateController.selectedDate.value!))
                    //                                           Center(
                    //                                             child: Container(
                    //                                               width: 40, // Set width for selected date circle
                    //                                               height: 40, // Set height for selected date circle
                    //                                               decoration: BoxDecoration(
                    //                                                 color: Colors.blue[900],
                    //                                                 shape: BoxShape.circle,
                    //                                               ),
                    //                                               child: Center(
                    //                                                 child: Text('${day.day}',
                    //                                                   style: TextStyle(
                    //                                                     color: Colors.white,
                    //                                                   ),
                    //                                                 ),
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                         if (totalLeavesDateController.isSameDay(day, DateTime
                    //                                                     .now()))
                    //                                           Center(
                    //                                             child: Container(
                    //                                               width:
                    //                                                   40, // Set width for today's date circle
                    //                                               height:
                    //                                                   40, // Set height for today's date circle
                    //                                               decoration:
                    //                                                   BoxDecoration(
                    //                                                 color: Colors
                    //                                                     .orange,
                    //                                                 shape: BoxShape
                    //                                                     .circle,
                    //                                               ),
                    //                                               child: Center(
                    //                                                 child: Text(
                    //                                                   '${day.day}',
                    //                                                   style:
                    //                                                       TextStyle(
                    //                                                     color: Colors
                    //                                                         .white,
                    //                                                   ),
                    //                                                 ),
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                         if (hasTask)
                    //                                           Positioned(
                    //                                             bottom: 4.0,
                    //                                             left: 0,
                    //                                             right: 0,
                    //                                             child: Center(
                    //                                               child:
                    //                                                   Container(
                    //                                                 width:
                    //                                                     4.0, // Bigger dot for leaves
                    //                                                 height: 4.0,
                    //                                                 decoration:
                    //                                                     BoxDecoration(
                    //                                                   color: Colors
                    //                                                       .red, // Red dot for days with leaves
                    //                                                   shape: BoxShape
                    //                                                       .circle,
                    //                                                 ),
                    //                                               ),
                    //                                             ),
                    //                                           ),
                    //                                       ],
                    //                                     );
                    //                                   },
                    //                                 ),
                    //                               )),
                    //                           SizedBox(height: 16.0),
                    //                           TextButton(
                    //                             onPressed: () {
                    //                               Navigator.pop(
                    //                                   context); // Close the dialog without selecting any date
                    //                             },
                    //                             child: Text(
                    //                               "CLOSE",
                    //                               style: TextStyle(
                    //                                 color: Colors.red,
                    //                                 fontWeight: FontWeight.bold,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   );
                    //                 },
                    //               );
                    //             },
                    //             icon: Icon(Icons.calendar_month),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0,14.0,14.0,0),
                      child: SizedBox(
                        // width: screenWidth * 0.97,
                        // height: screenHeight * 0.07,
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          cursorColor: appColor2,
                          onChanged: (value) => totalLeavesDateController.filterLeaves(value),
                          autofocus: false,
                          style: TextStyle(
                              fontSize: 15.0, color: appColor2),
                          decoration: InputDecoration(
                            prefixIcon:
                            Icon(Icons.search, color: appColor2),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Month-Year.',
                            contentPadding: const EdgeInsets.only(
                                left: 10.0, bottom: 12.0, top: 13.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: appColor2),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: appColor2),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.0),
                      totalLeavesDateController.foundLeaves.isEmpty ? const Center(child: Text("No Leaves Found"))
                          : Expanded(child: ListView.builder(
                        itemCount: totalLeavesDateController.totalLeavesModel?.data?.type?.length,
                        itemBuilder: (context, index) {
                          final task = totalLeavesDateController.totalLeavesModel?.data?.type?[index];
                          print("leave id: ${task?.id}");
                          // Ensure leaveType is not null
                          String leaveType = task?.leaveapplydate ??""; // Default value if null
                          return Padding(padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                            child: GestureDetector(
                              onTap: () async{
                                await totalLeavesDateController.fetchLeavesData(task.id??0);
                                totalLeavesDateController.selectTask(index);
                                Get.to(() => LeaveDetailPage(leaveId: '${task.id}',leaveType: task.leaveType??""));
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
                                    color: totalLeavesDateController.selectedLeaveIndex.value == index ? bgcolors[index] : Colors.transparent, // Set border color based on selection

                                    // border: Border.all(
                                    //   color: totalLeavesDateController.selectedLeaveIndex.value == index ? Colors.red : Colors.transparent, // Set border color based on selection
                                    //   width: totalLeavesDateController.selectedLeaveIndex.value == index ? 2.0 : 0.0,
                                    // ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                       // color: leaveType == "full day" ? Colors.red : Colors.orangeAccent,
                                        color: colors[index % colors.length],
                                        width: orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.025 : constraints.maxWidth * 0.015,
                                        height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.12 : constraints.maxHeight * 0.32,),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(task!.leaveapplydate.toString(),
                                                  style: GoogleFonts.montserrat(textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : constraints.maxHeight * 0.06,
                                                  )),
                                                ),
                                              //  Spacer(),
                                                Expanded(
                                                  child: Text(
                                                    task.reason.toString(),
                                                    style: GoogleFonts.montserrat(
                                                        textStyle:TextStyle(
                                                          fontWeight:FontWeight.w600,
                                                          fontSize: orientation ==Orientation.portrait? MediaQuery.of(context).size.height * 0.02
                                                              : constraints.maxHeight * 0.07,
                                                          overflow: TextOverflow.ellipsis
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(height: 10,)
                                                // Spacer(),
                                                // SizedBox(
                                                //   width: orientation == Orientation.portrait
                                                //       ? MediaQuery.of(context).size.width * 0.3
                                                //       : constraints.maxWidth * 0.4, // Adjust width based on orientation
                                                //   height: orientation == Orientation.portrait
                                                //       ? MediaQuery.of(context).size.height * 0.02
                                                //       : constraints.maxHeight * 0.06, // Adjust height based on orientation
                                                //   child: Row(
                                                //     children: [
                                                //       Icon(Icons.alarm,
                                                //         size: orientation == Orientation.portrait
                                                //             ? MediaQuery.of(context).size.height * 0.02
                                                //             : constraints.maxHeight * 0.05,
                                                //       ),
                                                //       Text(
                                                //         "9:30 - 6:30",
                                                //         style: GoogleFonts.lato(
                                                //             textStyle: TextStyle(
                                                //                 fontWeight: FontWeight.w500,
                                                //                 fontSize: 12,
                                                //                 color: Colors.black87)),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
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
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              // Text(task.leaveType),
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
                                                onTap: () async {
                                                  await totalLeavesDateController.fetchLeavesData(task.id??0);

                                                  Get.to(() => LeaveDetailPage(leaveId: '${task.id}',leaveType: task.leaveType??""));
                    
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
                      )
                      )
                                    ],
                                  ),
                  )
              );
            },
          );
        },
      ),
    );
  }
}
