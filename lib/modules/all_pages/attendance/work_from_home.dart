import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/work_from_home_controller.dart';
import 'package:nd_connect_techland/widget/elevated_button.dart';
import '../../../components/styles.dart';
import '../../bottom_bar/bottom_bar.dart';
import 'package:intl/intl.dart';
class WorkFromHome extends StatelessWidget {
  const WorkFromHome({super.key});

  @override
  Widget build(BuildContext context) {
    WfhController wfhController = Get.put(WfhController());
    final TextEditingController _startleavedateController =TextEditingController();
    final TextEditingController _endleavedateController = TextEditingController();
    final TextEditingController _reasonController = TextEditingController();
    var selectedDate = DateTime.now().obs;
    var selectedDate2 = DateTime.now().obs;

    chooseDate() async {
      DateTime today = DateTime.now();
      DateTime lastDate = DateTime(2050);

      DateTime? newpickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: today,
        firstDate: today, // Set firstDate to today to disable past dates
        lastDate: lastDate,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        helpText: 'Select Start Date',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'Selected Date',
      );

      if (newpickedDate != null) {
        selectedDate.value = newpickedDate;
        _startleavedateController
          ..text = DateFormat('yyyy-MM-d').format(selectedDate.value).toString()
          ..selection = TextSelection.fromPosition(
            TextPosition(
              offset: _startleavedateController.text.length,
              affinity: TextAffinity.upstream,
            ),
          );
      }
    }

    chooseDate2() async {
      DateTime today = selectedDate.value;
      DateTime lastDate = DateTime(2050);
      DateTime? newpickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: today,
        firstDate: today, // Set firstDate to today to disable past dates
        lastDate: lastDate,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        helpText: 'Select Start Date',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'Selected Date',
      );

      if (newpickedDate != null) {
        selectedDate2.value = newpickedDate;
        _endleavedateController
          ..text = DateFormat('yyyy-MM-d').format(selectedDate2.value).toString()
          ..selection = TextSelection.fromPosition(
            TextPosition(
              offset: _endleavedateController.text.length,
              affinity: TextAffinity.upstream,
            ),
          );
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor2,
        leading: IconButton(
            onPressed: () async{
              Get.offAll(()=>BottomBar());
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomBar()));
              //  Navigator.pop(context);
              // bottomNavController.changeTabIndex(0);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: Text(
          "Work From Home",
          style: TextStyle(color: Colors.white, fontSize: 20),
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

        var sizeWidth2 = orientation == Orientation.portrait
            ? screenWidth * 0.3
            : screenWidth * 0.19;
        var sizeHeight2 = orientation == Orientation.portrait
            ? screenHeight * 0.2
            : screenHeight * 0.4;
        var fontsize = orientation == Orientation.portrait
            ? screenHeight * 0.1
            : screenHeight * 0.3;

        var categoryWidth = orientation == Orientation.portrait
            ? screenWidth * 0.5
            : screenWidth * 0.5;
        var categoryHeight = orientation == Orientation.portrait
            ? screenHeight * 0.4
            : screenHeight * 0.9;
        var taskListWidth = orientation == Orientation.portrait
            ? screenWidth * 0.9
            : screenWidth;
        var taskListHeight = orientation == Orientation.portrait
            ? screenHeight * 0.4
            : screenHeight;
        return SingleChildScrollView(
          child: Container(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                // child: Container(
                //   margin: const EdgeInsets.symmetric(
                //       horizontal: 0.1, vertical: 5),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.black12,
                //           blurRadius: 20.0,
                //         )
                //       ]),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12), // Customize border radius
                           border: Border.all(color: Colors.grey.shade300), // Add a border
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Add padding
                        margin: const EdgeInsets.only(bottom: 10), // Add spacing between fields
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: _startleavedateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Start Date';
                            }
                            return null;
                          },
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            chooseDate();
                          },
                          cursorColor: appColor,
                          obscureText: false,
                          readOnly: true, // Make the field read-only
                          decoration: InputDecoration(
                            labelText: 'Start Date',
                            prefixIcon: Icon(Icons.calendar_month_outlined, color: Colors.green),
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                            border: InputBorder.none, // Removes default TextField border
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12), // Customize border radius
                           border: Border.all(color: Colors.grey.shade300), // Add a border
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Add padding
                        margin: const EdgeInsets.only(bottom: 10), // Add spacing between fields
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          controller: _endleavedateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter End Date';
                            }
                            return null;
                          },
                          onTap: () {
                            chooseDate2();
                          },
                          cursorColor: appColor,
                          obscureText: false,
                          readOnly: true, // Make the field read-only
                          decoration: InputDecoration(
                            labelText: 'End Date',
                            prefixIcon: Icon(Icons.calendar_month, color: Colors.purple),
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                            border: InputBorder.none, // Removes default TextField border
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12), // Customize border radius
                           border: Border.all(color: Colors.grey.shade300), // Add a border
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Changes position of shadow
                            ),
                          ],
                        ),
                        // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Add padding inside the container
                        margin: const EdgeInsets.only(bottom: 10,), // Add spacing from other elements
                        child: TextFormField(
                          controller: _reasonController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Reason';
                            }
                            return null;
                          },
                          maxLines: 3, // Allows multiline input
                          decoration: InputDecoration(
                            labelText: 'Reason',
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(
                              Icons.comment,
                              color: Colors.pink,
                            ),
                            border: InputBorder.none, // Removes default TextField border
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      MyElevatedButton(
                        onPressed: ()async{
                          print("wfh apply");
                          await wfhController.WfhApi(_startleavedateController.text, _endleavedateController.text, _reasonController.text);
                          print("wfh apply successfully");

                        },
                        text: Text(
                        'Apply',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                        height: 50,
                        width: 200,),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          //),
        );
      });
      }),
    );
  }
}
