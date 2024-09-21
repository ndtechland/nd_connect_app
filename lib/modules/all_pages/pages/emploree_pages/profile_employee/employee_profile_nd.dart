import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/components/styles.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/home_page_employee2.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/aadharPage.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/panCard_page.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/update_add_profile/personal_information_update.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/update_add_profile/update_add_profile_info.dart';

import '../../../../../components/responsive_text.dart';
import '../../../../../constants/static_text.dart';
import '../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../../controllers/employeee_controllersss/employee_edit_profile_controller/employee_update_personal_controller.dart';
import 'back_aadharPage.dart';

class EmployeeProfileNd extends StatelessWidget {
  const EmployeeProfileNd({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());
    final EmployeeUpdatePersonalController _employeeUpdatePersonalController = Get.put(EmployeeUpdatePersonalController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_new_outlined),
        //   onPressed: (){
        //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeEmployee2()));
        //     },
        // ),
        title: Text("Profile",
        style:TextStyle(
          fontFamily: 'medium',
        ),),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xffF8F9FD),
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
              ? screenWidth * 0.55
              : screenWidth * 0.19;
          var imageHeight2 = orientation == Orientation.portrait
              ? screenHeight * 0.32
              : screenHeight * 0.5;

          var categoryWidth = orientation == Orientation.portrait
              ? screenWidth * 0.5
              : screenWidth * 0.3;
          var categoryHeight = orientation == Orientation.portrait
              ? screenHeight * 0.42
              : screenHeight * 0.37;
          return SafeArea(
              child:SingleChildScrollView(
                child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context),
                    // const SizedBox(height: 8),
                    // const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          blackHeadingSmall('Information'.toUpperCase()),
                          GestureDetector(
                              onTap: () async {
                                _getprofileepersonal.profileemployeeApi();
                                // _getprofileepersonal
                                //     .profileBasicemployeeApi();
                                _getprofileepersonal
                                    .profileEmployeBankApi();

                                // _getprofilee.profileApi();
                                // Update UI after fetching profile information
                                // _getprofilee.update();
                                // _getprofilee.getprofileModel?.response?.id.toString();
                                await _employeeUpdatePersonalController
                                    .getStatepi();
                                //_userProfileUodateController.onInit();
                                _employeeUpdatePersonalController
                                    .selectedState.value = null;
                                // _userProfileUodateController
                                //     .selectedCity.value = null;
                                // await Future.delayed(Duration(milliseconds: 300));
                                // await Get.to(EditProfile());

                                //profileBasicemployeeApi();
                                //     profileEmployeBankApi();

                                _getprofileepersonal.update();
                                // await _profileController.profileApi();
                                // _profileController.update();
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        PersonalUpdateProfile()
                                           // EmployeeUpdateProfile()
                                    ));
                              },
                              child: appcolorText('Edit'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0,6.0,6.0,12.0,),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [BoxShadow(
                                spreadRadius:2.0 ,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                                color: Colors.black26,
                                offset: Offset(0,5)
                            )]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Information",
                              //   //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                              //   style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold)),
                              // ),
                              // const SizedBox(height: 10),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Work Email:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                  //  "",
                                  "${_getprofileepersonal.getprofileemployeeModel?.data!.personalEmailAddress.toString()}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Phone Number:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                   // "",
                                    "+91 ${_getprofileepersonal.getprofileemployeeModel?.data!.mobileNumber.toString()}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("DOB:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    //"",
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.dateOfBirth.toString()}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              //addresss

                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text("Address",
                              //       //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                              //       style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                              //     ),
                              //     SizedBox(width: 8,),
                              //     Container(
                              //       height: 100,
                              //       width: 240,
                              //       //color: Colors.pink,
                              //       child: Wrap(
                              //         children:[ Text(
                              //           //overflow: TextOverflow.ellipsis,
                              //            "${_getprofilee.getprofileModel?.data!.address.toString()}",
                              //           style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500,
                              //           // overflow: TextOverflow.ellipsis
                              //           ),
                              //         ),]
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Joining Date:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.dateOfJoining.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("State:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.stateName.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("City:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.cityName.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Address:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.address1.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Permanent Address:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.address2.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pincode:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.pincode.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Personal Email:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.personalEmailAddress.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ), const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Company Name:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.companyName.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ), const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Company Location:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.companyLocationName.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ), const SizedBox(height: 10),

                            ],
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 8),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 16, vertical: 4),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       blackHeadingSmall('Bank Details'.toUpperCase()),
                    //       GestureDetector(
                    //           onTap: () async {
                    //             await _getprofileepersonal
                    //                 .profileemployeeApi();
                    //             await _getprofileepersonal
                    //                 .profileBasicemployeeApi();
                    //             await _getprofileepersonal
                    //                 .profileEmployeBankApi();
                    //
                    //             // _getprofilee.profileApi();
                    //             // Update UI after fetching profile information
                    //             // _getprofilee.update();
                    //             // _getprofilee.getprofileModel?.response?.id.toString();
                    //             await _employeeUpdatePersonalController
                    //                 .getStatepi();
                    //             //_userProfileUodateController.onInit();
                    //             _employeeUpdatePersonalController
                    //                 .selectedState.value = null;
                    //
                    //             _getprofileepersonal.update();
                    //             // await _profileController.profileApi();
                    //             // _profileController.update();
                    //             await Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         EmployeeUpdateProfile()));
                    //           },
                    //           child: appcolorText('Edit'))
                    //     ],
                    //   ),
                    // ),



                    // Padding(
                    //   padding: const EdgeInsets.all(6.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(8.0),
                    //         boxShadow: [BoxShadow(
                    //             spreadRadius:2.0 ,
                    //             blurStyle: BlurStyle.outer,
                    //             blurRadius: 5,
                    //             color: Colors.black26,
                    //             offset: Offset(0,5)
                    //         )]
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(12.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           // Text("Information",
                    //           //   //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                    //           //   style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.bold)),
                    //           // ),
                    //           // const SizedBox(height: 10),
                    //
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("A/C Holder Name:",
                    //                 //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                    //                 style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                    //               ),
                    //               SizedBox(width: 8,),
                    //               Text(
                    //               //  "",
                    //               "${_getprofileepersonal.getbankprofiledetail?.data!.accountHolderName.toString()}",
                    //                 style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(height: 10),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("BankName:",
                    //                 //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                    //                 style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                    //               ),
                    //               SizedBox(width: 8,),
                    //               Text(
                    //                // "",
                    //                 "${_getprofileepersonal.getbankprofiledetail?.data?.bankName.toString()}",
                    //                 style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(height: 10),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("A/C Number:",
                    //                 //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                    //                 style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                    //               ),
                    //               SizedBox(width: 8,),
                    //               Text(
                    //                 //"",
                    //                 "${_getprofileepersonal.getbankprofiledetail?.data?.accountNumber.toString()}",
                    //                 style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(height: 10),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("IFSC Code:",
                    //                 //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                    //                 style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                    //               ),
                    //               SizedBox(width: 8,),
                    //               Text(
                    //                 "${_getprofileepersonal.getbankprofiledetail?.data!.ifsc.toString()}",
                    //                 //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                    //                 style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(height: 10),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text("EPF Number:",
                    //                 //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                    //                 style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                    //               ),
                    //               SizedBox(width: 8,),
                    //               Text(
                    //                 "${_getprofileepersonal.getbankprofiledetail?.data?.epfNumber.toString()}",
                    //                 //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                    //                 style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                    //               ),
                    //             ],
                    //           ), const SizedBox(height: 10),
                    //
                    //         ],
                    //       ),
                    //     ),),
                    // ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          blackHeadingSmall('Document'.toUpperCase()),
                          // GestureDetector(
                          //     onTap: () async {
                          //       _getprofileepersonal.profileemployeeApi();
                          //       _getprofileepersonal
                          //           .profileBasicemployeeApi();
                          //       _getprofileepersonal
                          //           .profileEmployeBankApi();
                          //
                          //       // _getprofilee.profileApi();
                          //       // Update UI after fetching profile information
                          //       // _getprofilee.update();
                          //       // _getprofilee.getprofileModel?.response?.id.toString();
                          //       await _employeeUpdatePersonalController
                          //           .getStatepi();
                          //       //_userProfileUodateController.onInit();
                          //       _employeeUpdatePersonalController
                          //           .selectedState.value = null;
                          //       // _userProfileUodateController
                          //       //     .selectedCity.value = null;
                          //       // await Future.delayed(Duration(milliseconds: 300));
                          //       // await Get.to(EditProfile());
                          //
                          //       //profileBasicemployeeApi();
                          //       //     profileEmployeBankApi();
                          //
                          //       _getprofileepersonal.update();
                          //       // await _profileController.profileApi();
                          //       // _profileController.update();
                          //       await Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) =>
                          //                   EmployeeUpdateProfile()));
                          //     },
                          //     child: appcolorText('Edit'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6.0,6.0,6.0,12.0,),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [BoxShadow(
                                spreadRadius:2.0 ,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 5,
                                color: Colors.black26,
                                offset: Offset(0,5)
                            )]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Aadhar Number:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    _getprofileepersonal.getprofileemployeeModel?.data!.aadharNo.toString()??"",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Aadhar Image:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0)
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                                          return FrontAadharpage();
                                        }));
                                      },
                                      child: Hero(
                                        tag: 'aadharImg',
                                        child: Image.network(
                                          "${_getprofileepersonal.getprofileemployeeModel?.data!.aadharOne.toString()}",
                                         // 'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0)
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                                          return BackAadharpage();
                                        }));
                                      },
                                      child: Hero(
                                        tag: 'aadharImg1',
                                        child: Image.network(
                                          "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data!.aadharTwo.toString()}",
                                        //  'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Pan Card Number:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "${_getprofileepersonal.getprofileemployeeModel?.data!.panNo.toString()}",
                                    //"${_getprofilee.getprofileModel?.data!.joiningDate.toString().substring(0,10)}",
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("PanCard Image:",
                                    //"${_getprofilee.getprofileModel?.response!.emailId.toString()}",
                                    style:GoogleFonts.lato(textStyle: TextStyle(fontSize: 14, color: Color(0xff79829E),fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(width: 8,),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0)
                                    ),
                                    child:GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                                          return PancardPage();
                                        }));
                                      },
                                      child: Hero(
                                        tag: 'panImg',
                                        child: Image.network(
                                          "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data!.panimg.toString()}",
                                         // 'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
                                        ),
                                      ),
                                    ),),

                                ],
                              ),
                            ],
                          ),
                        ) ,
                      ),
                    ),

                    //doc

                    // Row(
                    //   children: [
                    //     Container(
                    //       height: 100,
                    //       width: 100,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12.0)
                    //       ),
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //             return Aadharpage();
                    //           }));
                    //         },
                    //         child: Hero(
                    //           tag: 'aadharImg',
                    //           child: Image.network(
                    //             'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: 100,
                    //       width: 100,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(12.0)
                    //       ),
                    //     child:GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(context, MaterialPageRoute(builder: (_) {
                    //           return PancardPage();
                    //         }));
                    //       },
                    //       child: Hero(
                    //         tag: 'panImg',
                    //         child: Image.network(
                    //           'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
                    //         ),
                    //       ),
                    //     ),),
                    //   ],
                    // ),
                  ],
                ),
                ),
              )
          );
        });
      }),
    );
  }
  Widget _header(BuildContext context){
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final ProfileEmployeeController _getprofileepersonal = Get.put(ProfileEmployeeController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      width:double.infinity,
      height: h/3.7,
     // color: Colors.yellow,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(18.0),
      //   boxShadow: [
      //     BoxShadow(
      //       spreadRadius: 2.0,
      //       blurStyle: BlurStyle.outer,
      //       blurRadius: 10,
      //       color: Colors.black26,
      //     )
      //   ],
      // ),
      child: Stack(
        children: [
         // const SizedBox(
         //    height: 150,
         //  ),
      Positioned(
        top: 40,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Colors.white,
          child:Container(
            height: h/6,
            width: w/1.02,
          )
          // Container(
          // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          // width:w/1,
          // height: 150,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(18.0),
          //   boxShadow: [
          //     BoxShadow(
          //       spreadRadius: 2.0,
          //       blurStyle: BlurStyle.outer,
          //       blurRadius: 10,
          //       color: Colors.black26,
          //       offset: (0,2)
          //     )
          //   ],
          // ),),
        ),
      ),
          Center(
            child: Column(
            //  mainAxisSize: MainAxisSize.min,
              children: [
             //  const SizedBox(height: 10), // Add spacing before avatar
                CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child:  ClipOval(
                      child: responsiveContainer(
                        // padding: const EdgeInsets.only(right: 0),
                        //height: 20,
                        //width: 20,
                        heightPortrait: MediaQuery.of(context).size.height * 0.12,
                        widthPortrait: MediaQuery.of(context).size.width * 0.25,
                        heightLandscape: MediaQuery.of(context).size.height * 0.3,
                        widthLandscape: MediaQuery.of(context).size.width * 0.2,
                        // height: MediaQuery.of(context).size.height *
                        //     0.05, // 20% of screen height if not provided
                        // width: MediaQuery.of(context).size.width * 0.09,
                        //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
                        child: _getprofileepersonal
                            .getprofileemployeeModel?.data?.empProfile !=
                            null
                            ? Image.network(
                          //"${FixedText.apiurl2}"
                          "${FixedText.imageUrlll}${_getprofileepersonal.getprofileemployeeModel?.data?.empProfile}",
                          //color: appColor,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'lib/assets/logo/logoo.png',
                              fit: BoxFit.contain,
                            );
                          },
                        )
                            : Image.network(
                          'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                          fit: BoxFit.fill,
                        ),
                        context: context,
                      ),
                    ),
                  ),
                const SizedBox(height: 5),
                Text(
                 // "jjjn",
                  "${_getprofileepersonal.getprofileemployeeModel?.data!.fullName.toString()}",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'medium',
                    color: appColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Role: ${_getprofileepersonal.getprofileemployeeModel?.data!.departmentName.toString()}",
                    //"${_getprofilee.getprofileModel?.data!.address.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'medium',
                      color: appColor2,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Employee Id:${_getprofileepersonal.getprofileemployeeModel?.data!.employeeId.toString()}",
                    //"${_getprofilee.getprofileModel?.data!.address.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'medium',
                      color: appColor2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2.0,
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
            color: Colors.black26,
          )
        ],
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: appColor2,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10, // Keep consistent spacing from the left
            child: IconButton(
              onPressed: () {
               // Get.to(Home());
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80), // Add spacing before avatar
                // FluttermojiCircleAvatar(
                //   backgroundColor: Colors.grey[200],
                //   radius: 40,
                // ),
                const SizedBox(height: 5),
                Text(
                  "",
                 // "${_getprofilee.getprofileModel?.data!.name.toString()}",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'medium',
                    color: appColor2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "",
                    //"${_getprofilee.getprofileModel?.data!.address.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'medium',
                      color: appColor2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () {
              //  Get.to(() => NewPage());
              },
              icon: Icon(Icons.edit_outlined, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
