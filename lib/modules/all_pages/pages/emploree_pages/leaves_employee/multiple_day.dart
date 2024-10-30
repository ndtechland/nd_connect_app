import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../components/styles.dart';
import '../../../../../controllers/employeee_controllersss/apply_leave_controller/apply_controllerss.dart';
import '../../../../../models/employee_model/apply_leave_model_dropdown.dart';
import '../../../../../widget/elevated_button.dart';

enum Gender { male, female, other }

class MultipleDayLeavePage extends StatelessWidget {
  // final RegistrationController _profileController =
  //     Get.put(RegistrationController());

  final LeaveApplyController _leaveApplyController = Get.put(LeaveApplyController());
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

  ///

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            bool isPortrait = constraints.maxHeight > constraints.maxWidth;

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: _buildAppBar(context),
              body: Obx(
                () => _leaveApplyController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    //child:
                    : Form(
                        key: _leaveApplyController.leaveapplysignupKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0.1, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20.0,
                                    )
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    ///todo: catagary...
                                    Obx(() => DropdownButtonFormField<
                                            GetLeaveTypeList>(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          iconEnabledColor: appColor,
                                          hint: Text(
                                            'Leave Category',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                            ),
                                          ),
                                          value: _leaveApplyController.selectedCatDropdown.value,
                                          decoration: InputDecoration(
                                           // labelText: 'Select Leave Category',
                                            prefixIcon: Icon(Icons.category,color: Colors.orange,),
                                            suffixIcon: Obx(() =>
                                                _leaveApplyController.isLoading.value
                                                    ? CircularProgressIndicator()
                                                    : TextButton(
                                                        clipBehavior: Clip.none,
                                                        onPressed: _leaveApplyController!.getCatLeavecatApi,
                                                        child: Icon(
                                                          Icons.refresh,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      )),
                                            // Icon(
                                            //   Icons.refresh,
                                            //   size: 23,
                                            //   color: Colors.black12,
                                            // ),
                                            labelStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: appColor),
                                            ),
                                          ),
                                          validator: (value) => value == null
                                              ? 'Please Select Leave category'
                                              : null,
                                          onChanged: (newValue) {
                                            _leaveApplyController.selectedCatDropdown.value = newValue;
                                          },
                                          items: _leaveApplyController.leaveCategory.map((category) {
                                            return DropdownMenuItem<
                                                GetLeaveTypeList>(
                                              value: category,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    category.leavetype ?? 'Unknown',
                                                    style: TextStyle(
                                                        // fontSize:
                                                        //     size.height * 0.02,
                                                        // color: logoColor,
                                                        //  fontWeight:
                                                        //      FontWeight.bold
                                                        ),
                                                  ), // Displaying Leave Type
                                                  SizedBox(width: size.width * 0.25),
                                                  Text(
                                                    "${category.leaveValue != null ? category.leaveValue.toString() : 'Unknown'}  Left",
                                                    style: TextStyle(
                                                        fontSize: size.height * 0.02,
                                                        color: appColor,
                                                        fontWeight: FontWeight.normal),
                                                  ), // Displaying Leave Value
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        )),

                                    SizedBox(height: 10,),

                                    ///todo: type 1 start....

                                    Obx(() =>
                                        DropdownButtonFormField<GetLeaveList>(
                                          //menuMaxHeight: 10,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          iconEnabledColor: appColor,
                                          hint: Text(
                                            'Leave Type start',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                            ),
                                          ),
                                          value: _leaveApplyController
                                              .selectedtypedropdown.value,
                                          decoration: InputDecoration(
                                            // labelText: 'Leave Type For Start',
                                            prefixIcon: Icon(Icons.fact_check,color: Colors.blueAccent,),
                                            suffixIcon: Obx(() =>
                                                _leaveApplyController
                                                        .isLoading.value
                                                    ? CircularProgressIndicator()
                                                    : TextButton(
                                                        clipBehavior: Clip.none,
                                                        onPressed:
                                                            _leaveApplyController!
                                                                .getLeavetypeApi,
                                                        child: Icon(
                                                          Icons.refresh,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      )),
                                            // Icon(
                                            //   Icons.refresh,
                                            //   size: 23,
                                            //   color: Colors.black12,
                                            // ),
                                            labelStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: appColor),
                                            ),
                                          ),
                                          validator: (value) => value == null
                                              ? 'Please Select Start Leave Type'
                                              : null,
                                          onChanged: (newValue) {
                                            _leaveApplyController
                                                .selectedtypedropdown
                                                .value = newValue;
                                          },
                                          items: _leaveApplyController.leaveType
                                              .map((type) {
                                            return DropdownMenuItem<
                                                GetLeaveList>(
                                              value: type,
                                              child: Text(type.typeofleave ??
                                                  'Unknown'),
                                            );
                                          }).toList(),
                                        )),

                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    ///todo: type 2 end....

                                    Obx(() =>
                                        DropdownButtonFormField<GetLeaveList>(
                                          hint: Text(
                                            'Leave Type For End',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          iconEnabledColor: appColor,
                                          value: _leaveApplyController.selectedtypeenddropdown.value,
                                          decoration: InputDecoration(
                                            // labelText: 'Leave Type For End',
                                            prefixIcon: Icon(Icons.free_cancellation,color: Colors.cyan,),
                                            suffixIcon: Obx(() =>
                                                _leaveApplyController.isLoading.value
                                                    ? CircularProgressIndicator()
                                                    : TextButton(
                                                        clipBehavior: Clip.none,
                                                        onPressed: _leaveApplyController!.getLeavetypeEndApi,
                                                        child: Icon(
                                                          Icons.refresh,
                                                          size: 20,
                                                          color: Colors.grey,
                                                        ),
                                                      )),
                                            // Icon(
                                            //   Icons.refresh,
                                            //   size: 23,
                                            //   color: Colors.black12,
                                            // ),
                                            labelStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: appColor),
                                            ),
                                          ),
                                          validator: (value) => value == null
                                              ? 'Please Select End Leave Type'
                                              : null,
                                          onChanged: (newValue) {
                                            _leaveApplyController.selectedtypeenddropdown.value = newValue;
                                          },
                                          items: _leaveApplyController.leaveTypeend.map((type) {
                                            return DropdownMenuItem<
                                                GetLeaveList>(
                                              value: type,
                                              child: Text(type.typeofleave ?? 'Unknown'),
                                            );
                                          }).toList(),
                                        )),

                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFormField(
                                      textAlign: TextAlign.left,
                                      controller: _startleavedateController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Start Date';
                                        }
                                        return null;
                                      },
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());

                                        chooseDate();
                                      },
                                      cursorColor: appColor,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Leave Start Date',
                                        prefixIcon: Icon(Icons.calendar_month_outlined,color: Colors.green,),
                                        //
                                        // suffixIcon: Icon(
                                        //   Icons.calendar_today,
                                        //   size: 23,
                                        //   color: Colors.black12,
                                        // ),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFormField(
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
                                      decoration: InputDecoration(
                                        labelText: 'Leave End Date',
                                        prefixIcon: Icon(Icons.calendar_month,color: Colors.purple,),

                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFormField(
                                      controller: _reasonController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Reason';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Reason',
                                        prefixIcon: Icon(Icons.comment,color: Colors.pink,),

                                        labelStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: appColor),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30),
                                    MyElevatedButton(
                                      onPressed: () async {
                                        if (_leaveApplyController.leaveapplysignupKey.currentState?.validate() ?? false) {
                                          if (_leaveApplyController.selectedCatDropdown.value!.id != null) {
                                            _leaveApplyController.applyLeave(
                                              typeOfLeaveId: _leaveApplyController.selectedCatDropdown.value!.id.toString(),
                                              startLeaveId: _leaveApplyController.selectedtypedropdown.value!.id.toString(),
                                              endeaveId: _leaveApplyController.selectedtypeenddropdown.value!.id.toString(),
                                              startDate: _startleavedateController.text,
                                              endDate: _endleavedateController.text,
                                              reason: _reasonController.text,

                                              // Pass file name
                                            );
                                            // await Future.delayed(Duration(seconds: 3));

                                            ///Clear dropdown value
                                            //_profileController.selectedState.value = null;
                                            // _profileController.selectedCity.value = null;
                                          } else {
                                            print('Please select a CV file');
                                          }
                                        }
                                      },
                                      text: Text(
                                        'Apply',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      height: 40,
                                      width: 200,
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        height: 200,
        //MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(color: appColor2
            //     gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     logoColor,
            //     logoColor,
            //   ],
            // )
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 12,
            ),
            logoImg(),
            // const Text(
            //   'Welcome to Hire Job India',
            //   style: TextStyle(
            //       color: Colors.white, fontSize: 16, fontFamily: 'medium'),
            // ),
            Text(
              'Apply Your Leave',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'medium'),
            ),
          ],
        ));
  }

  logoImg() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Image.asset(
        'lib/assets/logo/logoo.png',
        // 'lib/assets/images/job.png',
        //color: Colors.white,
        width: 100,
        height: 80,
      ),
    );
  }
}
