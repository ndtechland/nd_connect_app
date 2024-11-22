import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:intl/intl.dart';
import 'package:nd_connect_techland/controllers/attendance_controller.dart';
import 'package:nd_connect_techland/controllers/location_controller.dart';
import 'package:nd_connect_techland/controllers/total_attendance_controller.dart';
import 'package:nd_connect_techland/controllers/total_leaves_date_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/profile_employee.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/side_drower.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/support_comman_page.dart';
import 'package:nd_connect_techland/modules/all_pages/total_attendance/total_attendance.dart';
import 'package:path/path.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/salary_slip_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shake/shake.dart';
import '../../../../components/responsive_text.dart';
import '../../../../constants/app_colorss/app_colorss.dart';
import '../../../../constants/reusable_customdilog.dart';
import '../../../../constants/static_text.dart';
import '../../../../controllers/current_month_controller.dart';
import '../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/apply_leave_controller/apply_controllerss.dart';
import '../../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../../../controllers/employeee_controllersss/employee_edit_profile_controller/employee_update_personal_controller.dart';
import '../../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../../../controllers/employeee_controllersss/employee_offer_appointment/offer_apt_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/payment_get_controller/payment_get_controller.dart';
import '../../../../controllers/employeee_controllersss/salary_slip_controller/salary_slip_controllerss.dart';
import '../../../../controllers/employeee_controllersss/support_comman/support_commannn.dart';
import '../../../../controllers/employeee_controllersss/timer_controller.dart';
import '../../../../controllers/user_profile_controller/user_profile_controller.dart';
import '../../../../widget/custom_loader.dart';
import '../../leave_left/leave_left.dart';
import '../../total_attendance/current_month_attendance.dart';
import '../../total_leaves/total_leaves.dart';
import '../testtt.dart';
import '../view_pdf_only.dart';
import '../willPop_scope_exit.dart';
import 'leaves_employee/multiple_day.dart';
import 'leaves_employee/single_day.dart';

HomedashboardController _homedashboardController =
Get.put(HomedashboardController());

SupportEmployeeController _supportEmployeeController =
Get.put(SupportEmployeeController());

class HomeEmployee2 extends StatefulWidget {
  static const String id = 'Categories';


   HomeEmployee2({super.key});

  @override
  State<HomeEmployee2> createState() => _HomeEmployee2State();
}

class _HomeEmployee2State extends State<HomeEmployee2> {
  final RxBool isLoading = false.obs;

  final List<String> image = [
    "lib/assets/images/c11.png",
    "lib/assets/images/c5.png",
    "lib/assets/images/c77.png",
    "lib/assets/images/c44.png",
    "lib/assets/images/c33.png",
    "lib/assets/images/c88.png",
  ];

  final List<String> name = [
    'Total Leaves',
    'Total Attendance',
    'Profile',
    'Leave Left',
    'Current Month Attendance',
    'Support',
  ];

  final List<Color> containerColors = [
    Color(0xffee6c4d),
    Colors.cyan,
    Colors.green,
    Colors.blue.shade700,
    Colors.purple,
    Colors.cyan,
  ];

  AptOfferEmployeeController _aptOfferEmployeeController = Get.put(AptOfferEmployeeController());

  ProfileEmployeeController _profileEmployeeController = Get.put(ProfileEmployeeController());

  final LeaveApplyController _leaveApplyController = Get.put(LeaveApplyController());

  AllSalarySlipController _allsalaryslipController = Get.put(AllSalarySlipController());

  SupportEmployeeController _supportEmployeeController = Get.put(SupportEmployeeController());

  final EmployeeUpdatePersonalController _employeeUpdatePersonalController = Get.put(EmployeeUpdatePersonalController());

  final LocationController locationController = Get.put(LocationController());

  final snackBarDuration = Duration(seconds: 3);
 // Define your desired duration
  final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());

  final DateTimeController dateTimeController = Get.put(DateTimeController());

  final AttendanceController attendanceController = Get.put(AttendanceController());

  final CurrentMonthController currentMonthController = Get.put(CurrentMonthController());

  final TotalLeavesDateController totalLeavesDateController = Get.put(TotalLeavesDateController());

  final TotalAttendanceController attTotalController = Get.put(TotalAttendanceController());
int shakeCount=0;
  @override
  void initState(){
    print("shakeee init");
    attendanceController.AttendanceDetailApi(DateTime.now());

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          shakeCount++;
          print("shakeee");
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
              const SnackBar(
                content: Text('Shake!'),
              ));
        });
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    detector.startListening();
    super.initState();

  }
  // final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    ShakeDetector.autoStart(
      onPhoneShake: () {
        setState(() {
          shakeCount++;
          print("shakeee");
          // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          //     const SnackBar(
          //       content: Text('Shake!'),
          //     ));
        });
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    String imageUrl =
    // "${FixedText.apiurl2}$
        "${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile}";
    print("imageUrl");
    print(imageUrl);
    print("attendanceStatus:${attendanceController.attendanceDetailsModel?.data?.loginStatus}");
    Size size = MediaQuery.of(context).size;
    // print("status color: ${locationController.statusColor.value}");
    return
       WillPopScope(
         onWillPop: () => showExitPopup(context),
         child: Scaffold(
            drawer: Drawer(backgroundColor: Colors.white,child: EmployeeNavBar(),),
            appBar: AppBar(
              backgroundColor: appColor2,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("ND Connect",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
              centerTitle: true,
              actions: [
              // Obx(()=>
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
                //)
              ],
              //backgroundColor: appColor2,
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 18.0),
              //     child: Container(
              //       child: CircleAvatar(
              //         radius: 24,
              //         backgroundColor: Colors.white,
              //         child:  ClipOval(
              //           child: GestureDetector(
              //             onTap: () async {
              //               await _profileEmployeeController.profileemployeeApi();
              //               // await _profileEmployeeController.profileBasicemployeeApi();
              //               // await _profileEmployeeController.profileEmployeBankApi();
              //
              //               //profileBasicemployeeApi();
              //               //     profileEmployeBankApi();
              //
              //               //_profileEmployeeController.update();
              //
              //               // await _profileController.profileApi();
              //               // _profileController.update();
              //               await Navigator.push(context,
              //                   MaterialPageRoute(builder: (context) => EmployeeProfile()));
              //             },
              //             child: responsiveContainer(
              //               // padding: const EdgeInsets.only(right: 0),
              //               //height: 20,
              //               //width: 20,
              //               heightPortrait: MediaQuery.of(context).size.height * 0.12,
              //               widthPortrait: MediaQuery.of(context).size.width * 0.25,
              //               heightLandscape: MediaQuery.of(context).size.height * 0.3,
              //               widthLandscape: MediaQuery.of(context).size.width * 0.2,
              //               // height: MediaQuery.of(context).size.height *
              //               //     0.05, // 20% of screen height if not provided
              //               // width: MediaQuery.of(context).size.width * 0.09,
              //               //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
              //               child: _getprofileepersonal
              //                   .getprofileemployeeModel?.data?.empProfile !=
              //                   null
              //                   ? Image.network(
              //                 //"${FixedText.apiurl2}"
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
              //                   : Image.network(
              //                 'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
              //                 fit: BoxFit.fill,
              //               ),
              //               context: context,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ],
            ),
          backgroundColor: Colors.white,
          body:
          OrientationBuilder(builder: (context, orientation) {
          return LayoutBuilder(builder: (context, constraints) {
            var screenWidth = constraints.maxWidth;
            var screenHeight = constraints.maxHeight;

            var imageWidth = orientation == Orientation.portrait
                ? screenWidth * 0.55
                : screenWidth * 0.25;
            var imageHeight = orientation == Orientation.portrait
                ? screenHeight * 0.2
                : screenHeight * 0.5;

            var imageWidth2 = orientation == Orientation.portrait
                ? screenWidth * 0.55
                : screenWidth * 0.19;
            var imageHeight2 = orientation == Orientation.portrait
                ? screenHeight * 0.32
                : screenHeight * 0.5;

            var categoryWidth = orientation == Orientation.portrait
                ? screenWidth * 0.5
                : screenWidth * 0.53;
            var categoryHeight = orientation == Orientation.portrait
                ? screenHeight * 0.42
                : screenHeight * 0.9;
            return Obx(()=> SafeArea(
              child: RefreshIndicator(
                // color: Colors.white,
                // backgroundColor: Colors.blue,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2));
                 await attendanceController.AttendanceDetailApi(DateTime.now());
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _header(context),
                        // Padding(
                        //   padding: const EdgeInsets.only(left:18.0,top:10.0,right:18.0,bottom: 10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       SizedBox(
                        //           width: 80,
                        //           child: GestureDetector(
                        //             onTap: ()async{
                        //               Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);
                        //
                        //              // await _allsalaryslipController.openDocument(_allsalaryslipController.allSalarySlipModel?.data?.salarySlipName);
                        //               await _allsalaryslipController.fetchSalarySlips();
                        //               _allsalaryslipController.onInit();
                        //               Get.back();
                        //               await Navigator.push(context,
                        //                   MaterialPageRoute(builder: (context) => AllSalarySlip()));
                        //             },
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   width: 60, // Adjust the size of the circle
                        //                   height: 60,
                        //                   decoration: BoxDecoration(
                        //                     shape: BoxShape.circle,
                        //                     gradient: LinearGradient(
                        //                       begin: Alignment.topLeft,
                        //                       end: Alignment.bottomRight,
                        //                       colors: [
                        //                         appColor2.withOpacity(0.8), // Light color on top left
                        //                         appColorr2,
                        //                         // Colors.grey.shade300, // Light color on top left
                        //                         // Colors.grey.shade300, // Dark color on bottom right
                        //                       ],
                        //                       stops: [0.2, 1],
                        //                     ),
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: Colors.grey.shade500,
                        //                         offset: Offset(2, 2),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                       BoxShadow(
                        //                         color: Colors.white,
                        //                         offset: Offset(-4, -4),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   child: Center(
                        //                       child: Icon(Icons.receipt_long_rounded,
                        //                         color: Colors.white,)
                        //                     // ClipOval(
                        //                     //   child: responsiveContainer(
                        //                     //     context: context,
                        //                     //     heightPortrait: MediaQuery.of(context).size.height * 0.12,
                        //                     //     widthPortrait: MediaQuery.of(context).size.width * 0.25,
                        //                     //     heightLandscape: MediaQuery.of(context).size.height * 0.3,
                        //                     //     widthLandscape: MediaQuery.of(context).size.width * 0.2,
                        //                     //   ),
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 6,),
                        //                 Text("Salary Slip",
                        //                   style: GoogleFonts.lato(
                        //                       textStyle: TextStyle(
                        //                           fontSize: 12,
                        //                           overflow: TextOverflow.visible
                        //                       )
                        //                   ),)
                        //               ],
                        //             ),
                        //           )
                        //           //circleIcon(context,Icons.receipt_long_rounded,"Salary Slip")
                        //       ),
                        //       SizedBox(
                        //         width: 80,
                        //           child: GestureDetector(
                        //             onTap:  () async {
                        //               Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);
                        //
                        //               await _aptOfferEmployeeController.ampofferemployeeApi();
                        //               _aptOfferEmployeeController.update();
                        //               //   await Future.delayed(Duration(seconds: 2));
                        //               Get.back();
                        //               if (_aptOfferEmployeeController.aptLetter.isNotEmpty) {
                        //                 await _aptOfferEmployeeController.openDocument(_aptOfferEmployeeController.aptLetter.value);
                        //               } else {
                        //                 // Handle the case where `aptLetter` is empty
                        //                 Get.snackbar("Error", "No document found to open.");
                        //               }
                        //               // final String? url =
                        //               //     "https://admin.hirejobindia.com//OfferLetter/6905205d-23cf-46a7-bc12-d708f46ad51120240413162904075.pdf";
                        //               //
                        //
                        //               // if (url != null) {
                        //               //   showDialog(
                        //               //     context: context,
                        //               //     barrierDismissible:
                        //               //     false, // Prevent dismissing dialog by tapping outside
                        //               //     builder: (BuildContext context) {
                        //               //       return AlertDialog(
                        //               //         content: Column(
                        //               //           mainAxisSize: MainAxisSize.min,
                        //               //           children: [
                        //               //             CircularProgressIndicator(), // Circular loader
                        //               //             SizedBox(height: 10),
                        //               //             Text(
                        //               //                 'Loading Apt latter....'), // Text indicating download process
                        //               //           ],
                        //               //         ),
                        //               //       );
                        //               //     },
                        //               //   );
                        //               //
                        //               //   try {
                        //               //     // Load the PDF file from the network
                        //               //     final file = await loadPdfFromNetwork(url);
                        //               //     Navigator.pop(context); // Close the loading dialog
                        //               //
                        //               //     if (file != null) {
                        //               //       // Open the PDF viewer page
                        //               //       openPdf(context, file, url);
                        //               //     } else {
                        //               //       // Handle error if file loading failed
                        //               //       showDialog(
                        //               //         context: context,
                        //               //         builder: (context) => AlertDialog(
                        //               //           title: Text('Error'),
                        //               //           content: Text('Failed to load PDF file.'),
                        //               //           actions: [
                        //               //             TextButton(
                        //               //               onPressed: () => Navigator.pop(context),
                        //               //               child: Text('OK'),
                        //               //             ),
                        //               //           ],
                        //               //         ),
                        //               //       );
                        //               //     }
                        //               //   } catch (e) {
                        //               //     print('Error downloading PDF: $e');
                        //               //     Navigator.pop(context); // Close the loading dialog
                        //               //     // Handle error if downloading fails
                        //               //     showDialog(
                        //               //       context: context,
                        //               //       builder: (context) => AlertDialog(
                        //               //         title: Text('Error'),
                        //               //         content: Text('Failed to download PDF file.'),
                        //               //         actions: [
                        //               //           TextButton(
                        //               //             onPressed: () => Navigator.pop(context),
                        //               //             child: Text('OK'),
                        //               //           ),
                        //               //         ],
                        //               //       ),
                        //               //     );
                        //               //   }
                        //               // } else {
                        //               //   // Handle error if URL is null
                        //               //   showDialog(
                        //               //     context: context,
                        //               //     builder: (context) => AlertDialog(
                        //               //       title: Text('Error'),
                        //               //       content: Text('URL is null.'),
                        //               //       actions: [
                        //               //         TextButton(
                        //               //           onPressed: () => Navigator.pop(context),
                        //               //           child: Text('OK'),
                        //               //         ),
                        //               //       ],
                        //               //     ),
                        //               //   );
                        //               //   Get.back();
                        //               // }
                        //
                        //               // Navigator.push(context,
                        //               //     MaterialPageRoute(builder: (context) => Company()));
                        //             },
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   width: 60, // Adjust the size of the circle
                        //                   height: 60,
                        //                   decoration: BoxDecoration(
                        //                     shape: BoxShape.circle,
                        //                     gradient: LinearGradient(
                        //                       begin: Alignment.topLeft,
                        //                       end: Alignment.bottomRight,
                        //                       colors: [
                        //                         appColor2.withOpacity(0.8), // Light color on top left
                        //                         appColorr2,
                        //                         // Colors.grey.shade300, // Light color on top left
                        //                         // Colors.grey.shade300, // Dark color on bottom right
                        //                       ],
                        //                       stops: [0.2, 1],
                        //                     ),
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: Colors.grey.shade500,
                        //                         offset: Offset(2, 2),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                       BoxShadow(
                        //                         color: Colors.white,
                        //                         offset: Offset(-4, -4),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   child: Center(
                        //                       child: Icon(Icons.document_scanner_sharp,
                        //                         color: Colors.white,)
                        //                     // ClipOval(
                        //                     //   child: responsiveContainer(
                        //                     //     context: context,
                        //                     //     heightPortrait: MediaQuery.of(context).size.height * 0.12,
                        //                     //     widthPortrait: MediaQuery.of(context).size.width * 0.25,
                        //                     //     heightLandscape: MediaQuery.of(context).size.height * 0.3,
                        //                     //     widthLandscape: MediaQuery.of(context).size.width * 0.2,
                        //                     //   ),
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 6,),
                        //                 Text("Apt Letter",
                        //                   style: GoogleFonts.lato(
                        //                       textStyle: TextStyle(
                        //                           fontSize: 12,
                        //                           overflow: TextOverflow.visible
                        //                       )
                        //                   ),)
                        //               ],
                        //             ),
                        //           )
                        //           //circleIcon(context,Icons.document_scanner_sharp,"Apt Letter")
                        //       ),
                        //       SizedBox(
                        //           width: 80,
                        //           child:GestureDetector(
                        //             onTap: (){
                        //
                        //               showdilogleave(context);
                        //
                        //             },
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   width: 60, // Adjust the size of the circle
                        //                   height: 60,
                        //                   decoration: BoxDecoration(
                        //                     shape: BoxShape.circle,
                        //                     gradient: LinearGradient(
                        //                       begin: Alignment.topLeft,
                        //                       end: Alignment.bottomRight,
                        //                       colors: [
                        //                         appColor2.withOpacity(0.8), // Light color on top left
                        //                         appColorr2,
                        //                         // Colors.grey.shade300, // Light color on top left
                        //                         // Colors.grey.shade300, // Dark color on bottom right
                        //                       ],
                        //                       stops: [0.2, 1],
                        //                     ),
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: Colors.grey.shade500,
                        //                         offset: Offset(2, 2),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                       BoxShadow(
                        //                         color: Colors.white,
                        //                         offset: Offset(-4, -4),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   child: Center(
                        //                       child: Icon(Icons.group_off,
                        //                         color: Colors.white,)
                        //                     // ClipOval(
                        //                     //   child: responsiveContainer(
                        //                     //     context: context,
                        //                     //     heightPortrait: MediaQuery.of(context).size.height * 0.12,
                        //                     //     widthPortrait: MediaQuery.of(context).size.width * 0.25,
                        //                     //     heightLandscape: MediaQuery.of(context).size.height * 0.3,
                        //                     //     widthLandscape: MediaQuery.of(context).size.width * 0.2,
                        //                     //   ),
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 6,),
                        //                 Text("Apply Leaves",
                        //                   style: GoogleFonts.lato(
                        //                       textStyle: TextStyle(
                        //                           fontSize: 12,
                        //                           overflow: TextOverflow.visible
                        //                       )
                        //                   ),)
                        //               ],
                        //             ),
                        //           )
                        //          // circleIcon(context,Icons.group_off,"Apply Leaves")
                        //       ),
                        //       SizedBox(
                        //           width: 80,
                        //           child:GestureDetector(
                        //             onTap:() async {
                        //               Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);
                        //
                        //               await _aptOfferEmployeeController.ampofferemployeeApi();
                        //               _aptOfferEmployeeController.update();
                        //               Get.back();
                        //               if (_aptOfferEmployeeController.offLetter.isNotEmpty) {
                        //                 await _aptOfferEmployeeController.openDocument(_aptOfferEmployeeController.offLetter.value);
                        //               } else {
                        //                 // Handle the case where `aptLetter` is empty
                        //                 Get.snackbar("Error", "No document found to open.");
                        //               }
                        //               // Get the URL of the PDF file from the profile information
                        //               // String url =
                        //               //     "${FixedText.offaptpdfurl}${_aptOfferEmployeeController.getampofferModel?.data?.offerletter?.toString()}";
                        //               // print("url");
                        //               // print(url);
                        //               // // final String? url =
                        //               // //     "https://admin.hirejobindia.com//OfferLetter/6905205d-23cf-46a7-bc12-d708f46ad51120240413162904075.pdf";
                        //               // //
                        //               //
                        //               // if (url != null) {
                        //               //   showDialog(
                        //               //     context: context,
                        //               //     barrierDismissible:
                        //               //     false, // Prevent dismissing dialog by tapping outside
                        //               //     builder: (BuildContext context) {
                        //               //       return AlertDialog(
                        //               //         content: Column(
                        //               //           mainAxisSize: MainAxisSize.min,
                        //               //           children: [
                        //               //             CircularProgressIndicator(), // Circular loader
                        //               //             SizedBox(height: 10),
                        //               //             Text(
                        //               //                 'Loading Offer Latter....'), // Text indicating download process
                        //               //           ],
                        //               //         ),
                        //               //       );
                        //               //     },
                        //               //   );
                        //               //
                        //               //   try {
                        //               //     // Load the PDF file from the network
                        //               //     final file = await loadPdfFromNetwork(url);
                        //               //     Navigator.pop(context); // Close the loading dialog
                        //               //
                        //               //     if (file != null) {
                        //               //       // Open the PDF viewer page
                        //               //       openPdf(context, file, url);
                        //               //     } else {
                        //               //       // Handle error if file loading failed
                        //               //       showDialog(
                        //               //         context: context,
                        //               //         builder: (context) => AlertDialog(
                        //               //           title: Text('Error'),
                        //               //           content: Text('Failed to load PDF file.'),
                        //               //           actions: [
                        //               //             TextButton(
                        //               //               onPressed: () => Navigator.pop(context),
                        //               //               child: Text('OK'),
                        //               //             ),
                        //               //           ],
                        //               //         ),
                        //               //       );
                        //               //     }
                        //               //   } catch (e) {
                        //               //     print('Error downloading PDF: $e');
                        //               //     Navigator.pop(context); // Close the loading dialog
                        //               //     // Handle error if downloading fails
                        //               //     showDialog(
                        //               //       context: context,
                        //               //       builder: (context) => AlertDialog(
                        //               //         title: Text('Error'),
                        //               //         content: Text('Failed to download PDF file.'),
                        //               //         actions: [
                        //               //           TextButton(
                        //               //             onPressed: () => Navigator.pop(context),
                        //               //             child: Text('OK'),
                        //               //           ),
                        //               //         ],
                        //               //       ),
                        //               //     );
                        //               //   }
                        //               // } else {
                        //               //   // Handle error if URL is null
                        //               //   showDialog(
                        //               //     context: context,
                        //               //     builder: (context) => AlertDialog(
                        //               //       title: Text('Error'),
                        //               //       content: Text('URL is null.'),
                        //               //       actions: [
                        //               //         TextButton(
                        //               //           onPressed: () => Navigator.pop(context),
                        //               //           child: Text('OK'),
                        //               //         ),
                        //               //       ],
                        //               //     ),
                        //               //   );
                        //               //   Get.back();
                        //               // }
                        //
                        //               //Get.back();
                        //
                        //               // Navigator.push(context,
                        //               //     MaterialPageRoute(builder: (context) => Company()));
                        //             },
                        //             child: Column(
                        //               children: [
                        //                 Container(
                        //                   width: 60, // Adjust the size of the circle
                        //                   height: 60,
                        //                   decoration: BoxDecoration(
                        //                     shape: BoxShape.circle,
                        //                     gradient: LinearGradient(
                        //                       begin: Alignment.topLeft,
                        //                       end: Alignment.bottomRight,
                        //                       colors: [
                        //                         appColor2.withOpacity(0.8), // Light color on top left
                        //                         appColorr2,
                        //                         // Colors.grey.shade300, // Light color on top left
                        //                         // Colors.grey.shade300, // Dark color on bottom right
                        //                       ],
                        //                       stops: [0.2, 1],
                        //                     ),
                        //                     boxShadow: [
                        //                       BoxShadow(
                        //                         color: Colors.grey.shade500,
                        //                         offset: Offset(2, 2),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                       BoxShadow(
                        //                         color: Colors.white,
                        //                         offset: Offset(-4, -4),
                        //                         blurRadius: 8,
                        //                         spreadRadius: 1,
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   child: Center(
                        //                       child: Icon(Icons.add_chart_outlined,
                        //                         color: Colors.white,)
                        //                     // ClipOval(
                        //                     //   child: responsiveContainer(
                        //                     //     context: context,
                        //                     //     heightPortrait: MediaQuery.of(context).size.height * 0.12,
                        //                     //     widthPortrait: MediaQuery.of(context).size.width * 0.25,
                        //                     //     heightLandscape: MediaQuery.of(context).size.height * 0.3,
                        //                     //     widthLandscape: MediaQuery.of(context).size.width * 0.2,
                        //                     //   ),
                        //                   ),
                        //                 ),
                        //                 SizedBox(height: 6,),
                        //                 Text("Offer Letter",
                        //                   style: GoogleFonts.lato(
                        //                       textStyle: TextStyle(
                        //                           fontSize: 12,
                        //                           overflow: TextOverflow.visible
                        //                       )
                        //                   ),)
                        //               ],
                        //             ),
                        //           )
                        //           //circleIcon(context,Icons.add_chart_outlined,"Offer Letter")
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Padding(padding: EdgeInsets.only(left: 18.0,right: 18.0,top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [

                                // GestureDetector(
                                //   onTap:(){
                                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalLeaves()));
                                //   },
                                //   child: Container(
                                //     height: categoryHeight*0.6,
                                //     width: categoryWidth*0.85,
                                //     decoration: BoxDecoration(
                                //       color: appColor2.withOpacity(0.9),
                                //       //  containerColors[3 % containerColors.length],
                                //       boxShadow: [
                                //         BoxShadow(
                                //           offset: Offset(0, 0),
                                //           blurRadius: 1,
                                //           color: Color.fromRGBO(0, 0, 0, 0.16),
                                //         )
                                //       ],
                                //       borderRadius:
                                //       BorderRadius.all(Radius.circular(15)),
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(12.0),
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //
                                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //         children: [
                                //           SizedBox(height: 4,),
                                //           Container(
                                //             height: categoryHeight*0.17,
                                //             width: categoryWidth*0.25,
                                //             decoration: BoxDecoration(
                                //               color: Colors.white,
                                //               borderRadius: BorderRadius.circular(10)
                                //             ),
                                //             padding: EdgeInsets.all(6),
                                //             child: image[0] != null
                                //                 ? Image.asset(
                                //               image[0], fit: BoxFit.cover,
                                //               //color: Colors.white,
                                //               // imageColors[
                                //               //     index % imageColors.length],
                                //               // fit: BoxFit.fill,
                                //               errorBuilder:
                                //                   (context, error, stackTrace) {
                                //                 return Image.asset(
                                //                   'lib/assets/logo/noimageavlble.jpg',
                                //                   fit: BoxFit.cover,
                                //                 );
                                //               },
                                //             )
                                //                 : Image.network(
                                //               'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                //               fit: BoxFit.fill,
                                //             ),
                                //           ),
                                //           Text("Total Leaves",style: GoogleFonts.poppins(
                                //               textStyle: TextStyle(
                                //                   fontSize: 15,
                                //                   color: Colors.white,fontWeight: FontWeight.w600
                                //               )
                                //           ),),
                                //
                                //           responsiveText(
                                //             context: context,
                                //             text:
                                //             //_homedashboardController.dashboardResponse?.data?.leave==null?"34":
                                //             ("${_homedashboardController.dashboardResponse?.data?.leave}"),
                                //             fontSizePortrait: 18,
                                //             fontSizeLandscape: 18,
                                //             color: Colors.white,
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                GestureDetector(
                                  onTap:()async{
                                    await totalLeavesDateController.TotalLeaveApi();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalLeaves()));
                                  },
                                  child: Container(
                                    height: categoryHeight*0.6,
                                    width: categoryWidth*0.85,
                                    decoration: BoxDecoration(
                                      color: appColor2.withOpacity(0.9),
                                      //  containerColors[3 % containerColors.length],
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Leaves",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,fontWeight: FontWeight.w600
                                              )
                                          ),),
                                            Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              responsiveText(
                                                context: context,
                                                text:
                                                (
                                                    _homedashboardController.dashboardResponse?.data?.leave==null?"0":
                                                    "${_homedashboardController.dashboardResponse?.data?.leave}"
                                                ),
                                                fontSizePortrait: 18,
                                                fontSizeLandscape: 18,
                                                color: Colors.white,
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.white,
                                                  child:  image[0] != null
                                                      ? Image.asset(
                                                    image[0], fit: BoxFit.cover,
                                                    //color: Colors.white,
                                                    // imageColors[
                                                    //     index % imageColors.length],
                                                    // fit: BoxFit.fill,
                                                    errorBuilder:
                                                        (context, error, stackTrace) {
                                                      return Image.asset(
                                                        'lib/assets/logo/noimageavlble.jpg',
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                      : Image.network(
                                                    'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: ()async{
                                    await attTotalController.AttendanceGraphApi();
                                    await attTotalController.AttendanceGraphApi1();
                                    Get.to(()=>TotalAtendance());
                                  },
                                  child: Container(
                                    height: categoryHeight*0.6,
                                    width: categoryWidth*0.85,
                                    decoration: BoxDecoration(
                                      color: appColor2.withOpacity(0.9),
                                      //  containerColors[3 % containerColors.length],
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Attendance",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,fontWeight: FontWeight.w600
                                              )
                                          ),),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              responsiveText(
                                                context: context,
                                                text:
                                                (
                                                    _homedashboardController.dashboardResponse?.data?.totalAttendance==null?"0":
                                                    "${_homedashboardController.dashboardResponse?.data?.totalAttendance}"
                                                ),
                                                fontSizePortrait: 18,
                                                fontSizeLandscape: 18,
                                                color: Colors.white,
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.white,
                                                  child:  image[1] != null
                                                      ? Image.asset(
                                                    image[1], fit: BoxFit.cover,
                                                    //color: Colors.white,
                                                    // imageColors[
                                                    //     index % imageColors.length],
                                                    // fit: BoxFit.fill,
                                                    errorBuilder:
                                                        (context, error, stackTrace) {
                                                      return Image.asset(
                                                        'lib/assets/logo/noimageavlble.jpg',
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                      : Image.network(
                                                    'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: ()async{
                                   await _allsalaryslipController.fetchSalarySlips();
                                   _allsalaryslipController.onInit();
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => AllSalarySlip()));
                                  },
                                  child: Container(
                                    height: categoryHeight*0.6,
                                    width: categoryWidth*0.85,
                                    decoration: BoxDecoration(
                                      color: appColor2.withOpacity(0.9),
                                      //  containerColors[3 % containerColors.length],
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Salary Slip",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,fontWeight: FontWeight.w600
                                              )
                                          ),),

                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.white,
                                              child:  image[2] != null
                                                  ? Image.asset(
                                                image[2], fit: BoxFit.cover,
                                                //color: Colors.white,
                                                // imageColors[
                                                //     index % imageColors.length],
                                                // fit: BoxFit.fill,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'lib/assets/logo/noimageavlble.jpg',
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                                  : Image.network(
                                                'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          //  SizedBox(width: 14,),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async{
                                    await _leaveApplyController.getCatLeavecatApi();
                                    Get.to(()=>LeaveLeft());
                                  },
                                  child: Container(
                                    height: categoryHeight*0.6,
                                    width: categoryWidth*0.85,
                                    decoration: BoxDecoration(
                                      color: appColor2.withOpacity(0.9),
                                      //  containerColors[3 % containerColors.length],
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Leave Left",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,fontWeight: FontWeight.w600
                                              )
                                          ),),

                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                responsiveText(
                                                  context: context,
                                                  text:
                                                  (
                                                      _homedashboardController.dashboardResponse?.data?.leaveLeft==null?"0/0":
                                                      "${_homedashboardController.dashboardResponse?.data?.leaveLeft}"
                                                  ),
                                                  fontSizePortrait: 18,
                                                  fontSizeLandscape: 18,
                                                  color: Colors.white,
                                                ),
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.white,
                                                  child:  image[3] != null
                                                      ? Image.asset(
                                                    image[3], fit: BoxFit.cover,
                                                    //color: Colors.white,
                                                    // imageColors[
                                                    //     index % imageColors.length],
                                                    // fit: BoxFit.fill,
                                                    errorBuilder:
                                                        (context, error, stackTrace) {
                                                      return Image.asset(
                                                        'lib/assets/logo/noimageavlble.jpg',
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                      : Image.network(
                                                    'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: ()async{
                                    await currentMonthController.AttendanceCurrentApi();
                                    Get.to(()=>CurrentMonthAttendance());
                                    },
                                  child: Container(
                                    height: categoryHeight*0.6,
                                    width: categoryWidth*0.85,
                                    decoration: BoxDecoration(
                                      color: appColor2.withOpacity(0.9),
                                      //  containerColors[3 % containerColors.length],
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Current Month Attendance",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,fontWeight: FontWeight.w600
                                              )
                                          ),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              responsiveText(
                                                context: context,
                                                text:
                                                (
                                                    _homedashboardController.dashboardResponse?.data?.attendance==null?"0":
                                                    "${_homedashboardController.dashboardResponse?.data?.attendance}"
                                                ),
                                                fontSizePortrait: 16,
                                                fontSizeLandscape: 16,
                                                color: Colors.white,
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.white,
                                                  child:  image[4] != null
                                                      ? Image.asset(
                                                    image[4], fit: BoxFit.cover,
                                                    //color: Colors.white,
                                                    // imageColors[
                                                    //     index % imageColors.length],
                                                    // fit: BoxFit.fill,
                                                    errorBuilder:
                                                        (context, error, stackTrace) {
                                                      return Image.asset(
                                                        'lib/assets/logo/noimageavlble.jpg',
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  )
                                                      : Image.network(
                                                    'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    showdilogleave(context);
                                  },
                                  child: Container(
                                    height: categoryHeight*0.6,
                                    width: categoryWidth*0.85,
                                    decoration: BoxDecoration(
                                      color: appColor2.withOpacity(0.9),
                                      //  containerColors[3 % containerColors.length],
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          color: Color.fromRGBO(0, 0, 0, 0.16),
                                        )
                                      ],
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Apply Leaves",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,fontWeight: FontWeight.w600
                                              )
                                          ),),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.white,
                                              child:  image[5] != null
                                                  ? Image.asset(
                                                image[5], fit: BoxFit.cover,
                                                //color: Colors.white,
                                                // imageColors[
                                                //     index % imageColors.length],
                                                // fit: BoxFit.fill,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'lib/assets/logo/noimageavlble.jpg',
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                                  : Image.network(
                                                'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Expanded(
                            //   flex: 1,
                            //   child: Column(
                            //     children: [
                            //       // Container(
                            //       //   decoration: BoxDecoration(
                            //       //     color:
                            //       //     containerColors[1 % containerColors.length],
                            //       //     boxShadow: [
                            //       //       BoxShadow(
                            //       //         offset: Offset(0, 0),
                            //       //         blurRadius: 1,
                            //       //         color: Color.fromRGBO(0, 0, 0, 0.16),
                            //       //       )
                            //       //     ],
                            //       //     borderRadius:
                            //       //     BorderRadius.all(Radius.circular(15)),
                            //       //   ),
                            //       //   child: Column(
                            //       //     mainAxisAlignment: MainAxisAlignment.start,
                            //       //     children: [
                            //       //       Container(
                            //       //         height: imageHeight * 0.5,
                            //       //         width: categoryWidth * 0.34,
                            //       //         child: image[1] != null
                            //       //             ? Image.asset(
                            //       //           image[1], fit: BoxFit.cover,
                            //       //           // color: imageColors[
                            //       //           //     index % imageColors.length],
                            //       //           // fit: BoxFit.fill,
                            //       //           errorBuilder:
                            //       //               (context, error, stackTrace) {
                            //       //             return Image.asset(
                            //       //               'lib/assets/logo/noimageavlble.jpg',
                            //       //               fit: BoxFit.cover,
                            //       //             );
                            //       //           },
                            //       //         )
                            //       //             : Image.network(
                            //       //           'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //       //           fit: BoxFit.fill,
                            //       //         ),
                            //       //       ),
                            //       //       Container(
                            //       //         height: imageHeight2 * 0.1,
                            //       //         width: categoryWidth * 0.6,
                            //       //         color: Colors.pink,
                            //       //         // decoration: BoxDecoration(
                            //       //         //   color: Colors.white,
                            //       //         //   borderRadius: BorderRadius.only(
                            //       //         //     topRight: Radius.circular(100),
                            //       //         //   ),
                            //       //         // ),
                            //       //         child: Center(
                            //       //           child: responsiveText(
                            //       //             context: context,
                            //       //             text:
                            //       //             ("${_homedashboardController.dashboardResponse?.data?.totalAttendance}"),
                            //       //             fontSizePortrait: 19,
                            //       //             fontSizeLandscape: 19,
                            //       //             color: Colors.white
                            //       //             // containerColors[
                            //       //             // 1 % containerColors.length],
                            //       //           ),
                            //       //         ),
                            //       //       ),
                            //       //       responsiveText(
                            //       //         context: context,
                            //       //         text: (name[1]),
                            //       //         fontSizePortrait: 16,
                            //       //         fontSizeLandscape: 14,
                            //       //         color: Colors.white,
                            //       //       ),
                            //       //     ],
                            //       //   ),
                            //       // ),
                            //       Expanded(
                            //         child: Container(
                            //             margin: EdgeInsets.all(8),
                            //             child: GestureDetector(
                            //               onTap: () {
                            //                 //Navigator.push(
                            //                 // context,
                            //                 // MaterialPageRoute(
                            //                 //   builder: (context) => const CompanyDetail(),
                            //                 // ),
                            //                 //);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                   color:
                            //                   containerColors[0 % containerColors.length],
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       offset: Offset(0, 0),
                            //                       blurRadius: 1,
                            //                       color: Color.fromRGBO(0, 0, 0, 0.16),
                            //                     )
                            //                   ],
                            //                   borderRadius:
                            //                   BorderRadius.all(Radius.circular(15)),
                            //                 ),
                            //                 child: Stack(
                            //                   children: [
                            //                     Positioned(
                            //                       top: 1,
                            //                       right: imageWidth * 0.01,
                            //                       child: Container(
                            //                         height: imageHeight * 0.5,
                            //                         width: imageWidth * 0.34,
                            //                         child: image[0] != null
                            //                             ? Image.asset(
                            //                           image[0], fit: BoxFit.cover,
                            //                           //color: Colors.white,
                            //                           // imageColors[
                            //                           //     index % imageColors.length],
                            //                           // fit: BoxFit.fill,
                            //                           errorBuilder:
                            //                               (context, error, stackTrace) {
                            //                             return Image.asset(
                            //                               'lib/assets/logo/noimageavlble.jpg',
                            //                               fit: BoxFit.cover,
                            //                             );
                            //                           },
                            //                         )
                            //                             : Image.network(
                            //                           'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //                           fit: BoxFit.fill,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0,
                            //                       left: 0,
                            //                       right: 0,
                            //                       child: Column(
                            //                         //mainAxisAlignment: MainAxisAlignment.center,
                            //                         children: [
                            //                           responsiveText(
                            //                             context: context,
                            //                             text: (name[0]),
                            //                             fontSizePortrait: 16,
                            //                             fontSizeLandscape: 14,
                            //                             color: Colors.white,
                            //                           ),
                            //                           Align(
                            //                             alignment: Alignment.centerLeft,
                            //                             child: Container(
                            //                               height: imageHeight2 * 0.45,
                            //                               width: imageWidth2 * 0.6,
                            //                               decoration: BoxDecoration(
                            //                                 color: Colors.white,
                            //                                 borderRadius: BorderRadius.only(
                            //                                   topRight: Radius.circular(100),
                            //                                 ),
                            //                               ),
                            //                               child: Center(
                            //                                 child: responsiveText(
                            //                                   context: context,
                            //                                   text:
                            //                                   ("${_homedashboardController.dashboardResponse?.data?.leave}"),
                            //                                   fontSizePortrait: 19,
                            //                                   fontSizeLandscape: 19,
                            //                                   color: containerColors[
                            //                                   0 % containerColors.length],
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //             margin: const EdgeInsets.all(8),
                            //             child: GestureDetector(
                            //               onTap: () {
                            //                 //Navigator.push(
                            //                 // context,
                            //                 // MaterialPageRoute(
                            //                 //   builder: (context) => const CompanyDetail(),
                            //                 // ),
                            //                 //);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                   color:
                            //                   containerColors[1 % containerColors.length],
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       offset: Offset(0, 0),
                            //                       blurRadius: 1,
                            //                       color: Color.fromRGBO(0, 0, 0, 0.16),
                            //                     )
                            //                   ],
                            //                   borderRadius:
                            //                   BorderRadius.all(Radius.circular(15)),
                            //                 ),
                            //                 child: Stack(
                            //                   children: [
                            //                     Positioned(
                            //                       top: 1,
                            //                       right: imageWidth * 0.01,
                            //                       child: Container(
                            //                         height: imageHeight * 0.5,
                            //                         width: imageWidth * 0.34,
                            //                         child: image[1] != null
                            //                             ? Image.asset(
                            //                           image[1], fit: BoxFit.cover,
                            //                           // color: imageColors[
                            //                           //     index % imageColors.length],
                            //                           // fit: BoxFit.fill,
                            //                           errorBuilder:
                            //                               (context, error, stackTrace) {
                            //                             return Image.asset(
                            //                               'lib/assets/logo/noimageavlble.jpg',
                            //                               fit: BoxFit.cover,
                            //                             );
                            //                           },
                            //                         )
                            //                             : Image.network(
                            //                           'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //                           fit: BoxFit.fill,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0,
                            //                       left: 0,
                            //                       right: 0,
                            //                       child: Column(
                            //                         //mainAxisAlignment: MainAxisAlignment.center,
                            //                         children: [
                            //                           responsiveText(
                            //                             context: context,
                            //                             text: (name[1]),
                            //                             fontSizePortrait: 16,
                            //                             fontSizeLandscape: 14,
                            //                             color: Colors.white,
                            //                           ),
                            //                           Align(
                            //                             alignment: Alignment.centerLeft,
                            //                             child: Container(
                            //                               height: imageHeight2 * 0.45,
                            //                               width: imageWidth2 * 0.6,
                            //                               decoration: BoxDecoration(
                            //                                 color: Colors.white,
                            //                                 borderRadius: BorderRadius.only(
                            //                                   topRight: Radius.circular(100),
                            //                                 ),
                            //                               ),
                            //                               child: Center(
                            //                                 child: responsiveText(
                            //                                   context: context,
                            //                                   text:
                            //                                   ("${_homedashboardController.dashboardResponse?.data?.totalAttendance}"),
                            //                                   fontSizePortrait: 19,
                            //                                   fontSizeLandscape: 19,
                            //                                   color: containerColors[
                            //                                   1 % containerColors.length],
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //             margin: const EdgeInsets.all(8),
                            //             child: GestureDetector(
                            //               onTap: () {
                            //                 //Navigator.push(
                            //                 // context,
                            //                 // MaterialPageRoute(
                            //                 //   builder: (context) => const CompanyDetail(),
                            //                 // ),
                            //                 //);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                   color:
                            //                   containerColors[2 % containerColors.length],
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       offset: Offset(0, 0),
                            //                       blurRadius: 1,
                            //                       color: Color.fromRGBO(0, 0, 0, 0.16),
                            //                     )
                            //                   ],
                            //                   borderRadius:
                            //                   BorderRadius.all(Radius.circular(15)),
                            //                 ),
                            //                 child: Stack(
                            //                   children: [
                            //                     Positioned(
                            //                       top: 1,
                            //                       right: imageWidth * 0.01,
                            //                       child: Container(
                            //                         height: imageHeight * 0.5,
                            //                         width: imageWidth * 0.34,
                            //                         child: image[2] != null
                            //                             ? Image.asset(
                            //                           image[2], fit: BoxFit.cover,
                            //                           // color: imageColors[
                            //                           //     index % imageColors.length],
                            //                           // fit: BoxFit.fill,
                            //                           errorBuilder:
                            //                               (context, error, stackTrace) {
                            //                             return Image.asset(
                            //                               'lib/assets/logo/noimageavlble.jpg',
                            //                               fit: BoxFit.cover,
                            //                             );
                            //                           },
                            //                         )
                            //                             : Image.network(
                            //                           'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //                           fit: BoxFit.fill,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0,
                            //                       left: 0,
                            //                       right: 0,
                            //                       child: Column(
                            //                         //mainAxisAlignment: MainAxisAlignment.center,
                            //                         children: [
                            //                           responsiveText(
                            //                             context: context,
                            //                             text: (name[2]),
                            //                             fontSizePortrait: 16,
                            //                             fontSizeLandscape: 14,
                            //                             color: Colors.white,
                            //                           ),
                            //                           Align(
                            //                             alignment: Alignment.centerLeft,
                            //                             child: Container(
                            //                               height: imageHeight2 * 0.45,
                            //                               width: imageWidth2 * 0.6,
                            //                               decoration: BoxDecoration(
                            //                                 color: Colors.white,
                            //                                 borderRadius: BorderRadius.only(
                            //                                   topRight: Radius.circular(100),
                            //                                 ),
                            //                               ),
                            //                               child: Center(
                            //                                 child: responsiveText(
                            //                                   context: context,
                            //                                   text:
                            //                                   ("${_homedashboardController.dashboardResponse?.data?.completionPercentage}\nCompleted"),
                            //                                   fontSizePortrait: 19,
                            //                                   fontSizeLandscape: 19,
                            //                                   color: containerColors[
                            //                                   2 % containerColors.length],
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Expanded(
                            //   flex: 1,
                            //   child: Column(
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //             margin: const EdgeInsets.all(8),
                            //             child: GestureDetector(
                            //               onTap: () {
                            //                 //Navigator.push(
                            //                 // context,
                            //                 // MaterialPageRoute(
                            //                 //   builder: (context) => const CompanyDetail(),
                            //                 // ),
                            //                 //);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                   color:
                            //                   containerColors[3 % containerColors.length],
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       offset: Offset(0, 0),
                            //                       blurRadius: 1,
                            //                       color: Color.fromRGBO(0, 0, 0, 0.16),
                            //                     )
                            //                   ],
                            //                   borderRadius:
                            //                   BorderRadius.all(Radius.circular(15)),
                            //                 ),
                            //                 child: Stack(
                            //                   children: [
                            //                     Positioned(
                            //                       top: 1,
                            //                       right: imageWidth * 0.01,
                            //                       child: Container(
                            //                         height: imageHeight * 0.5,
                            //                         width: imageWidth * 0.34,
                            //                         child: image[3] != null
                            //                             ? Image.asset(
                            //                           image[3], fit: BoxFit.cover,
                            //                           // color: imageColors[
                            //                           //     index % imageColors.length],
                            //                           // fit: BoxFit.fill,
                            //                           errorBuilder:
                            //                               (context, error, stackTrace) {
                            //                             return Image.asset(
                            //                               'lib/assets/logo/noimageavlble.jpg',
                            //                               fit: BoxFit.cover,
                            //                             );
                            //                           },
                            //                         )
                            //                             : Image.network(
                            //                           'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //                           fit: BoxFit.fill,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0,
                            //                       left: 0,
                            //                       right: 0,
                            //                       child: Column(
                            //                         //mainAxisAlignment: MainAxisAlignment.center,
                            //                         children: [
                            //                           responsiveText(
                            //                             context: context,
                            //                             text: (name[3]),
                            //                             fontSizePortrait: 16,
                            //                             fontSizeLandscape: 14,
                            //                             color: Colors.white,
                            //                           ),
                            //                           Align(
                            //                             alignment: Alignment.centerLeft,
                            //                             child: Container(
                            //                               height: imageHeight2 * 0.45,
                            //                               width: imageWidth2 * 0.6,
                            //                               decoration: BoxDecoration(
                            //                                 color: Colors.white,
                            //                                 borderRadius: BorderRadius.only(
                            //                                   topRight: Radius.circular(100),
                            //                                 ),
                            //                               ),
                            //                               child: Center(
                            //                                 child: responsiveText(
                            //                                   context: context,
                            //                                   text:
                            //                                   ("${_homedashboardController.dashboardResponse?.data?.leaveLeft}"),
                            //                                   fontSizePortrait: 19,
                            //                                   fontSizeLandscape: 19,
                            //                                   color: containerColors[
                            //                                   3 % containerColors.length],
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //             margin: const EdgeInsets.all(8),
                            //             child: GestureDetector(
                            //               onTap: () {
                            //                 //Navigator.push(
                            //                 // context,
                            //                 // MaterialPageRoute(
                            //                 //   builder: (context) => const CompanyDetail(),
                            //                 // ),
                            //                 //);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                   color:
                            //                   containerColors[4 % containerColors.length],
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       offset: Offset(0, 0),
                            //                       blurRadius: 1,
                            //                       color: Color.fromRGBO(0, 0, 0, 0.16),
                            //                     )
                            //                   ],
                            //                   borderRadius:
                            //                   BorderRadius.all(Radius.circular(15)),
                            //                 ),
                            //                 child: Stack(
                            //                   children: [
                            //                     Positioned(
                            //                       top: 1,
                            //                       right: imageWidth * 0.01,
                            //                       child: Container(
                            //                         height: imageHeight * 0.5,
                            //                         width: imageWidth * 0.34,
                            //                         child: image[4] != null
                            //                             ? Image.asset(
                            //                           image[4], fit: BoxFit.cover,
                            //                           // color: imageColors[
                            //                           //     index % imageColors.length],
                            //                           // fit: BoxFit.fill,
                            //                           errorBuilder:
                            //                               (context, error, stackTrace) {
                            //                             return Image.asset(
                            //                               'lib/assets/logo/noimageavlble.jpg',
                            //                               fit: BoxFit.cover,
                            //                             );
                            //                           },
                            //                         )
                            //                             : Image.network(
                            //                           'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //                           fit: BoxFit.fill,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0,
                            //                       left: 0,
                            //                       right: 0,
                            //                       child: Column(
                            //                         //mainAxisAlignment: MainAxisAlignment.center,
                            //                         children: [
                            //                           responsiveText(
                            //                             context: context,
                            //                             text: (name[4]),
                            //                             fontSizePortrait: 16,
                            //                             fontSizeLandscape: 14,
                            //                             color: Colors.white,
                            //                           ),
                            //                           Align(
                            //                             alignment: Alignment.centerLeft,
                            //                             child: Container(
                            //                               height: imageHeight2 * 0.45,
                            //                               width: imageWidth2 * 0.6,
                            //                               decoration: BoxDecoration(
                            //                                 color: Colors.white,
                            //                                 borderRadius: BorderRadius.only(
                            //                                   topRight: Radius.circular(100),
                            //                                 ),
                            //                               ),
                            //                               child: Center(
                            //                                 child: responsiveText(
                            //                                   context: context,
                            //                                   text:
                            //                                   ("${_homedashboardController.dashboardResponse?.data?.attendance}"),
                            //                                   fontSizePortrait: 19,
                            //                                   fontSizeLandscape: 19,
                            //                                   color: containerColors[
                            //                                   4 % containerColors.length],
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //             margin: const EdgeInsets.all(8),
                            //             child: GestureDetector(
                            //               onTap: () async {
                            //                 _supportEmployeeController.supportemployeeApi();
                            //                 _supportEmployeeController.update();
                            //                 await Future.delayed(Duration(milliseconds: 800));
                            //
                            //                 Get.to(SupportViewHirejobComman());
                            //
                            //                 //Navigator.push(
                            //                 // context,
                            //                 // MaterialPageRoute(
                            //                 //   builder: (context) => const CompanyDetail(),
                            //                 // ),
                            //                 //);
                            //               },
                            //               child: Container(
                            //                 decoration: BoxDecoration(
                            //                   color:
                            //                   containerColors[5 % containerColors.length],
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       offset: Offset(0, 0),
                            //                       blurRadius: 1,
                            //                       color: Color.fromRGBO(0, 0, 0, 0.16),
                            //                     )
                            //                   ],
                            //                   borderRadius:
                            //                   BorderRadius.all(Radius.circular(15)),
                            //                 ),
                            //                 child: Stack(
                            //                   children: [
                            //                     Positioned(
                            //                       top: 1,
                            //                       right: imageWidth * 0.01,
                            //                       child: InkWell(
                            //                         onTap: () {},
                            //                         child: Container(
                            //                           height: imageHeight * 0.57,
                            //                           width: imageWidth * 0.44,
                            //                           child: image[5] != null
                            //                               ? Image.asset(
                            //                             image[5], fit: BoxFit.cover,
                            //                             // color: imageColors[
                            //                             //     index % imageColors.length],
                            //                             // fit: BoxFit.fill,
                            //                             errorBuilder: (context, error,
                            //                                 stackTrace) {
                            //                               return Image.asset(
                            //                                 'lib/assets/logo/noimageavlble.jpg',
                            //                                 fit: BoxFit.cover,
                            //                               );
                            //                             },
                            //                           )
                            //                               : Image.network(
                            //                             'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            //                             fit: BoxFit.fill,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     Positioned(
                            //                       bottom: 0,
                            //                       left: 0,
                            //                       right: 0,
                            //                       child: Column(
                            //                         //mainAxisAlignment: MainAxisAlignment.center,
                            //                         children: [
                            //                           responsiveText(
                            //                             context: context,
                            //                             text: (name[5]),
                            //                             fontSizePortrait: 16,
                            //                             fontSizeLandscape: 14,
                            //                             color: Colors.white,
                            //                           ),
                            //                           Align(
                            //                             alignment: Alignment.centerLeft,
                            //                             child: Container(
                            //                               height: imageHeight2 * 0.45,
                            //                               width: imageWidth2 * 0.6,
                            //                               decoration: BoxDecoration(
                            //                                 color: Colors.white,
                            //                                 borderRadius: BorderRadius.only(
                            //                                   topRight: Radius.circular(100),
                            //                                 ),
                            //                               ),
                            //                               child: Center(
                            //                                 child: responsiveText(
                            //                                   context: context,
                            //                                   text: "24*7\n Available",
                            //                                   fontSizePortrait: 19,
                            //                                   fontSizeLandscape: 19,
                            //                                   color: containerColors[
                            //                                   5 % containerColors.length],
                            //                                 ),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
                        ),
            );
          });
          })
               ),
       );
   // );
  }

  Widget _header(BuildContext context){
    return  Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
          //color: appColor2,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [
        //   appColorr2,
        //   linkedinColor
        // ])
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0,right: 18.0,top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text("${_getprofileepersonal.getprofileemployeeModel?.data?.fullName.toString()}",
                      style: GoogleFonts.poppins(textStyle:TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black
                      ),)),
                  SizedBox(height: 6,),
                  //Obx(()=>
                    Text(dateTimeController.currentTime.value,style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black
                      ),)),
                 // ),
                  // Text(DateFormat('h:mm a').format(DateTime.now()),
                  //   style: GoogleFonts.lato(
                  //     textStyle: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 17,
                  //         color: Colors.black
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Container(
            //   child: CircleAvatar(
            //     radius: 30,
            //     backgroundColor: Colors.white,
            //     child:  ClipOval(
            //       child: GestureDetector(
            //         onTap: () async {
            //           await _profileEmployeeController.profileemployeeApi();
            //           // await _profileEmployeeController.profileBasicemployeeApi();
            //           // await _profileEmployeeController.profileEmployeBankApi();
            //
            //           //profileBasicemployeeApi();
            //           //     profileEmployeBankApi();
            //
            //           //_profileEmployeeController.update();
            //
            //           // await _profileController.profileApi();
            //           // _profileController.update();
            //           await Navigator.push(context,
            //               MaterialPageRoute(builder: (context) => EmployeeProfile()));
            //         },
            //         child: responsiveContainer(
            //           // padding: const EdgeInsets.only(right: 0),
            //           //height: 20,
            //           //width: 20,
            //           heightPortrait: MediaQuery.of(context).size.height * 0.12,
            //           widthPortrait: MediaQuery.of(context).size.width * 0.25,
            //           heightLandscape: MediaQuery.of(context).size.height * 0.3,
            //           widthLandscape: MediaQuery.of(context).size.width * 0.2,
            //           // height: MediaQuery.of(context).size.height *
            //           //     0.05, // 20% of screen height if not provided
            //           // width: MediaQuery.of(context).size.width * 0.09,
            //           //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
            //           child: _getprofileepersonal
            //               .getprofileemployeeModel?.data?.profileImage !=
            //               null
            //               ? Image.network(
            //             //"${FixedText.apiurl2}"
            //             "${_getprofileepersonal.getprofileemployeeModel?.data?.profileImage}",
            //             //color: appColor,
            //             fit: BoxFit.cover,
            //             errorBuilder: (context, error, stackTrace) {
            //               return Image.asset(
            //                 'lib/assets/logo/logoo.png',
            //                 fit: BoxFit.contain,
            //               );
            //             },
            //           )
            //               : Image.network(
            //             'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
            //             fit: BoxFit.fill,
            //           ),
            //           context: context,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 8,),
                Text(DateFormat('d MMM y').format(DateTime.now()),
                  style: GoogleFonts.lato(textStyle:TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black
                  ),),),
                SizedBox(height: 8,),

               // Obx(()=>
                  Row(
                    children: [
                      SizedBox(
                          child: Text("Distance: ")
                      ),
                      SizedBox(
                          child: Text(
                            locationController.latitude.value==0.0 && locationController.longitude.value==0.0?"N/A":
                            "${locationController.distanceFromCompany.value.toStringAsFixed(2)}m",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600
                          ),)
                      ),
                    ],
                  ),
              //  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showdilogleave(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showCupertinoDialog(
      barrierDismissible: true, // Allow closing the dialog by tapping outside
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Smooth rounded corners
          ),
          backgroundColor: Colors.white, // Dialog background color
          child: Padding(
            padding: const EdgeInsets.all(20), // Padding for the content
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Dialog Title with style
                Text(
                  "Select Leave Type",
                  style: TextStyle(
                    fontSize: size.height * 0.024,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Darker black for a premium feel
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: 20), // Spacing after title

                // Single Day Leave button
                GestureDetector(
                  onTap: () {
                    Get.to(SingleDayLeavePage());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent], // Gradient background
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text(
                          "Single Day Leave",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15), // Spacing between buttons

                // Multiple Day Leave button
                GestureDetector(
                  onTap: () {
                    Get.to(MultipleDayLeavePage());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade500, Colors.green], // Gradient background
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15), // Rounded corners
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.date_range, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text(
                          "Multiple Day Leave",
                          style: TextStyle(
                            fontSize: size.height * 0.018,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Spacing between buttons

                // Other Leave button
                // GestureDetector(
                //   onTap: () {
                //     // Add navigation logic for other leave types
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.symmetric(vertical: 16),
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: [Colors.redAccent, Colors.deepOrange], // Gradient background
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight,
                //       ),
                //       borderRadius: BorderRadius.circular(15), // Rounded corners
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.redAccent.withOpacity(0.4),
                //           spreadRadius: 2,
                //           blurRadius: 8,
                //           offset: Offset(0, 4), // Shadow direction
                //         ),
                //       ],
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.hourglass_empty, color: Colors.white, size: 20),
                //         SizedBox(width: 10),
                //         Text(
                //           "Other Leave",
                //           style: TextStyle(
                //             fontSize: size.height * 0.018,
                //             color: Colors.white,
                //             fontWeight: FontWeight.w600,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20), // Spacing after buttons

                // Cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 40,
                    //padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade200,

                      // gradient: LinearGradient(
                      //   colors: [Colors.red.shade500, Colors.red], // Gradient background
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      // ),
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.018,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showdilogleave1(BuildContext context) {
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


