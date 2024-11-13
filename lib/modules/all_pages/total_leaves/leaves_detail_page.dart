import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/total_leaves_date_controller.dart';

import '../../../components/styles.dart';
import '../../../controllers/bottom_nav_controller.dart';
import '../../bottom_bar/bottom_bar.dart';

class LeaveDetailPage extends StatefulWidget {
  final String leaveId;
  final String leaveType;

  LeaveDetailPage({required this.leaveId,required this.leaveType});


  @override
  State<LeaveDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<LeaveDetailPage> {
  final BottomNavController bottomNavController = Get.find<BottomNavController>();
  final TotalLeavesDateController totalLeavesDateController = Get.put(TotalLeavesDateController());
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appColor2,
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
          title: Text(
            'Leave Details',
            style: TextStyle(color: Colors.white,
                fontFamily: 'poppins',fontWeight: FontWeight.w600
            ),
          )),
      body: OrientationBuilder(builder: (context, orientation){
        return LayoutBuilder(builder: (context,constraints){
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
              : screenHeight * 0.5;

          var categoryWidth = orientation == Orientation.portrait
              ? screenWidth * 0.5
              : screenWidth * 0.28;
          var categoryHeight = orientation == Orientation.portrait
              ? screenHeight * 0.4
              : screenHeight * 0.8;

          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0,18,12,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align content at the top
                      children: [
                        Icon(Icons.rate_review_rounded, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded( // Ensure the text wraps within the available space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reason :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'poppins',
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${totalLeavesDateController.leavesDetailModel?.data?.reason.toString()}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                ),
                                softWrap: true, // Allow text to wrap
                                overflow: TextOverflow.visible, // Prevent text truncation
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled_outlined,color: Colors.green,),
                        SizedBox(width: 10,),
                        Text("Duration :",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins'
                        ),),
                        SizedBox(width: 10,),

                        Text("${totalLeavesDateController.leavesDetailModel?.data?.totaldays}",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins'
                        ),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.paid,color: Colors.orangeAccent,),
                        SizedBox(width: 10,),
                        Text("Paid Leave :",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins'
                        ),),
                        SizedBox(width: 10,),
                        Text("${totalLeavesDateController.leavesDetailModel?.data?.paidLeave}",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins'
                        ),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.paid,color: Colors.redAccent,),
                        SizedBox(width: 10,),
                        Text("Un-paid Leave :",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins'
                        ),),
                        SizedBox(width: 10,),
                        Text("${totalLeavesDateController.leavesDetailModel?.data?.unPaidLeave}",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins'
                        ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.paid,color: Colors.redAccent,),
                        SizedBox(width: 10,),
                        Text("Leave Dates :",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins'
                        ),),
                        SizedBox(width: 10,),
                        Text("${totalLeavesDateController.leavesDetailModel?.data?.leaveStartdate} - ${totalLeavesDateController.leavesDetailModel?.data?.leaveEnddate}",style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'poppins'
                        ),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.type_specimen_rounded,color: Colors.deepPurple,),
                        SizedBox(width: 10,),
                        Text("Leave Type :",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'poppins'
                        ),),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text("${widget.leaveType}",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                            overflow: TextOverflow.visible, // Prevent text truncation

                          ),),
                        ),
                      ],
                    ),

                    // Center(
                    //   child: Text(
                    //     'Details for Leave: ${widget.leaveId}',
                    //     style: TextStyle(fontSize: 16),
                    //   ),
                    // ),
                    SizedBox(height: 20,),
                    Center(
                      child: Container(
                          height: imageHeight*0.3,
                          width: imageWidth*0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: appColor2
                          ),
                          child: TextButton(
                              onPressed: (){
                                Get.offAll(()=>BottomBar());
                              },
                              child: Text("Done",
                                style: TextStyle(
                                    fontFamily: 'montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,fontSize: 16
                                ),))),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      }
      ),
    );
  }
}
