import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import '../../../components/styles.dart';
import '../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import 'package:intl/intl.dart';
import '../../../controllers/location_controller.dart';
import '../../bottom_bar/bottom_bar.dart';
import 'attendanceBottomSheet.dart';
import 'package:lottie/lottie.dart';
class Attendance extends StatelessWidget {
  String id ='13';
   Attendance({super.key,required this.id});
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    bool shouldPop = true;
    ValueNotifier<bool> isActive = ValueNotifier<bool>(false);
    ValueNotifier<bool> isLoadinggg = ValueNotifier<bool>(false);
    final ProfileEmployeeController _getprofileepersonal =
        Get.put(ProfileEmployeeController());
    final AttendanceController attendanceController = Get.put(AttendanceController());
    final LocationController locationController = Get.put(LocationController());
    print("attendanceeDattaa:${attendanceController.attendanceActivityModel}");
    void showModalRightSheet(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0)),
              ),
              child: AttendanceBottomSheet(),
            ),
          );
        },
      );
    }

    void showAttendanceBottomSheet(BuildContext context) {
      final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

      if (isLandscape) {
        showModalRightSheet(context);
      } else {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 0.8,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                  ),
                  child: AttendanceBottomSheet(),
                );
              },
            );
          },
        );
      }
    }
    return WillPopScope(
      onWillPop: () async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => BottomBar());
        });
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: appColor2,
            leading: IconButton(
                onPressed: () async{
                 await attendanceController.EmpActivityApi();
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
              "Attendance",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
             actions: [
               Text(
                 attendanceController.attendanceDetailsModel?.data?.loginStatus=="Check-In"?"In":"Out",
                 //locationController.statusColor.value==Color(0xfff44336)?"Out":"In",
                 style: TextStyle(color:attendanceController.attendanceDetailsModel?.data?.loginStatus=="Check-In"?Colors.green:Colors.red),),
               // ),
               SizedBox(width: 4,),
               Padding(
                 padding: const EdgeInsets.only(right: 12.0),
                 child: CircleAvatar(
                   radius: 8,
                   child: Container(
                     decoration: BoxDecoration(
                       color: attendanceController.attendanceDetailsModel?.data?.loginStatus=="Check-In"?Colors.green:Colors.red,
                       shape: BoxShape.circle,
                     ),
                   ),
                 ),
               ),
            //   Padding(
            //     padding: const EdgeInsets.only(right: 8.0),
            //     child: GestureDetector(
            //       onTap: () {
            //         showDialog(
            //           context: context,
            //           builder: (context) => AlertDialog(
            //             shape: ContinuousRectangleBorder(
            //                 side: BorderSide.none,
            //                 borderRadius: BorderRadius.circular(12)
            //             ),
            //             title: Text('Check-Out'),
            //             content: Text('Do you really want to check out'),
            //             actions: [
            //               Container(
            //                 height:40,
            //                 width: 70,
            //                 decoration: BoxDecoration(
            //                     color: Colors.green,
            //                     borderRadius: BorderRadius.circular(12)
            //
            //                 ),
            //                 child: TextButton(
            //                   onPressed: () => Navigator.pop(context),
            //                   child: Text('No',style: TextStyle(color: Colors.white),),
            //                 ),
            //               ),
            //
            //               Container(
            //                 height:40,
            //                 width: 70,
            //                 decoration: BoxDecoration(
            //                     color: Colors.red,
            //                     borderRadius: BorderRadius.circular(12)
            //
            //                 ),
            //                 child: TextButton(
            //                   onPressed: () async{
            //                     print("cheedck-Outt");
            //                     await locationController.employeeCheckOut();
            //                     await attendanceController.EmpActivityApi();
            //                     print("cheedck-Outt done");
            //                     WidgetsBinding.instance.addPostFrameCallback((_) {
            //                       Get.offAll(() => BottomBar());
            //                     });
            //                   },
            //                   child: Text('Yes',style: TextStyle(color: Colors.white),),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //       child: CircleAvatar(
            //         radius: 16,
            //         backgroundColor: Colors.white,
            //         child: Icon(
            //           size: 20,
            //               Icons.logout_rounded,
            //               color: Colors.black87,
            //             ),
            //       ),
            //     ),
            //   )
            ],
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
                  : screenWidth ;
              var taskListHeight = orientation == Orientation.portrait
                  ? screenHeight * 0.4
                  : screenHeight ;
              return SingleChildScrollView(
                child: Obx(()=>(attendanceController.isLoading.value ||
                    isLoading.value)
                    ? Center(child: CircularProgressIndicator())
                    :
                Container(
                    // height: screenHeight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name date calendar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/1.8,
                                height:taskListHeight * 0.2,
                                // color: Colors.pink,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text: "Morning, ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87
                                              // fontFamily: 'poppins'
                                              ),
                                          children: [
                                            TextSpan(
                                              text: "${_getprofileepersonal.getprofileemployeeModel?.data?.fullName}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.blue),
                                            )
                                          ]),
                                    ),
                                    // Text("Morning, ${_getprofileepersonal.getprofileemployeeModel?.data?.fullName}",
                                    //   style: TextStyle(
                                    //   fontSize: 20,
                                    //   fontWeight: FontWeight.w600,
                                    //  // fontFamily: 'poppins'
                                    // ),),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Text(
                                    //   DateFormat('d MMM y').format(attendanceController.selectedDate.value),
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w500,
                                    //       fontSize: 15,
                                    //       color: Colors.black),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "Office Hour-> ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black87,
                                            fontSize: fontsize*0.2,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "${_getprofileepersonal.getprofileemployeeModel?.data?.shiftTime.toString()}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  color: Colors.orange[700]),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2.95,
                                height: MediaQuery.of(context).size.height/15,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Text("Search",style: TextStyle(),),
                                  Text(
                                    DateFormat('d MMM y').format(attendanceController.selectedDate.value),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: appColor2),
                                  ),
                                  SizedBox(width: 6,),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InkWell(
                                        onTap: ()async{
                                          DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime.now(),
                                          );

                                          if (pickedDate != null) {
                                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                            attendanceController.updateSelectedDate(pickedDate);
                                          }
                                        },
                                        child: Icon(Icons.search,color: Colors.red,)),
                                  )
                                ],
                              ),
                              )
                              // Container(
                              //   child: CircleAvatar(
                              //     radius: 26,
                              //     child: ClipOval(
                              //       child: responsiveContainer(
                              //         // padding: const EdgeInsets.only(right: 0),
                              //         //height: 20,
                              //         //width: 20,
                              //         heightPortrait:
                              //             MediaQuery.of(context).size.height * 0.12,
                              //         widthPortrait:
                              //             MediaQuery.of(context).size.width * 0.25,
                              //         heightLandscape:
                              //             MediaQuery.of(context).size.height * 0.3,
                              //         widthLandscape:
                              //             MediaQuery.of(context).size.width * 0.2,
                              //         // height: MediaQuery.of(context).size.height *
                              //         //     0.05, // 20% of screen height if not provided
                              //         // width: MediaQuery.of(context).size.width * 0.09,
                              //         //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
                              //         child: _getprofileepersonal.getprofileemployeeModel?.data?.empProfile != null
                              //             ? Image.network(
                              //                 // "${FixedText.apiurl2}"
                              //                 "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile}",
                              //                 //color: appColor,
                              //                 fit: BoxFit.cover,
                              //                 errorBuilder: (context, error, stackTrace) {
                              //                   return Image.asset(
                              //                     'lib/assets/logo/logoo.png',
                              //                     fit: BoxFit.contain,
                              //                   );
                              //                 },
                              //               )
                              //             : Image.network(
                              //                 'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                              //                 fit: BoxFit.fill,
                              //               ),
                              //         context: context,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //check in check out
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: categoryHeight * 0.5,
                                width: categoryWidth * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                            backgroundColor: Colors.green.shade50,
                                            child: Icon(
                                              Icons.login_rounded,
                                              color: Colors.green,
                                              size: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Check - In",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.grey),
                                          ),
                                          // CircleAvatar(
                                          //   radius: 16,
                                          //   backgroundColor:Colors.green.shade50,
                                          //   child: Icon(Icons.login_rounded,
                                          //       color: Colors.green,
                                          //     size: 20,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      SizedBox(
                                        height: sizeHeight2 * 0.1,
                                      ),
                                      Text(
                                        attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                                        "Not Check-in yet"
                                            :"${attendanceController.attendanceDetailsModel?.data?.checkInTime}",
                                        style: TextStyle(
                                            fontSize:
                                            attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                                            15:20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: sizeHeight2 * 0.1,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "On-Time",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Spacer(),
                                          attendanceController.selectedDate.value.year == DateTime.now().year &&
                                              attendanceController.selectedDate.value.month == DateTime.now().month &&
                                              attendanceController.selectedDate.value.day == DateTime.now().day ?
                                          GestureDetector(
                                            onTap: ()async{
                                              print("checkk-iN");
                                              try {
                                                isLoading.value = true;
                                                // if(isLoading.value = true){
                                                //   showDialog(context: context,  builder: (context) => AlertDialog(
                                                //    shape: ContinuousRectangleBorder(
                                                //        side: BorderSide.none,
                                                //        borderRadius: BorderRadius.circular(12)
                                                //    ),
                                                //    // title: Text('Check-Out'),
                                                //    // content: Text('Do you really want to check out'),
                                                //    actions: [ Padding(
                                                //      padding: const EdgeInsets.all(18.0),
                                                //      child: Center(child: CircularProgressIndicator()),
                                                //    )
                                                //     ]));
                                                // }
                                                if(attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
                                                  await locationController.checkAndRequestLocationPermission();
                                                  await locationController.fetchCurrentLocation();
                                                  await locationController.fetchCompanyLocationApi();
                                                  await locationController.getCoordinatesFromAddress();
                                                  showAttendanceBottomSheet(context);

                                                  // Fetch and update distance
                                                  await locationController.updateDistanceFromCompany();
                                                }
                                                else if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
                                                  await locationController.checkAndRequestLocationPermission();
                                                  Fluttertoast.showToast(
                                                         msg: "You are already Check-In",
                                                         backgroundColor: Colors.green,
                                                         textColor: Colors.white,
                                                         toastLength: Toast.LENGTH_LONG,
                                                         gravity: ToastGravity.CENTER,
                                                       );
                                                  Get.to(() => Attendance(id: '13'));
                                                } else{
                                                   Get.to(() => Attendance(id: '13'));
                                                 }
                                              } catch (e) {
                                                print("Error during attendance process: $e");
                                              } finally {
                                                // Reset the loading state after operations are complete
                                                isLoading.value = false;
                                                // isActive.value = false;
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: imageHeight * 0.15,
                                              width: imageWidth * 0.35,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color:  Colors.green.shade50,
                                                border: Border.all(color: Colors.green, width: 1),
                                              ),
                                              child:  Text(
                                                "Check-in",
                                                style: TextStyle(
                                                  fontFamily: 'poppins',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ):Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: categoryHeight * 0.5,
                                width: categoryWidth * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            radius: 14,
                                            backgroundColor: Colors.red.shade50,
                                            child: Icon(
                                              Icons.logout_rounded,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Check - Out",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.grey),
                                          ),
                                          // CircleAvatar(
                                          //   radius: 16,
                                          //   backgroundColor:Colors.green.shade50,
                                          //   child: Icon(Icons.login_rounded,
                                          //       color: Colors.green,
                                          //     size: 20,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                                        "Not Check-in yet"
                                        :"${attendanceController.attendanceDetailsModel?.data?.checkOutTime}",
                                        style: TextStyle(
                                            fontSize:
                                            attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                                            15:20,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: sizeHeight2 * 0.1,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "On-Time",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Spacer(),
                                          attendanceController.selectedDate.value.year == DateTime.now().year &&
                                              attendanceController.selectedDate.value.month == DateTime.now().month &&
                                              attendanceController.selectedDate.value.day == DateTime.now().day ?
                                          GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                        shape: ContinuousRectangleBorder(
                                                            side: BorderSide.none,
                                                            borderRadius: BorderRadius.circular(12)
                                                        ),
                                                        title: Text('Check-Out'),
                                                        content: Text('Do you really want to check out'),
                                                        actions: [
                                                          Container(
                                                            height:40,
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                                color: Colors.green,
                                                                borderRadius: BorderRadius.circular(12)

                                                            ),
                                                            child: TextButton(
                                                              onPressed: () => Navigator.pop(context),
                                                              child: Text('No',style: TextStyle(color: Colors.white),),
                                                            ),
                                                          ),

                                                          Container(
                                                            height:40,
                                                            width: 70,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(12)

                                                            ),
                                                            child: TextButton(
                                                              onPressed: () async{
                                                                print("cheedck-Outt");
                                                                await locationController.employeeCheckOut();
                                                                await attendanceController.EmpActivityApi();
                                                                print("cheedck-Outt done");
                                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                  Get.offAll(() => BottomBar());
                                                                });
                                                              },
                                                              child: Text('Yes',style: TextStyle(color: Colors.white),),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                        alignment: Alignment.center,
                                                        height: imageHeight * 0.15,
                                                        width: imageWidth * 0.35,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(16),
                                                          color:  Colors.red.shade50,
                                                          border: Border.all(color: Colors.red, width: 1),
                                                        ),
                                                        child:  Text(
                                                          "Check-out",
                                                          style: TextStyle(
                                                            fontFamily: 'poppins',
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                ):Container(),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //over time
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       height: categoryHeight * 0.5,
                          //       width: categoryWidth * 0.85,
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(8),
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.black12,
                          //             blurRadius: 20.0,
                          //           ),
                          //         ],
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 CircleAvatar(
                          //                   radius: 14,
                          //                   backgroundColor: Color(0xffdcf2fc),
                          //                   child: Icon(
                          //                     Icons.timer,
                          //                     color: Colors.indigoAccent,
                          //                     size: 18,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   "Start-Overtime",
                          //                   style: TextStyle(
                          //                       fontSize: 14,
                          //                       color: Colors.grey,
                          //                       overflow: TextOverflow.ellipsis),
                          //                 ),
                          //                 // CircleAvatar(
                          //                 //   radius: 16,
                          //                 //   backgroundColor:Colors.green.shade50,
                          //                 //   child: Icon(Icons.login_rounded,
                          //                 //       color: Colors.green,
                          //                 //     size: 20,
                          //                 //   ),
                          //                 // )
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: 12,
                          //             ),
                          //             Text(
                          //               attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                          //               "Not Check-in yet" :
                          //               "${attendanceController.attendanceDetailsModel?.data?.startOverTime}",
                          //               style: TextStyle(
                          //                   fontSize:  attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                          //                   15 :20,
                          //                   color: Colors.black87,
                          //                   fontWeight: FontWeight.w600),
                          //             ),
                          //             SizedBox(
                          //               height: sizeHeight2 * 0.1,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 Text(
                          //                   "On-Time",
                          //                   style: TextStyle(
                          //                       fontSize: 14,
                          //                       color: Colors.grey,
                          //                       fontFamily: 'poppins',
                          //                       fontWeight: FontWeight.w500),
                          //                 ),
                          //                 Spacer(),
                          //                 attendanceController.selectedDate.value.year == DateTime.now().year &&
                          //                     attendanceController.selectedDate.value.month == DateTime.now().month &&
                          //                     attendanceController.selectedDate.value.day == DateTime.now().day ?
                          //                 GestureDetector(
                          //                   onTap: ()async{
                          //                     print("start-iN");
                          //                     try {
                          //                       isLoading.value = true;
                          //                       // if(isLoading.value = true){
                          //                       //   showDialog(context: context,  builder: (context) => AlertDialog(
                          //                       //    shape: ContinuousRectangleBorder(
                          //                       //        side: BorderSide.none,
                          //                       //        borderRadius: BorderRadius.circular(12)
                          //                       //    ),
                          //                       //    // title: Text('Check-Out'),
                          //                       //    // content: Text('Do you really want to check out'),
                          //                       //    actions: [ Padding(
                          //                       //      padding: const EdgeInsets.all(18.0),
                          //                       //      child: Center(child: CircularProgressIndicator()),
                          //                       //    )
                          //                       //     ]));
                          //                       // }
                          //                       if(attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-Out") {
                          //                         Fluttertoast.showToast(
                          //                           msg: "You are not Checked-In",
                          //                           backgroundColor: Colors.deepOrange,
                          //                           textColor: Colors.white,
                          //                           toastLength: Toast.LENGTH_LONG,
                          //                           gravity: ToastGravity.CENTER,
                          //                         );
                          //                       }
                          //                       else if (attendanceController.attendanceDetailsModel?.data?.loginStatus == "Check-In") {
                          //                         await locationController.startOverTime();
                          //                         Fluttertoast.showToast(
                          //                           msg: "Your start over time request has been sent !!",
                          //                           backgroundColor: Colors.green,
                          //                           textColor: Colors.white,
                          //                           toastLength: Toast.LENGTH_LONG,
                          //                           gravity: ToastGravity.CENTER,
                          //                         );
                          //                         // Get.to(() => Attendance(id: '13'));
                          //                       } else{
                          //                         // Get.to(() => Attendance(id: '13'));
                          //                       }
                          //                     } catch (e) {
                          //                       print("Error during attendance process: $e");
                          //                     } finally {
                          //                       // Reset the loading state after operations are complete
                          //                       isLoading.value = false;
                          //                       // isActive.value = false;
                          //                     }
                          //                   },
                          //                   child: Container(
                          //                     alignment: Alignment.center,
                          //                     height: imageHeight * 0.15,
                          //                     width: imageWidth * 0.35,
                          //                     decoration: BoxDecoration(
                          //                       borderRadius: BorderRadius.circular(16),
                          //                       color:  Color(0xffdcf2fc),
                          //                       border: Border.all(color: Colors.indigoAccent, width: 1),
                          //                     ),
                          //                     child:  Text(
                          //                       "Start",
                          //                       style: TextStyle(
                          //                         fontFamily: 'poppins',
                          //                         fontSize: 12,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ):Container()
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     Container(
                          //       height: categoryHeight * 0.5,
                          //       width: categoryWidth * 0.85,
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.circular(8),
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.black12,
                          //             blurRadius: 20.0,
                          //           ),
                          //         ],
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 CircleAvatar(
                          //                   radius: 14,
                          //                   backgroundColor: Colors.brown.shade50,
                          //                   child: Icon(
                          //                     Icons.timer_off,
                          //                     color: Colors.brown,
                          //                     size: 18,
                          //                   ),
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   "Finish-Overtime",
                          //                   style: TextStyle(
                          //                       fontSize: 13, color: Colors.grey),
                          //                 ),
                          //                 // CircleAvatar(
                          //                 //   radius: 16,
                          //                 //   backgroundColor:Colors.green.shade50,
                          //                 //   child: Icon(Icons.login_rounded,
                          //                 //       color: Colors.green,
                          //                 //     size: 20,
                          //                 //   ),
                          //                 // )
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: 12,
                          //             ),
                          //             Text(
                          //               attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                          //               "Not Check-in yet" :
                          //               "${attendanceController.attendanceDetailsModel?.data?.finishOverTime}",
                          //               style: TextStyle(
                          //                   fontSize: attendanceController.attendanceDetailsModel?.data?.checkInTime=="N/A" || attendanceController.attendanceDetailsModel?.data?.checkInTime==null?
                          //                   15 :20,
                          //                   color: Colors.black87,
                          //                   fontWeight: FontWeight.w600),
                          //             ),
                          //             SizedBox(
                          //               height: 10,
                          //             ),
                          //             Text(
                          //               "On-Time",
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   color: Colors.grey,
                          //                   fontFamily: 'poppins',
                          //                   fontWeight: FontWeight.w500),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          ///total working hours
                          Container(
                            height: categoryHeight * 0.5,
                            width: taskListWidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.work_history_outlined,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Total Working Hour",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                              GestureDetector(
                                onTap: () async{
                                  await attendanceController.EmpActivityApi();
                                  // Navigate to TaskDetailPage and pass the task ID (for example: 'taskId-$index')
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        elevation: 16,
                                        child: Container(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(18.0,0,0,0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Recent Activity', style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black87
                                                      // fontFamily: 'poppins'
                                                    ),),
                                                    IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.cancel_outlined,color: Colors.red,))
                                                  ],
                                                ),
                                              ),
                                              //SizedBox(height: 8),
                                              // _buildRow(Icons.login,Icons.logout_rounded, Colors.green,Colors.red,'Check-In','Check-Out', "${attendanceController.attendanceDetailsModel?.data?.checkInTime.toString()}","${attendanceController.attendanceDetailsModel?.data?.checkOutTime}",Colors.green.shade50,Colors.red.shade50,),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(18.0,10,0,0),
                                                child:  Row(
                                                  children: <Widget>[
                                                    CircleAvatar(child: Icon(Icons.timer,size: 20,color: Colors.indigoAccent,),backgroundColor:  Color(0xffdcf2fc),radius: 18,),
                                                    SizedBox(width: 8),
                                                    Text("Break-In",style: TextStyle(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                    Spacer(),
                                                    attendanceController.selectedDate.value.year == DateTime.now().year &&
                                                        attendanceController.selectedDate.value.month == DateTime.now().month &&
                                                        attendanceController.selectedDate.value.day == DateTime.now().day ?
                                                    IconButton(onPressed: ()async{
                                                      await locationController.breakInApi();
                                                    }, icon: Icon(Icons.logout_sharp,size: 22))
                                                        :Container(),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8,),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18.0,right: 10),
                                                child: Container(
                                                  height: 50,

                                                  child: ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: attendanceController.attendanceDetailsModel?.data?.loginactivities?.length,
                                                      itemBuilder: (context,index){
                                                        return Card(  clipBehavior: Clip.antiAlias,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                         // elevation: 2,
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(6,8,12,8),

                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.orange.shade100,
                                                                  child: Text('${index+1}', style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black87
                                                                    // fontFamily: 'poppins'
                                                                  ),),
                                                                ),
                                                                Text('${attendanceController.attendanceDetailsModel?.data?.loginactivities?[index].breakIn}', style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.black87
                                                                  // fontFamily: 'poppins'
                                                                ),),
                                                              ],
                                                            ),
                                                          ),);
                                                      }),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(18.0,12,0,0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(child: Icon(Icons.timer_off,size: 20,color: Colors.brown,),backgroundColor: Colors.brown.shade50,radius: 18,),
                                                    SizedBox(width: 8),
                                                    Text("Break-Out",style: TextStyle(
                                                        fontWeight: FontWeight.w600
                                                    ),),
                                                    Spacer(),
                                                    attendanceController.selectedDate.value.year == DateTime.now().year &&
                                                        attendanceController.selectedDate.value.month == DateTime.now().month &&
                                                        attendanceController.selectedDate.value.day == DateTime.now().day ?
                                                    IconButton(
                                                      onPressed: () async {
                                                        await locationController.breakOutApi();
                                                      },
                                                      icon: Icon(Icons.logout_sharp, size: 22),
                                                    )
                                                        : Container(),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 18.0,right: 10),
                                                child: Container(
                                                  height: 50,
                                                  child: ListView.builder(
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount:attendanceController.attendanceDetailsModel?.data?.loginactivities?.length,
                                                      itemBuilder: (context,index){
                                                        return Card(  clipBehavior: Clip.antiAlias,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                          ),
                                                          // elevation: 2,
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(6,8,12,8),

                                                            child: Row(
                                                              children: [
                                                                CircleAvatar(
                                                                  backgroundColor: Colors.teal.shade100,
                                                                  child: Text('${index+1}', style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black87
                                                                    // fontFamily: 'poppins'
                                                                  ),),
                                                                ),
                                                                Text('${attendanceController.attendanceDetailsModel?.data?.loginactivities?[index].breakOut}', style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.black87
                                                                  // fontFamily: 'poppins'
                                                                ),),
                                                              ],
                                                            ),
                                                          ),);
                                                      }),
                                                ),
                                              ),
                                              SizedBox(height: 30),

                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: imageHeight * 0.15,
                                  width: imageWidth * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.yellow.shade100,
                                    border: Border.all(color: Colors.yellow, width: 1),
                                  ),
                                  child: Text(
                                    "See Activity",
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                ))
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     Text(
                                      //       attendanceController.selectedDate.value.year == DateTime.now().year &&
                                      //           attendanceController.selectedDate.value.month == DateTime.now().month &&
                                      //           attendanceController.selectedDate.value.day == DateTime.now().day?
                                      //       "Today":"${ DateFormat('d MMMM y').format(attendanceController.selectedDate.value).toString().substring(0,6)}",
                                      //       style: TextStyle(
                                      //           fontSize: 14,
                                      //           color: Colors.grey,
                                      //           fontFamily: 'poppins',
                                      //           fontWeight: FontWeight.w500),
                                      //     ),
                                      //     Text(
                                      //       "${attendanceController.attendanceDetailsModel?.data?.totalWorkingHours}",
                                      //       style: TextStyle(
                                      //           fontSize: 16,
                                      //           color: Colors.black87,
                                      //           fontWeight: FontWeight.w600),
                                      //     ),
                                      //   ],
                                      // ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            attendanceController.selectedDate.value.year == DateTime.now().year &&
                                                attendanceController.selectedDate.value.month == DateTime.now().month &&
                                                attendanceController.selectedDate.value.day == DateTime.now().day
                                                ? "Today"
                                                : "${DateFormat('d MMMM y').format(attendanceController.selectedDate.value).toString().substring(0,6)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Obx(() => Row(
                                            children: [
                                              Text(
                                                "${attendanceController.totalWorkingHours}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Lottie.asset(
                                                'lib/assets/refresh.json',
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              )
                                            ],
                                          )),
                                        ],
                                      ),

                                      Container(
                                        height: sizeHeight2 * 0.35,
                                        width: 50,
                                        //color: Colors.pink,
                                        child: VerticalDivider(
                                          width: 20,
                                          thickness: 1,
                                          indent: 20,
                                          endIndent: 0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "This Pay Period",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${attendanceController.attendanceDetailsModel?.data?.monthlyWorkingHours}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),  SizedBox(
                            height: 10,
                          ),

                          //overview
                          Text(
                            "Overview",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // color: Colors.pink,
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Presence",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${attendanceController.attendanceDetailsModel?.data?.presencepercentage}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        // fontFamily: 'poppins'
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: sizeHeight2 * 0.6,
                                width: 50,
                                //color: Colors.pink,
                                child: VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                // color: Colors.pink,
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Absence",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${attendanceController.attendanceDetailsModel?.data?.absencepercentage}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        // fontFamily: 'poppins'
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: sizeHeight2 * 0.6,
                                width: 50,
                                // color: Colors.pink,
                                child: VerticalDivider(
                                  width: 20,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                // color: Colors.pink,
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Overtime",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${attendanceController.attendanceDetailsModel?.data?.overtimeWorkingHours}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        // fontFamily: 'poppins'
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          })),
    );
  }
  Widget _buildRow(IconData icon1,IconData icon2,Color iconColor1, Color iconColor2, String name1,String name2, String score1,String score2,Color color1,Color color2,) {
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 18.0),
      padding: EdgeInsets.fromLTRB(18.0,10,18,10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         // SizedBox(height: 12),
          Container(
            child: Row(
              children: <Widget>[
                CircleAvatar(child: Icon(icon1,size: 20,color: iconColor1,),backgroundColor: color1,radius: 18,),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name1,style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),),
                    Text(score1,style: TextStyle(
                       fontSize: 13
                    ),),
                  ],
                ),
                Spacer(),
                CircleAvatar(child: Icon(icon2,size: 20,color: iconColor2,),backgroundColor: color2,radius: 18,),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name2,style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),),
                    Text(score2,style: TextStyle(
                        fontSize: 13
                    ),),
                    //Text(date.toString().substring(0,10)),
                  ],
                ),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Card(
          //         clipBehavior: Clip.antiAlias,
          //         shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         ),
          //         elevation: 2,
          //       // decoration: BoxDecoration(
          //       //   color: Colors.white,
          //       //   borderRadius: BorderRadius.circular(8),
          //         // boxShadow: [
          //         //   BoxShadow(
          //         //     color: Colors.black12,
          //         //     blurRadius: 20.0,
          //         //   ),
          //         // ],
          //     //  ),
          //       // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          //       child: Padding(
          //         padding: const EdgeInsets.fromLTRB(18,8,18,8),
          //         child: Text('$score1', style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black87
          //           // fontFamily: 'poppins'
          //         ),),
          //       ),
          //     ),
          //     Card(
          //         clipBehavior: Clip.antiAlias,
          //         shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         ),
          //         elevation: 2,
          //       // decoration: BoxDecoration(
          //       //   color: Colors.white,
          //       //   borderRadius: BorderRadius.circular(8),
          //         // boxShadow: [
          //         //   BoxShadow(
          //         //     color: Colors.black12,
          //         //     blurRadius: 20.0,
          //         //   ),
          //         // ],
          //     //  ),
          //       // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          //       child: Padding(
          //         padding: const EdgeInsets.fromLTRB(18,8,18,8),
          //
          //         child: Text('$score2', style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black87
          //           // fontFamily: 'poppins'
          //         ),),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
