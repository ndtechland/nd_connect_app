import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_connect_techland/controllers/leave_left_controller.dart';
import 'package:get/get.dart';
import '../../../components/styles.dart';
import '../../../constants/app_colorss/app_colorss.dart';
import '../../../constants/reusable_customdilog.dart';
import '../pages/emploree_pages/leaves_employee/multiple_day.dart';
import '../pages/emploree_pages/leaves_employee/single_day.dart';
class LeaveLeft extends StatelessWidget {
  const LeaveLeft({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveLeftController leaveLeftController = Get.put(LeaveLeftController());
    final List<Color> colors = [
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
List<IconData> iconns = [
  Icons.circle,
  Icons.pentagon,
  Icons.square_rounded,
  Icons.hexagon,
  Icons.label_important_rounded ,
  Icons.circle,
];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: Text(
          'Leaves Left',
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
      body: OrientationBuilder(builder: (context, orientation){
        return LayoutBuilder(builder: (context, constraints){
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
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                itemCount: leaveLeftController.allLeave.length,
                  itemBuilder: (context,index){
                final leave =
                leaveLeftController.allLeave[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //elevation: 2,
                  color: colors[index],
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Icon(iconns[index],size: 15,color: iconColors[index],),
                        SizedBox(width: 10,),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(leave.leaveType,
                                style: TextStyle(
                                fontWeight: FontWeight.w600,
                                  fontSize: 18,
                              ),),
                             // SizedBox(height: 4,),
                              Text("Leave Left :${leave.leftLeave}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            showdilogleave(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: imageHeight * 0.2,
                            width: imageWidth * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  16),
                              border: Border.all(
                                  color: appColor2,
                                  width: 1),
                            ),
                            child: Text(
                              "Apply Leave",
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
            ),
          );
        });
      }),
    );
  }
  showdilogleave(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showCupertinoDialog(
      barrierDismissible: true, // Set barrierDismissible to true
      context: context,
      builder: (BuildContext context) {
        return ReusableCustomDialog(
          contentColor: AppColors.black,
          titleColor: Colors.white,
          titleFontSize:
          size.height * 0.019, // Use provided or default font size

          additionalTextColor1: Colors.red,
          //additionalTextColor2: Colors.red,
          titleText: "Select Leave Type",
          //contentText
          //contentText: '',
          //additionalText1: "First Half",
          //additionalText2: "Second Half",
          // additionalText3: "Full Day",
          additionalText1OnTap: () {},
          additionalText2OnTap: () {},
          additionalText3OnTap: () {},

          cancelText: "Single Day Leave", //onCancelPressed

          submitText: 'Multiple Day Leave', //onSubmitPressed
          submitText2: 'Other Leave', //onSubmit2Pressed

          // onCancelPressed: () {
          //   Get.back();
          // },
          //  final VoidCallback onCancelPressed;
          //   final VoidCallback onSubmitPressed;
          //   final VoidCallback onSubmit2Pressed;
          onSubmitPressed: () {
            //Get.back();
            Get.to(MultipleDayLeavePage());
            //Get.back();
          },

          onSubmit2Pressed: () {
            //Get.to(MultipleDayLeavePage());

            //Get.back();

            //Get.to(DecreaseLoad1());
            //Get.back();
          },
          // onCancelPressedCallback: () {},
          onCancelPressed: () {
            Get.to(SingleDayLeavePage());
          },
        );
      },
    );
  }
}
