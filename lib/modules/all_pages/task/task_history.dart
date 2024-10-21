import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/modules/all_pages/task/re_assign_task.dart';
import 'package:nd_connect_techland/modules/all_pages/task/task_details_page.dart';
import 'package:get/get.dart';
import '../../../components/styles.dart';
import '../../../controllers/task_list_controller.dart';
import 'completed_tasks.dart';
import 'not_completed_tasks.dart';

class TaskHistory extends StatelessWidget {
  const TaskHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTaskController controller = Get.put(DateTaskController());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appColor2,
          title: Text(
            'Task History',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),

        body: OrientationBuilder(builder: (context, orientation) {
          return LayoutBuilder(builder: (context, constraints) {
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
            var categoryHeight = orientation == Orientation.portrait
                ? screenHeight * 0.3
                : screenHeight * 0.9;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Container(
                    height: categoryHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey,width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: Offset(0, 2), // Shadow to create depth
                        ),
                      ],
                    ),
                    child: TabBar(
                      labelColor: appColor2,
                      unselectedLabelColor: Colors.black.withOpacity(0.6),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3.0,
                          color: appColor2, // Underline for the selected tab
                        ),
                        insets: EdgeInsets.symmetric(
                            horizontal: 10.0), // Adds padding to the underline
                      ),
                      labelStyle: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: GoogleFonts.nunitoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      tabs: [
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              'Completed',
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
                              'Re-Assign',
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
                              'Incompleted',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CompletedTasks(),
                      ReAssignTasks(),
                      NotCompletedTasks(),
                    ],
                  ),
                ),
              ],
            );
          });
        }),

        // },
        //),
      ),
    );
  }
}
