import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/task_history_controller.dart';
import '../../../components/styles.dart';
import '../../../controllers/task_list_controller.dart';
import '../../../controllers/tasks_controller/tasks_controller.dart';
class TaskHistoryDetailPage extends StatelessWidget {
   TaskHistoryDetailPage({super.key, required this.taskId});
  final int taskId;

  @override
  Widget build(BuildContext context) {
    final DateTaskController controller = Get.put(DateTaskController());
    final TasksController tasksController = Get.put(TasksController());
    final TaskHistoryController taskHistoryController = Get.put(TaskHistoryController());
    List<String> numb = ['1', '2','3','4','5','6','7','8','9','10','11','12',];
    // Fetch the task index based on taskId if needed
    int index = taskHistoryController.taskHisData.indexWhere((task) => task['id'] == taskId);
    // final TaskHis task = taskHistoryController.taskHisData.firstWhere(
    //       (task) => task.id == taskId,
    //   orElse: () => Task(id: taskId, taskTitle: 'Unknown', taskDescription: 'No description available', name: '', date1: DateTime.now(), date2: DateTime.now(), taskStatus: ''),
    // );
    //print(" taskStatus=${task.taskStatus}");
    // DateTime endDate = parseTaskEndDate(task.date2.toString());
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     _buildTitleAndDescription(taskHistoryController),
              //     // _buildTaskDates(task),
              //
              //   ],
              // ),
              // _buildSubTasksTitle(taskHistoryController),
              Text("Sub Tasks",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              SizedBox(height: 10),

              // Task Dates


              // Task Sub-tasks list with containers
              _buildSubTasks(taskHistoryController, numb),

              SizedBox(height: 20),

              // Complete Task Button
              // _buildCompleteButton(task),
            ],
          ),
        ),
      ),
    );
  }
   Widget _buildTitleAndDescription(TaskHistoryController controller) {
    // print("taskTittle:${controller.taskTittle}");
    // print("taskDescription:${controller.taskDescription}");
    // var task = controller.taskHisData[index];

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
           controller.taskTittle.value.isNotEmpty ? controller.taskTittle.value : 'Unknown Title',
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
           controller.taskDescription.value.isNotEmpty ? controller.taskDescription.value : 'No description available',
           style: TextStyle(
             fontSize: 16,
             color: Colors.black54,
           ),
         ),
       ],
     );
   }
   Widget _buildTitleAndDescription1(TaskHistoryController controller, int index) {
     if (controller.taskHisData.isEmpty || index < 0 || index >= controller.taskHisData.length) {
       return Text("No task available", style: TextStyle(color: Colors.red));
     }

     var task = controller.taskHisData[index];

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
           task['taskTittle'] ?? 'Unknown Title',
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
           controller.taskDescription.toString() ?? 'No description available',
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

   Widget _buildSubTasksTitle(TaskHistoryController controller) {
     var taskHisData = controller.taskHisData;
     print("taskHisData:${taskHisData}");
     return ListView.builder(
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       itemCount: taskHisData.length,
       itemBuilder: (context, index) {
         var task = taskHisData[index];
         // var numValue = index < numb.length ? numb[index] : '';
         print("task:${task['id']}");
         print("tasksubTittle:${task['tasksubTittle']}");
         print("task:${task['id']}");

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
             task['taskTittle'],
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
               controller.taskDescription.value.isNotEmpty ? controller.taskDescription.value : 'No description available',
               style: TextStyle(
                 fontSize: 16,
                 color: Colors.black54,
               ),
             ),
           ],
         );
       },
     );
   }

   Widget _buildSubTasks(TaskHistoryController controller, List<String> numb) {
     var taskHisData = controller.taskHisData;
     print("taskHisDataaa:${taskHisData}");
     return ListView.builder(
       shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
       itemCount: taskHisData.length,
       itemBuilder: (context, index) {
         var task = taskHisData[index];
         var numValue = index < numb.length ? numb[index] : '';
         print("task:${task['id']}");
         print("tasksubTittle:${task['tasksubTittle']}");
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
                 // _buildDoneButton(task['id'],task['taskStatus'],task['tasksubTittle']),
               ],
             ),
           ),
         );
       },
     );
   }

}
