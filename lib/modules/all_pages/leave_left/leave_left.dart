import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nd_connect_techland/controllers/leave_left_controller.dart';
import 'package:get/get.dart';
import '../../../components/styles.dart';
import '../../../constants/app_colorss/app_colorss.dart';
import '../../../constants/reusable_customdilog.dart';
import '../../../controllers/employeee_controllersss/apply_leave_controller/apply_controllerss.dart';
import '../pages/emploree_pages/leaves_employee/multiple_day.dart';
import '../pages/emploree_pages/leaves_employee/single_day.dart';


class LeaveLeft extends StatelessWidget {
  const LeaveLeft({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveApplyController _leaveApplyController = Get.put(LeaveApplyController());
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
    final List<IconData> iconns = [
      Icons.pentagon,
      Icons.square_rounded,
      Icons.circle,
      Icons.hexagon,
      Icons.label_important_rounded,
      Icons.circle,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor2,
        title: const Text(
          'Leaves Left',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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

          return Obx(
                () => (_leaveApplyController.isLoading.value)
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                itemCount: _leaveApplyController.leaveCategory.length,
                itemBuilder: (context, index) {
                  // Avoid range errors by using modulo operation
                  final colorIndex = index % colors.length;
                  final iconIndex = index % iconns.length;

                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: colors[colorIndex],
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Icon(
                            iconns[iconIndex],
                            size: 15,
                            color: iconColors[colorIndex],
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _leaveApplyController.leaveCategory[index]
                                    .leavetype
                                    .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Leave Left: ${_leaveApplyController.leaveCategory[index].leaveValue.toString()}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              showdilogleave(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: imageHeight * 0.2,
                              width: imageWidth * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: appColor2,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
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
                },
              ),
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
          titleFontSize: size.height * 0.019, // Use provided or default font size
          additionalTextColor1: Colors.red,
          titleText: "Select Leave Type",
          additionalText1OnTap: () {},
          additionalText2OnTap: () {},
          additionalText3OnTap: () {},
          cancelText: "Single Day Leave",
          submitText: 'Multiple Day Leave',
          submitText2: 'Other Leave',
          onSubmitPressed: () {
            Get.to(MultipleDayLeavePage());
          },
          onSubmit2Pressed: () {},
          onCancelPressed: () {
            Get.to(SingleDayLeavePage());
          },
        );
      },
    );
  }
}

