import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task_details_page.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task_history_detail_page.dart';
import '../../../components/styles.dart';
import '../../../controllers/task_history_controller.dart';
import '../../../controllers/task_list_controller.dart';
class NotCompletedTasks extends StatelessWidget {
  const NotCompletedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskHistoryController controller = Get.put(TaskHistoryController());
    print("Not Completed Tasks");
    return OrientationBuilder(
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
                var categoryWidth = orientation == Orientation.portrait
                    ? screenWidth * 0.5
                    : screenWidth * 0.28;

                return Container(
                  // height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.11 : constraints.maxHeight * 0.5, // Adjust height based on orientation
                  //
                  // width: 400,
                  child: ListView.builder(
                    itemCount: controller.taskUncom.length,
                    itemBuilder: (context, index) {
                      final taskk = controller.taskUncom[index];
                      print("taskUn Id :${taskk.id}");
                      return GestureDetector(
                        onTap: () async{
                          await controller.fetchTaskHisDetailData(taskk.id??0);
                          print(" iddUnComp:${taskk.id}");
                          await Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskHistoryDetailPage(taskId: taskk.id??0,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            child: Container(
                              height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.11 : constraints.maxHeight * 0.35, // Adjust height based on orientation
                              width: categoryWidth*0.7,// Adjust height based on orientation
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(Icons.cancel_outlined,color: Colors.white,size: 25,),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.pink,
                                        height: MediaQuery.of(context).size.height * 0.065,
                                        width:  MediaQuery.of(context).size.width * 0.11,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(12,0,0,5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Text("Project", style:
                                              // //GoogleFonts.montserrat(textStyle:
                                              // TextStyle(
                                              //   fontWeight: FontWeight.w500,
                                              //   fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : constraints.maxHeight *0.06,)
                                              // ),
                                              Text(
                                                taskk.taskname.toString(),
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : constraints.maxHeight * 0.07,)),
                                              ),
                                              // Spacer(),
                                              Container(
                                                width: orientation == Orientation.portrait ? constraints.maxWidth *0.7 : constraints.maxWidth *0.4, // Adjust width based on orientation
                                                height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : constraints.maxHeight * 0.06, // Adjust // Adjust height based on orientation
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      size: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.02 : constraints.maxHeight * 0.05,

                                                    ),
                                                    Text(
                                                      "Duration : ",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black87)),
                                                    ),Text(
                                                      "${taskk.duration.toString()}",
                                                      style: GoogleFonts.lato(
                                                          textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black87)),
                                                    ),
                                                    // Text(
                                                    //   "${task.date2.toString().substring(0,10)}",
                                                    //   style: GoogleFonts.lato(
                                                    //       textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.black87)),
                                                    // ),
                                                  ],
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
                          ),
                        ),
                      );
                    },
                  ),
                  // ),
                );
              });
        });
  }
}
