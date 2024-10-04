import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/styles.dart';
import '../../../controllers/bottom_nav_controller.dart';

class LeaveDetailPage extends StatefulWidget {
  final String taskId;

  LeaveDetailPage({required this.taskId});

  @override
  State<LeaveDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<LeaveDetailPage> {
  final BottomNavController bottomNavController = Get.find<BottomNavController>();
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
                    Text("Tittle :",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'poppins'
                    ),),
                    Text("Leave Page",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins'
                    ),),
                    SizedBox(height: 10,),
                    Text("Description :",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'poppins'
                    ),),
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins'
                    ),),
                    SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   //crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Checkbox(
                    //         checkColor: Colors.white,
                    //         fillColor: MaterialStateProperty.resolveWith(getColor),
                    //         value: this.isChecked,
                    //         onChanged: (bool? value) {
                    //           setState(() {
                    //             this.isChecked = value!;
                    //           });
                    //         }),
                    //     // SizedBox(
                    //     //   width: 6,
                    //     // ),
                    //     Text(
                    //       " It was popularised in the 1960s w ",
                    //       style: TextStyle(
                    //         color: appColor2,
                    //         fontSize: 16,
                    //         fontFamily: 'Poppins',
                    //         fontWeight: FontWeight.w400,
                    //         // height: 1.54,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Center(
                      child: Text(
                        'Details for Leave: ${widget.taskId}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Center(
                      child: Container(
                          height: imageHeight*0.3,
                          width: imageWidth*0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: appColor2
                          ),
                          child: TextButton(
                              onPressed: (){},
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
