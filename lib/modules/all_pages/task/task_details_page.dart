// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../components/styles.dart';
// import '../../../controllers/bottom_nav_controller.dart';
// import '../../../controllers/task_list_controller.dart';
//
// class TaskDetailPage extends StatefulWidget {
//   final int taskId;
//
//   TaskDetailPage({required this.taskId});
//
//   @override
//   State<TaskDetailPage> createState() => _TaskDetailPageState();
// }
//
// class _TaskDetailPageState extends State<TaskDetailPage> {
//   final BottomNavController bottomNavController = Get.find<BottomNavController>();
//   final DateTaskController controller = Get.put(DateTaskController());
//   //final tasks = Task(name: controller.taskList[], date: null, taskStatus: '', taskTitle: '', taskDescription: '');
//   bool isChecked = false;
//   Color getColor(Set<MaterialState> states) {
//     const Set<MaterialState> interactiveStates = <MaterialState>{
//       MaterialState.selected,
//       MaterialState.focused,
//       MaterialState.pressed,
//     };
//     if (states.any(interactiveStates.contains)) {
//       return appColor2;
//     }
//     return Colors.white;
//   }
//   List<String> numb= [
//     '1.',
//     '2.',
//   ];
//   // List<String> taskDes= [
//   //   ' It was popularised in the 1960s w ',
//   //   ' It was popularised in the 1960s w ',
//   //   ' It was popularised in the 1960s w ',
//   //   ' It was popularised in the 1960s w ',
//   //   ' It was popularised in the 1960s w ',
//   //   ' It was popularised in the 1960s w ',
//   //   ' It was popularised in the 1960s w ',
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     // Find the task by matching its id in the list
//     final Task task = controller.taskList.firstWhere(
//           (task) => task.id == widget.taskId,
//       orElse: () => Task(id: widget.taskId, taskTitle: 'Unknown', taskDescription: 'No description available', name: '', date1: DateTime.now(), date2: DateTime.now(), taskStatus: ''), // Default task
//     );
//
//     // Handle the case where the task is not found
//     if (task == null) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: appColor2,
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//           ),
//           title: Text(
//             'Task Details',
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'poppins',
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: Center(
//           child: Text(
//             'Task not found',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appColor2,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'Task Details',
//           style: TextStyle(
//             color: Colors.white,
//             fontFamily: 'poppins',
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
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
//           var categoryWidth = orientation == Orientation.portrait
//               ? screenWidth
//               : screenWidth * 0.28;
//           var taskData = controller.taskData;
//           var empData = taskData['empdata'] as List<dynamic>;
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(12.0, 18, 12, 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Title:",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'poppins',
//                             ),
//                           ),Text(
//                             "${task.taskTitle}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'poppins',
//                             ),
//                           ),
//                           Text(
//                             "Description:",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'poppins',
//                             ),
//                           ),
//                           Text(
//                             "${task.taskDescription}",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'poppins',
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "Start Date :${task.date1.toString().substring(0,10)}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'poppins',
//                             ),
//                           ),
//                           Text(
//                             "End Date :${task.date2.toString().substring(0,10)}",
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'poppins',
//                             ),
//                           ),
//                         ],
//                       ),
//
//                     ],
//                   ),
//
//                   SizedBox(height: 10),
//
//                   SizedBox(height: 10),
//                 //   SizedBox(height: 10,),
//                 //   Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   //crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Checkbox(
//                 //         checkColor: Colors.white,
//                 //         fillColor: MaterialStateProperty.resolveWith(getColor),
//                 //         value: this.isChecked,
//                 //         onChanged: (bool? value) {
//                 //           setState(() {
//                 //             this.isChecked = value!;
//                 //           });
//                 //         }),
//                 //     // SizedBox(
//                 //     //   width: 6,
//                 //     // ),
//                 //     Text(
//                 //       " It was popularised in the 1960s w ",
//                 //       style: TextStyle(
//                 //         color: appColor2,
//                 //         fontSize: 16,
//                 //         fontFamily: 'Poppins',
//                 //         fontWeight: FontWeight.w400,
//                 //         // height: 1.54,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//
//                   ListView.builder(
//                       shrinkWrap: true, // Add this line
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: empData.length,
//                       itemBuilder: (context,index){
//                         var task = empData[index];
//                         var numValue = index < numb.length ? numb[index] : '';
//
//                         return Padding(padding: EdgeInsets.all(8),
//                       child:  Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width:categoryWidth*0.6,
//                             child: Wrap(
//                               direction: Axis.horizontal,
//                               children: [
//                                 Text(
//                                   numValue,
//                                   style: TextStyle(
//                                     color: appColor2,
//                                     fontSize: 16,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w400,
//                                     // height: 1.54,
//                                   ),
//                                 ),
//                                 Text(
//                                   task['tasksubTittle'],
//                                   style: TextStyle(
//                                     color: appColor2,
//                                     fontSize: 16,
//                                     fontFamily: 'Poppins',
//                                     fontWeight: FontWeight.w400,
//                                     // height: 1.54,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: imageHeight * 0.2,
//                             width: imageWidth * 0.3,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               border: Border.all(color: appColor2, width: 1),
//                             ),
//                             child: GestureDetector(
//                               onTap: (){},
//                               child:  Text("Done",style: TextStyle(
//                                   fontFamily: 'poppins',
//                                   fontSize: 12,
//                                 ),),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//                   SizedBox(height: 10,),
//                 //   Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //   //crossAxisAlignment: CrossAxisAlignment.start,
//                 //   children: [
//                 //     Text(
//                 //       "1. It was popularised in the 1960s w ",
//                 //       style: TextStyle(
//                 //         color: appColor2,
//                 //         fontSize: 16,
//                 //         fontFamily: 'Poppins',
//                 //         fontWeight: FontWeight.w400,
//                 //         // height: 1.54,
//                 //       ),
//                 //     ),
//                 //     GestureDetector(
//                 //       onTap: (){},
//                 //       child: Container(
//                 //         alignment: Alignment.center,
//                 //         height: imageHeight * 0.2,
//                 //         width: imageWidth * 0.3,
//                 //         decoration: BoxDecoration(
//                 //           borderRadius: BorderRadius.circular(16),
//                 //           border: Border.all(color: appColor2, width: 1),
//                 //         ),
//                 //         child: Text("Done",style: TextStyle(
//                 //           fontFamily: 'poppins',
//                 //           fontSize: 12,
//                 //         ),),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 SizedBox(height: 10,),
//                 Center(
//                   child: Container(
//                     height: imageHeight*0.3,
//                     width: imageWidth*0.8,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: appColor2,
//                     ),
//                       child: TextButton(
//                           onPressed: (){},
//                           child: Text("Complete",
//                             style: TextStyle(
//                     fontFamily: 'montserrat',
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,fontSize: 16
//                   ),))),)
//                   // Checkbox and other widgets...
//                 ],
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }
//
//
// // Widget build(BuildContext context) {
//   //   final task = controller.taskList[int.parse(widget.taskId)];
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //         backgroundColor: appColor2,
//   //         centerTitle: true,
//   //         leading: IconButton(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //              // bottomNavController.changeTabIndex(0);
//   //             },
//   //             icon: Icon(
//   //               Icons.arrow_back,
//   //               color: Colors.white,
//   //             )),
//   //         title: Text(
//   //           'Task Details',
//   //           style: TextStyle(color: Colors.white,
//   //               fontFamily: 'poppins',fontWeight: FontWeight.w600
//   //           ),
//   //         )),
//   //     body: OrientationBuilder(builder: (context, orientation){
//   //     return LayoutBuilder(builder: (context,constraints){
//   //       var screenWidth = constraints.maxWidth;
//   //       var screenHeight = constraints.maxHeight;
//   //
//   //       var imageWidth = orientation == Orientation.portrait
//   //           ? screenWidth * 0.55
//   //           : screenWidth * 0.25;
//   //       var imageHeight = orientation == Orientation.portrait
//   //           ? screenHeight * 0.2
//   //           : screenHeight * 0.5;
//   //
//   //       var imageWidth2 = orientation == Orientation.portrait
//   //           ? screenWidth * 0.3
//   //           : screenWidth * 0.19;
//   //       var imageHeight2 = orientation == Orientation.portrait
//   //           ? screenHeight * 0.32
//   //           : screenHeight * 0.5;
//   //
//   //       var categoryWidth = orientation == Orientation.portrait
//   //           ? screenWidth * 0.5
//   //           : screenWidth * 0.28;
//   //       var categoryHeight = orientation == Orientation.portrait
//   //           ? screenHeight * 0.4
//   //           : screenHeight * 0.8;
//   //       return SingleChildScrollView(
//   //         child: Container(
//   //           child: Padding(
//   //             padding: const EdgeInsets.fromLTRB(12.0,18,12,0),
//   //             child: Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 Text("Tittle :",style: TextStyle(
//   //                   fontSize: 18,
//   //                   fontWeight: FontWeight.w600,
//   //                   fontFamily: 'poppins'
//   //                 ),),
//   //                 Text("${task.taskTitle}",
//   //                    // "${tasks.taskTitle}"
//   //                     style: TextStyle(
//   //                   fontSize: 16,
//   //                   fontWeight: FontWeight.w500,
//   //                   fontFamily: 'poppins'),),
//   //                 SizedBox(height: 10,),
//   //                 Text("Description :",style: TextStyle(
//   //                   fontSize: 18,
//   //                   fontWeight: FontWeight.w600,
//   //                   fontFamily: 'poppins'
//   //                 ),),
//   //                 Text("${task.taskDescription}",style: TextStyle(
//   //                   fontSize: 16,
//   //                   fontWeight: FontWeight.w500,
//   //                   fontFamily: 'poppins'
//   //                 ),),
//   //                 SizedBox(height: 10,),
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.start,
//   //                   //crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Checkbox(
//   //                         checkColor: Colors.white,
//   //                         fillColor: MaterialStateProperty.resolveWith(getColor),
//   //                         value: this.isChecked,
//   //                         onChanged: (bool? value) {
//   //                           setState(() {
//   //                             this.isChecked = value!;
//   //                           });
//   //                         }),
//   //                     // SizedBox(
//   //                     //   width: 6,
//   //                     // ),
//   //                     Text(
//   //                       " It was popularised in the 1960s w ",
//   //                       style: TextStyle(
//   //                         color: appColor2,
//   //                         fontSize: 16,
//   //                         fontFamily: 'Poppins',
//   //                         fontWeight: FontWeight.w400,
//   //                         // height: 1.54,
//   //                       ),
//   //                     ),
//   //                   ],
//   //                 ),
//   //                 Center(
//   //                   child: Text(
//   //                     'Details for Task: ${widget.taskId}',
//   //                     style: TextStyle(fontSize: 20),
//   //                   ),
//   //                 ),
//   //                 Center(
//   //                   child: Container(
//   //                     height: imageHeight*0.3,
//   //                     width: imageWidth*0.8,
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(20),
//   //                       color: appColor2
//   //                     ),
//   //                       child: TextButton(
//   //                           onPressed: (){},
//   //                           child: Text("Done",
//   //                             style: TextStyle(
//   //                     fontFamily: 'montserrat',
//   //                     color: Colors.white,
//   //                     fontWeight: FontWeight.w600,fontSize: 16
//   //                   ),))),)
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     });
//   //     }
//   //     ),
//   //   );
//   // }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/bottom_bar/bottom_bar.dart';
import 'package:intl/intl.dart';
import '../../../components/styles.dart';
import '../../../controllers/bottom_nav_controller.dart';
import '../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../controllers/task_list_controller.dart';
import '../../../controllers/tasks_controller/tasks_controller.dart';

class TaskDetailPage extends StatefulWidget {
  final int taskId;

  TaskDetailPage({required this.taskId});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final BottomNavController bottomNavController = Get.find<BottomNavController>();
  final DateTaskController controller = Get.put(DateTaskController());
  final TasksController tasksController = Get.put(TasksController());
  final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());

  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return appColor2;
    }
    return Colors.white;
  }

  List<String> numb = ['1', '2','3','4','5','6','7','8','9','10','11','12',];
  final TextEditingController reasonController = TextEditingController(); // Controller for reason input

  bool isTaskOverdue(DateTime endDate) {
    final currentDate = DateTime.now();
    return currentDate.isAfter(endDate); // Check if the task's end date is in the past
  }
  // bool isTaskOverdue(DateTime endDate) {
  //   final currentDate = DateTime.now();
  //   final shiftTime = _getprofileepersonal.getprofileemployeeModel?.data?.shiftTime;
  //
  //   if (shiftTime != null) {
  //     // Extract office start and end times from the shiftTime string
  //     final times = shiftTime.split(' - ');
  //     final startTimeString = times[0].trim(); // "9:30 AM"
  //     final endTimeString = times[1].trim(); // "6:30 PM"
  //
  //     // Parse the start and end times
  //     final officeStartTime = _parseTime(startTimeString, currentDate);
  //     final officeEndTime = _parseTime(endTimeString, currentDate);
  //
  //     // Check if the task is overdue (past its end date and outside office hours)
  //     if (currentDate.isAfter(endDate) && currentDate.isAfter(officeEndTime)) {
  //       return true;
  //     }
  //   }
  //
  //   return false;
  // }

  DateTime _parseTime(String timeString, DateTime currentDate) {
    // Parse time format like "9:30 AM" or "6:30 PM" into a DateTime object
    final timeFormat = DateFormat.jm(); // 12-hour format with AM/PM
    final parsedTime = timeFormat.parse(timeString);
    return DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }

  DateTime parseTaskEndDate(String taskEndDate) {
    try {
      return DateFormat("dd/MM/yyyy").parse(taskEndDate); // Parse the date format "dd/MM/yyyy"
    } catch (e) {
      print("Error parsing date: $e");
      return DateTime.now(); // Return current date if parsing fails
    }
  }
  @override
  Widget build(BuildContext context) {
    final Task task = controller.taskList.firstWhere(
          (task) => task.id == widget.taskId,
      orElse: () => Task(id: widget.taskId, taskTitle: 'Unknown', taskDescription: 'No description available', name: '', date1: DateTime.now(), date2: DateTime.now(), taskStatus: ''),
    );
    print(" taskStatus=${task.taskStatus}");
    DateTime endDate = parseTaskEndDate(task.date2.toString());
    bool overdue = isTaskOverdue(endDate);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Task Details',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0,16,16,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title and Description
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleAndDescription(task),
                  _buildTaskDates(task),

                ],
              ),

              SizedBox(height: 10),

              // Task Dates


              // Task Sub-tasks list with containers
              _buildSubTasks(controller, numb),

              SizedBox(height: 20),

              // Complete Task Button
              _buildCompleteButton(task),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription(Task task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Task Title",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: appColor2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          task.taskTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Description",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: appColor2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          task.taskDescription,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDates(Task task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateRow("Start Date", task.date1.toString().substring(0, 10)),
            SizedBox(height: 8),
            _buildDateRow("End Date", task.date2.toString().substring(0, 10)),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRow(String label, String date) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: appColor2),
        ),
        Text(
          date,
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildSubTasks(DateTaskController controller, List<String> numb) {
    var empData = controller.taskData['empdata'] as List<dynamic>;
  print("emppDataa:${empData}");
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: empData.length,
      itemBuilder: (context, index) {
        var task = empData[index];
        var numValue = index < numb.length ? numb[index] : '';
        print("task:${task['id']}");

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30,width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appColor2
                  ),
                  child:Text(
                    numValue,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "${task['tasksubTittle']}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                              decoration:task['taskStatus'] =="Pending"?TextDecoration.none:TextDecoration.lineThrough

                          ),
                        ),
                      // ),

                ),
                _buildDoneButton(task['id'],task['taskStatus'],task['tasksubTittle']),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoneButton(int id,String status,String taskTittle) {
    var empData = controller.taskData['empdata'] as List<dynamic>;
    // var task = empData[index];
    // bool isTaskCompleted = tasksController.completedTasks[task.id] ?? false;

    return GestureDetector(
      onTap: () async{ status=="Pending"?
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text(taskTittle),
            content: Text("Do you want to submit your task:"),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appColor2,textStyle: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  print("subTask submit: ${id}");
                  status=="Pending"? await tasksController.SubTaask(subTaskId: id):Get.offAll(()=>BottomBar());
                  Get.back();
                },
                child: Text("Submit",style: TextStyle(color: Colors.white),),
              ),
            ],
          );
        }):status=="Completed"?Container():Container();
        // Handle "Done" action
       //status=="Pending"? await tasksController.SubTaask(subTaskId: id):Get.offAll(()=>BottomBar());
        // tasksController.submitTask(task.id, {'taskId': task.id});
        print("subIddd:$id");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color:status=="Pending"? appColor2:Colors.orangeAccent,
          border:status=="Pending"? Border.all(color: Colors.grey,width: 2):Border.all(color: Colors.orangeAccent)
        ),
        child: Text(
          status=="Pending"?"Submit":"Done",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteButton(Task taskkk, ) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor:  taskkk.taskStatus=="Pending"?appColor2:taskkk.taskStatus=="Completed"?Colors.grey:Colors.red,
          ),
          onPressed: () async{
            print("completed task");
            taskkk.taskStatus=="Pending"? showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text(taskkk.taskTitle),
                content: Text("Do you want to submit your task:"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appColor2,textStyle: TextStyle(color: Colors.white)
                    ),
                    onPressed: () async{
                      print("completed task");
                      await tasksController.CompletedTaask(taskId: taskkk.id);
                      print("completed task : ${taskkk.id}");

                      Get.back();
                    },
                    child: Text("Submit",style: TextStyle(color: Colors.white),),
                  ),
                ],
              );
            }):taskkk.taskStatus=="Completed"?Fluttertoast.showToast(
              msg: "Task already submitted",
              backgroundColor: appColor2,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
            ):_showReasonDialog(taskkk);
            print("completed task : ${taskkk.id}");
            // Handle complete task action
          },
          child: Text(
            taskkk.taskStatus=="UnCompleted"?
            "Give Reason": taskkk.taskStatus=="Completed"?"Task Submitted":"Complete Task",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showReasonDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Task Overdue: ${task.taskTitle}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Please provide a reason for the task delay:"),
              SizedBox(height: 10),
              TextFormField(
                controller: reasonController,
                decoration: InputDecoration(
                  labelText: "Reason",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: appColor2,textStyle: TextStyle(color: Colors.white)
              ),
              onPressed: () async{
                print("Reason: ${reasonController.text}");
                await tasksController.InCompletedTaask(subtaskid: task.id.toString(), reason: reasonController.text);
                print("Reason task: ${ task.id.toString()}${task.taskStatus}");

                // Handle reason submission logic
                Get.back();
              },
              child: Text("Submit",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

}


