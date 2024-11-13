// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:nd_connect_techland/components/styles.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../../../controllers/bottom_nav_controller.dart';
// import '../../../controllers/events_controller.dart';
// import '../../../models/events_model.dart';
// import '../../bottom_bar/bottom_bar.dart';
//
// class EventCalendarScreen extends StatelessWidget {
//   final EventController controller = Get.put(EventController());
//   final BottomNavController bottomNavController = Get.find<BottomNavController>();
//   @override
//   Widget build(BuildContext context) {
//     List<Color> colorrs=[
//       Colors.blue,
//       Colors.green,
//       Colors.pink,
//       Colors.yellow,
//       Colors.orange,
//       Colors.red,
//       Colors.brown,
//       Colors.deepPurple,
//       Colors.cyan,
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: appColor2,
//         leading: IconButton(onPressed: (){
//          bottomNavController.changeTabIndex(0);
//           }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
//         //automaticallyImplyLeading: Icon(Icons.arrow_back),
//         title: Text('Events Calendar',style: TextStyle(color: Colors.white),),
//       ),
//       body: OrientationBuilder(builder: (context, orientation){
//     return LayoutBuilder(builder: (context, constraints){
//       var screenWidth = constraints.maxWidth;
//       var screenHeight = constraints.maxHeight;
//
//       var imageWidth = orientation == Orientation.portrait
//           ? screenWidth * 0.55
//           : screenWidth * 0.25;
//       var imageHeight = orientation == Orientation.portrait
//           ? screenHeight * 0.2
//           : screenHeight * 0.5;
//
//       var imageWidth2 = orientation == Orientation.portrait
//           ? screenWidth * 0.3
//           : screenWidth * 0.19;
//       var imageHeight2 = orientation == Orientation.portrait
//           ? screenHeight * 0.32
//           : screenHeight * 0.8;
//
//       var categoryWidth = orientation == Orientation.portrait
//           ? screenWidth * 0.5
//           : screenWidth * 0.28;
//       var categoryHeight = orientation == Orientation.portrait
//           ? screenHeight * 0.6
//           : screenHeight * 0.9;
//       var taskListWidth = orientation == Orientation.portrait
//           ? screenWidth * 0.5
//           : screenWidth * 0.28;
//       var taskListHeight = orientation == Orientation.portrait
//           ? screenHeight * 0.3
//           : screenHeight * 0.9;
//
//       return SingleChildScrollView(
//           child: Container(
//             height: screenHeight,
//             child: Column(
//               children: [
//                 Obx(() {
//                   return Container(
//                     height: categoryHeight*0.9,
//                     child: TableCalendar<Event>(
//                       firstDay: DateTime.utc(2023, 1, 1),
//                       lastDay: DateTime.utc(2025, 12, 31),
//                       focusedDay: controller.selectedDay.value,
//                       selectedDayPredicate: (day) {
//                         return isSameDay(controller.selectedDay.value, day);
//                       },
//                       eventLoader: controller.getEventsForDay,
//                       onDaySelected: (selectedDay, focusedDay) {
//                         controller.onDaySelected(selectedDay);
//                       },
//                       calendarStyle: CalendarStyle(
//                         todayDecoration: BoxDecoration(
//                           color: Colors.blue,
//                           shape: BoxShape.circle,
//                         ),
//                         selectedDecoration: BoxDecoration(
//                           color: Colors.orange,
//                           shape: BoxShape.circle,
//                         ),
//                         markerDecoration: BoxDecoration(
//                           color: Colors.blueAccent,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       headerStyle: HeaderStyle(
//                         formatButtonVisible: false,
//                       ),
//                       calendarBuilders: CalendarBuilders(
//                         markerBuilder: (context, date, events) {
//                           if (events.isNotEmpty) {
//                             return _buildMultipleEventMarkers(1);
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   );
//                 }),
//                 const SizedBox(height: 8.0),
//                 Obx(() {
//                   if (controller.selectedEvents.isEmpty) {
//                     return Center(child: Text('No events on this day.'));
//                   }
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: controller.selectedEvents.length,
//                       itemBuilder: (context, index) {
//                         final event = controller.selectedEvents[index];
//                         return Card(
//                           clipBehavior: Clip.antiAlias,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           elevation: 2,
//                           color: Colors.white,
//                           child: Row(
//                             children: [
//                               Container(
//                                 color: colorrs[index],
//                                 width: 10,
//                                 height: 72,
//                               ),
//                               SizedBox(
//                                 width: 10.0,
//                               ),
//                               Expanded(
//                                 child: ListTile(
//                                   title: Text(event.title),
//                                   subtitle: Text(event.description),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         );
//     });
//       }
//       ),
//     );
//   }
//
//   Widget _buildMultipleEventMarkers(int count) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         count,
//             (index) => Container(
//           margin: EdgeInsets.symmetric(horizontal: 1.5),
//           width: 7,
//           height: 7,
//           decoration: BoxDecoration(
//             color: Colors.red,
//             shape: BoxShape.circle,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:nd_connect_techland/controllers/bottom_nav_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/event_controller2.dart';
import '../../../controllers/events_controller.dart';
import '../../../models/event_model2.dart';
import '../../../models/events_model.dart';
import '../../../widget/custom_loader.dart';
import '../../bottom_bar/bottom_bar.dart';
import '../pages/willPop_scope_exit.dart';


// class EventCalendarScreen extends StatelessWidget {
//   String id ='12';
//   EventCalendarScreen ({super.key,required this.id});
//   @override
//   Widget build(BuildContext context) {
//     final EventsController controller = Get.put(EventsController());
//
//     return WillPopScope(
//       onWillPop: () => showExitPopup(context),
//       child: Scaffold(
//         // appBar: AppBar(
//         //   title: Text("Events Calendar"),
//         // ),
//         body: Obx(() {
//           final selectedDay = controller.selectedDay.value;
//           final focusedDay = controller.focusedDay.value;
//
//           // Detect screen orientation
//           final isLandscape =
//               MediaQuery.of(context).orientation == Orientation.landscape;
//
//           return Column(
//             children: [
//               // Calendar widget
//               _buildCalendar(controller, isLandscape),
//
//               // List of events for the selected day
//               Expanded(
//                 child: _buildEventList(controller, selectedDay),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//   ///todo: calender weight...
//
//   Widget _buildCalendar(EventsController controller, bool isLandscape) {
//     final BottomNavController bottomNavController = Get.put(BottomNavController());
//
//     return Column(
//       children: [
//         SizedBox(
//           height: 35,
//         ),
//         // Custom Header
//         Container(
//           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
//           color: appColor2,
//           child: Center(
//             child: Obx(() {
//               final focusedDay = controller.focusedDay.value;
//               final monthYearFormat =
//               DateFormat('MMM yyyy'); // Full month name and year
//               final formattedDate = monthYearFormat.format(focusedDay);
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: 50,
//                       height: 40,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: InkWell(
//                           onTap: () {
//                             bottomNavController.changeTabIndex(0);
//                          //   Get.back();
//                           },
//                           child: Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 55,
//                       height: 40,
//                       child: Center(
//                         child: Text(
//                           "Events",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 99,
//                       height: 40,
//                       child: Center(
//                         child: Row(
//                           children: [
//                             InkWell(
//                                 onTap: () {
//                                   // Navigate to previous month
//                                   final newFocusedDay = DateTime(
//                                     focusedDay.year,
//                                     focusedDay.month - 1,
//                                   );
//                                   controller.onPageChanged(newFocusedDay);
//                                 },
//                                 child: Icon(
//                                   Icons.arrow_back_ios_new,
//                                   color: Colors.grey.shade300,
//                                   size: 15,
//                                 )),
//                             Text(
//                               formattedDate,
//                               style: GoogleFonts.roboto(
//                                 color: Colors.yellow.shade700,
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             InkWell(
//                                 onTap: () {
//                                   // Navigate to previous month
//                                   final newFocusedDay = DateTime(
//                                     focusedDay.year,
//                                     focusedDay.month + 1,
//                                   );
//                                   controller.onPageChanged(newFocusedDay);
//                                 },
//                                 child: Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color: Colors.grey.shade300,
//                                   size: 15,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         // Calendar widget
//         TableCalendar(
//           headerVisible: false,
//           focusedDay: controller.focusedDay.value,
//           firstDay: DateTime.utc(2023, 1, 1),
//           lastDay: DateTime.utc(2040, 12, 31),
//           calendarFormat: isLandscape
//               ? CalendarFormat.twoWeeks
//               : controller.calendarFormat.value,
//           selectedDayPredicate: (day) {
//             return controller.selectedDay.value?.isSameDay(day) ?? false;
//           },
//           onDaySelected: (selectedDay, focusedDay) {
//             controller.onDaySelected(selectedDay, focusedDay);
//           },
//           onFormatChanged: (format) {
//             controller.onFormatChanged(format);
//           },
//           onPageChanged: (focusedDay) {
//             controller.onPageChanged(focusedDay);
//           },
//           calendarStyle: CalendarStyle(
//             todayDecoration: BoxDecoration(
//               color: Colors.blueAccent,
//               shape: BoxShape.circle,
//             ),
//             selectedDecoration: BoxDecoration(
//               color: Colors.orange, // Transparent as custom markers are used
//               shape: BoxShape.circle,
//             ),
//             defaultDecoration: BoxDecoration(
//               color: Colors.transparent,
//             ),
//             weekendDecoration: BoxDecoration(
//               color: Colors.red,
//             ),
//             outsideDecoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               shape: BoxShape.circle,
//             ),
//           ),
//           calendarBuilders: CalendarBuilders(
//             markerBuilder: (context, date, events) {
//               final eventModels = events.cast<EventModel>();
//
//               if (eventModels.isNotEmpty) {
//                 // Show only one marker if there are events
//                 return Positioned(
//                   bottom: 4, // Position at the bottom of the date cell
//                   child: _buildSingleEventMarker(), // Show the marker
//                 );
//               }
//               return SizedBox.shrink(); // No marker if no events
//             },
//             defaultBuilder: (context, day, focusedDay) {
//               final eventDate = DateTime(day.year, day.month, day.day);
//               final hasEvent = controller.hasEvents(eventDate);
//
//               return Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Material(
//                   elevation: 5,
//                   shape: CircleBorder(), // Shape of the marker (can be changed
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: hasEvent
//                           ? Colors.red
//                           : (controller.selectedDay.value?.isSameDay(day) ??
//                           false
//                           ? Colors.redAccent
//                           : Colors.transparent),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                       child: Text(
//                         '${day.day}',
//                         style: TextStyle(
//                           color: hasEvent ? Colors.white : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSingleEventMarker() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 1.5),
//       width: 10, // Adjust size as necessary
//       height: 10,
//       decoration: BoxDecoration(
//         color: Colors.redAccent, // Marker color
//         shape: BoxShape.circle,
//       ),
//     );
//   }
//
//   // Build event list
//   Widget _buildEventList(EventsController controller, DateTime? selectedDay) {
//     if (selectedDay == null) {
//       return Center(child: Text("No date selected"));
//     }
//
//     List<EventModel> selectedEvents = controller.getEventsForDay(selectedDay);
//
//     // Debugging
//     print('Events for $selectedDay: $selectedEvents');
//
//     if (selectedEvents.isEmpty) {
//       return Center(child: Text("No events available for this date"));
//     }
//
//     return ListView.builder(
//       itemCount: selectedEvents.length,
//       itemBuilder: (context, index) {
//         final event = selectedEvents[index];
//         return Card(
//           clipBehavior: Clip.antiAlias,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           elevation: 2,
//           color: Colors.white,
//           child: Row(
//             children: [
//               Container(
//                 color: colorrs[index % colorrs.length],
//                 width: 10,
//                 height: 72,
//               ),
//               SizedBox(
//                 width: 10.0,
//               ),
//               Expanded(
//                 child: ListTile(
//                   title: Text(event.title),
//                   subtitle: Text(event.subtitle),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// // Extension to compare date only
// extension DateTimeComparison on DateTime {
//   bool isSameDay(DateTime other) {
//     return this.year == other.year &&
//         this.month == other.month &&
//         this.day == other.day;
//   }
// }
//
// List<Color> colorrs = [
//   Colors.blue,
//   Colors.green,
//   Colors.pink,
//   Colors.yellow,
//   Colors.orange,
//   Colors.red,
//   Colors.brown,
//   Colors.deepPurple,
//   Colors.cyan,
// ];
class EventCalendarScreen extends StatelessWidget {
  final String id; // Keep 'id' as a final field, remove the default value
  EventCalendarScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final EventsController controller = Get.put(EventsController());
    final EventController2 controller2 = Get.put(EventController2());
    final BottomNavController bottomNavController = Get.put(BottomNavController());

    // Fetch events when the screen is built
    controller.EventsApi();
    controller2.EventsHolidayApi();

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          body: Obx(() {
            // Reactive UI updates
            final selectedDay = controller.selectedDay.value;
            final selectedDay2 = controller2.selectedEventDay.value;
            final focusedDay = controller.focusedDay.value;

            // Detect screen orientation
            final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

            return Column(
              children: [
                // Custom Header
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
                  color: appColor2,
                  child: Center(
                    child: Obx(() {
                      final focusedDay = controller.focusedDay.value;
                      final focusedDay2 = controller2.focusedEventDay.value;
                      final monthYearFormat = DateFormat('MMM yyyy'); // Full month name and year
                      final formattedDate = monthYearFormat.format(focusedDay);
                      final formattedDate2 = monthYearFormat.format(focusedDay2);
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 20,10,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () {
                                  bottomNavController.changeTabIndex(0);
                                  Get.offAll(()=>BottomBar());
                                },
                                child: Icon(Icons.arrow_back, color: Colors.white),
                              ),
                            ),
                            Container(
                             // width: 200,
                              height: 40,
                              // color: Colors.pink,
                              child: Center(
                                child: Text(
                                  "Events Calendar",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container()
                            // SizedBox(
                            //   width: 99,
                            //   height: 40,
                            //   child: Center(
                            //     child: Row(
                            //       children: [
                            //         InkWell(
                            //           onTap: () {
                            //             // Navigate to previous month
                            //             final newFocusedDay = DateTime(
                            //               focusedDay.year,
                            //               focusedDay.month - 1,
                            //             );
                            //             // final newFocusedDay2 = DateTime(
                            //             //   focusedEventDay.year,
                            //             //   focusedEventDay.month - 1,
                            //             // );
                            //             controller.onPageChanged(newFocusedDay);
                            //            // controller2.onPageChanged(newFocusedDay);
                            //           },
                            //           child: Icon(Icons.arrow_back_ios_new, color: Colors.grey.shade300, size: 15),
                            //         ),
                            //         Text(
                            //           formattedDate,
                            //           style: GoogleFonts.roboto(
                            //             color: Colors.yellow.shade700,
                            //             fontSize: 15.0,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //         InkWell(
                            //           onTap: () {
                            //             // Navigate to next month
                            //             final newFocusedDay = DateTime(
                            //               focusedDay.year,
                            //               focusedDay.month + 1,
                            //             );
                            //             controller.onPageChanged(newFocusedDay);
                            //           },
                            //           child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade300, size: 15),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                    height: 50,
                   child: TabBar(tabs: [
                      Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Holidays',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                      Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Events',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    ])),
                // Calendar widget
                Expanded(child: TabBarView(
                  children: [
                    Container(
                    //  color: Colors.yellow,
                      child: Column(
                        children: [
                          _buildCalendar(controller, isLandscape),
                          Expanded(child: _buildEventList(controller, selectedDay)),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          _buildEventCalendar(controller2, isLandscape),
                          Expanded(child: _buildEventHolidayList(controller2, selectedDay2)),
                        ],
                      ),
                    ),
                  ],
                )),
              //  _buildCalendar(controller, isLandscape),

                // List of events for the selected day
                // Expanded(
                //   child: _buildEventList(controller, selectedDay),
                // ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCalendar(EventsController controller, bool isLandscape) {
    final focusedDay = controller.focusedDay.value;
    final monthYearFormat = DateFormat('MMM yyyy'); // Full month name and year
    final formattedDate = monthYearFormat.format(focusedDay);
    return Column(
      children: [
       // SizedBox(height: 35),
        Container(
        //  width: 99,
          height: 40,
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigate to previous month
                    final newFocusedDay = DateTime(
                      focusedDay.year,
                      focusedDay.month - 1,
                    );
                    // final newFocusedDay2 = DateTime(
                    //   focusedEventDay.year,
                    //   focusedEventDay.month - 1,
                    // );
                    controller.onPageChanged(newFocusedDay);
                    // controller2.onPageChanged(newFocusedDay);
                  },
                  child: CircleAvatar(
                    radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 15)),
                ),
                Text(
                  formattedDate,
                  style: GoogleFonts.roboto(
                    color: Colors.orange,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigate to next month
                    final newFocusedDay = DateTime(
                      focusedDay.year,
                      focusedDay.month + 1,
                    );
                    controller.onPageChanged(newFocusedDay);
                  },
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black87, size: 15)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        // Calendar widget
        TableCalendar(
          headerVisible: false,
          focusedDay: controller.focusedDay.value,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2040, 12, 31),
          calendarFormat: isLandscape ? CalendarFormat.twoWeeks : controller.calendarFormat.value,
          selectedDayPredicate: (day) {
            return controller.selectedDay.value?.isSameDay(day) ?? false;
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
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange, // Transparent as custom markers are used
              shape: BoxShape.circle,
            ),
            defaultDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
            weekendDecoration: BoxDecoration(
              color: Colors.red,
            ),
            outsideDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              final eventModels = events.cast<EventModel>();

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
              final hasEvent = controller.hasEvents(eventDate);

              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Material(
                  elevation: 5,
                  shape: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: hasEvent
                          ? Colors.red
                          : (controller.selectedDay.value?.isSameDay(day) ?? false
                          ? Colors.redAccent
                          : Colors.transparent),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: hasEvent ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCalendar(EventController2 controller2, bool isLandscape) {
    final focusedDay = controller2.focusedEventDay.value;
    final monthYearFormat = DateFormat('MMM yyyy'); // Full month name and year
    final formattedDate = monthYearFormat.format(focusedDay);
    return Column(
      children: [
       // SizedBox(height: 35),
        Container(
          //  width: 99,
          height: 40,
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigate to previous month
                    final newFocusedDay = DateTime(
                      focusedDay.year,
                      focusedDay.month - 1,
                    );
                    // final newFocusedDay2 = DateTime(
                    //   focusedEventDay.year,
                    //   focusedEventDay.month - 1,
                    // );
                    controller2.onPageChanged(newFocusedDay);
                    // controller2.onPageChanged(newFocusedDay);
                  },
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 15)),
                ),
                Text(
                  formattedDate,
                  style: GoogleFonts.roboto(
                    color: Colors.orange,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigate to next month
                    final newFocusedDay = DateTime(
                      focusedDay.year,
                      focusedDay.month + 1,
                    );
                    controller2.onPageChanged(newFocusedDay);
                  },
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black87, size: 15)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        // Calendar widget
        TableCalendar(
          headerVisible: false,
          focusedDay: controller2.focusedEventDay.value,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2040, 12, 31),
          calendarFormat: isLandscape ? CalendarFormat.twoWeeks : controller2.calendarFormat.value,
          selectedDayPredicate: (day) {
            return controller2.selectedEventDay.value?.isSameDay(day) ?? false;
          },
          onDaySelected: (selectedDay, focusedDay) {
            controller2.onDaySelected(selectedDay, focusedDay);
          },
          onFormatChanged: (format) {
            controller2.onFormatChanged(format);
          },
          onPageChanged: (focusedDay) {
            controller2.onPageChanged(focusedDay);
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange, // Transparent as custom markers are used
              shape: BoxShape.circle,
            ),
            defaultDecoration: BoxDecoration(
              color: Colors.transparent,
            ),
            weekendDecoration: BoxDecoration(
              color: Colors.red,
            ),
            outsideDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              final eventModels = events.cast<MeetEventsDto>();
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
              final hasEvent = controller2.hasEvents(eventDate);

              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Material(
                  elevation: 5,
                  shape: CircleBorder(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: hasEvent
                          ? Colors.red
                          : (controller2.selectedEventDay.value?.isSameDay(day) ?? false
                          ? Colors.redAccent
                          : Colors.transparent),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: hasEvent ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSingleEventMarker() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1.5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        shape: BoxShape.circle,
      ),
    );
  }

  // Build event list
  Widget _buildEventList(EventsController controller, DateTime? selectedDay) {
    if (selectedDay == null) {
      selectedDay==DateTime.now();
    }
    final nonNullableSelectedDay = selectedDay ?? DateTime.now();

    List<EventModel> selectedEvents = controller.getEventsForDay(nonNullableSelectedDay);

    // List<EventModel> selectedEvents = controller.getEventsForDay(selectedDay);

    // Debugging
    print('Events for $selectedDay: $selectedEvents');

    if (selectedEvents.isEmpty) {
      return Center(child: Text("No events available for this date"));
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                color: colorrs[index % colorrs.length],
                width: 10,
                height: 72,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: ListTile(
                  title: Text(event.tittle.toString()),
                  subtitle: Text(event.subtittle.toString()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildEventHolidayList(EventController2 controller2, DateTime? selectedDay) {
    final nonNullableSelectedDay = selectedDay ?? DateTime.now();
    List<MeetEventsDto> selectedEvents = controller2.getEventsHolidayForDay(nonNullableSelectedDay);
    print('Events holiday for $selectedDay: $selectedEvents');

    if (selectedEvents.isEmpty) {
      return Center(child: Text("No events available for this date"));
    }

    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        final event = selectedEvents[index];
        print(" selectedEvents length: ${ selectedEvents.length}");
        return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child: Row(
            children: [
              Container(
                color: colorrs[index % colorrs.length],
                width: 10,
                height: 90,
              ),
             // SizedBox(width: 10.0),
              Expanded(
                child: ListTile(
                  onTap: ()async{
                    Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);
                    final Uri? meetUrl = event.eventDescription != null
                        ? Uri.tryParse('${event.eventDescription}')
                        : null;

                    print("meetUrl: $meetUrl");

                    // Close the dialog after API response
                    Get.back();

                    // Launch the URL if it's valid
                    if (meetUrl != null && await canLaunchUrl(meetUrl)) {
                      await launchUrl(meetUrl);
                    } else {
                      print('Could not launch $meetUrl');
                    }                  },
                  title: Text(event.eventTittle.toString()),
                  subtitle:  Row(
                    children: [
                      Expanded(
                        child: SelectableText(event.eventDescription.toString()),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy, size: 18, color: Colors.grey),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: event.eventDescription.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Event description copied!")),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () async {
                    Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);
                    final Uri? meetUrl = event.eventDescription != null
                        ? Uri.tryParse('${event.eventDescription}')
                        : null;

                    print("meetUrl: $meetUrl");

                    // Close the dialog after API response
                    Get.back();

                    // Launch the URL if it's valid
                    if (meetUrl != null && await canLaunchUrl(meetUrl)) {
                      await launchUrl(meetUrl);
                    } else {
                      print('Could not launch $meetUrl');
                      }
                    },
                  child: Column(
                    children: [
                      Text(event.eventTime.toString()),
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.indigo.shade50,
                          border: Border.all(color: appColor2, width: 1),
                        ),
                        child: Text(
                          "Join",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

}

// Extension to compare date only
extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

List<Color> colorrs = [
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
