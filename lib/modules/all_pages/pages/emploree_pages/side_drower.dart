import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nd_connect_techland/controllers/about_company_controller.dart';
import 'package:nd_connect_techland/controllers/faq_controller.dart';
import 'package:nd_connect_techland/modules/all_pages/events/events_calender.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/employee_bank_nd.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/profileImage_page.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/profile_employee.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/update_add_profile/personal_information_update.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/update_add_profile/update_add_bank_detail.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/profile_employee/update_add_profile/update_add_profile_info.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/emploree_pages/salary_slip_view.dart';
import '../../../../../components/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/responsive_text.dart';
import '../../../../constants/app_colorss/app_colorss.dart';
import '../../../../constants/reusable_customdilog.dart';
import '../../../../constants/static_text.dart';
import '../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../../../controllers/employeee_controllersss/employee_edit_profile_controller/employee_update_personal_controller.dart';
import '../../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../../../controllers/employeee_controllersss/employee_offer_appointment/offer_apt_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/payment_get_controller/payment_get_controller.dart';
import '../../../../controllers/employeee_controllersss/salary_slip_controller/salary_slip_controllerss.dart';
import '../../../../controllers/employeee_controllersss/support_comman/support_commannn.dart';
import '../../../../widget/custom_loader.dart';
import '../../../faqs/faqs.dart';
import '../login.dart';
import '../view_pdf_only.dart';
import 'change_password_employee.dart';
import 'leaves_employee/multiple_day.dart';
import 'leaves_employee/single_day.dart';

class EmployeeNavBar extends StatelessWidget {
  EmployeeNavBar({Key? key}) : super(key: key);

  AptOfferEmployeeController _aptOfferEmployeeController = Get.put(AptOfferEmployeeController());
  final ProfileEmployeeController _getprofileebnk = Get.put(ProfileEmployeeController());

  ProfileEmployeeController _profileEmployeeController = Get.put(ProfileEmployeeController());

  EmployeeLoginController _employeeloginController = Get.put(EmployeeLoginController());

  AllSalarySlipController _allsalaryslipController = Get.put(AllSalarySlipController());

  AboutCompanyController aboutCompanyController = Get.put(AboutCompanyController());
  final EmployeeUpdatePersonalController _employeeUpdatePersonalController = Get.put(EmployeeUpdatePersonalController());
  HomedashboardController _homedashboardController = Get.put(HomedashboardController());
  FaqController faqController = Get.put(FaqController());

  final snackBarDuration = Duration(seconds: 3); // Define your desired duration
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse('https://ndtechland.com/Termsconditions');
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    final Uri _privacyUrl = Uri.parse('https://ndtechland.com/Privacypolicy');
    Future<void> _launchPrivacyUrl() async {
      if (!await launchUrl(_privacyUrl)) {
        throw 'Could not launch $_privacyUrl';
      }
    }
   final Uri _aboudNdConnectUrl = Uri.parse('https://connect.ndtechland.com/Ourstory');
    Future<void> _launchNdConnectUrl() async {
      if (!await launchUrl(_aboudNdConnectUrl)) {
        throw 'Could not launch $_aboudNdConnectUrl';
      }
    }
    final Uri _aboudCompanyUrl1 = Uri.parse('${aboutCompanyController.aboutCompanyModel?.data?.companylink}');
    print("_aboudCompanyUrl:$_aboudCompanyUrl1");
    Future<void> _launchCompanyUrl1() async {
      if (!await launchUrl(_aboudCompanyUrl1)) {
        throw 'Could not launch $_aboudCompanyUrl1';
      }
    }
    return OrientationBuilder(builder: (context, orientation) {
      return LayoutBuilder(builder: (context, constraints) {
        var screenWidth = constraints.maxWidth;
        var screenHeight = constraints.maxHeight;

        var imageWidth = orientation == Orientation.portrait
            ? screenWidth * 0.55
            : screenWidth * 0.25;
        var imageHeight = orientation == Orientation.portrait
            ? screenHeight * 0.15
            : screenHeight * 0.3;

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(color: appColor2
                    // gradient: LinearGradient(
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter,
                    //     colors: <Color>[logoColor, logoColor]),
                    ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileImagePage()));
                        },
                        child: Hero(
                          tag: 'profileImg',
                          child: CircleAvatar(
                            radius: imageHeight * 0.4,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: responsiveContainer(
                                // padding: const EdgeInsets.only(right: 0),
                                //height: 20,
                                //width: 20,
                                heightPortrait:
                                    MediaQuery.of(context).size.height * 0.12,
                                widthPortrait:
                                    MediaQuery.of(context).size.width * 0.25,
                                heightLandscape:
                                    MediaQuery.of(context).size.height * 0.3,
                                widthLandscape:
                                    MediaQuery.of(context).size.width * 0.2,
                                // height: MediaQuery.of(context).size.height *
                                //     0.05, // 20% of screen height if not provided
                                // width: MediaQuery.of(context).size.width * 0.09,
                                //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
                                child: _profileEmployeeController.getprofileemployeeModel?.data?.empProfile != null
                                    ? Image.network(
                                        // "${FixedText.apiurl2}"
                                        "${FixedText.imageUrlll}${_profileEmployeeController.getprofileemployeeModel?.data?.empProfile}",
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
                        ),
                      ),
                      responsiveText(
                        context: context,
                        text:
                            ("${_profileEmployeeController.getprofileemployeeModel?.data?.fullName?.toString()}"),
                        fontSizePortrait: 14,
                        fontSizeLandscape: 19,
                        color: Colors.white,
                      ),
                      // Text(
                      //   "${_profileEmployeeController.getprofileemployeeModel?.data?.name?.toString()}",
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       fontFamily: 'medium',
                      //       color: Colors.white),
                      // ),
                      responsiveText(
                        context: context,
                        text:
                            ("${_profileEmployeeController.getprofileemployeeModel?.data?.personalEmailAddress.toString()}"),
                        fontSizePortrait: 11,
                        fontSizeLandscape: 19,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              // UserAccountsDrawerHeader(
              //   accountName: const Text(
              //     'Kumar Prince',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   accountEmail: const Text(
              //     'prince@prince.com',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   currentAccountPicture: CircleAvatar(
              //     child: ClipOval(
              //       child: Image.asset(
              //         'lib/assets/images/s3.jpg',
              //         fit: BoxFit.cover,
              //         width: 90,
              //         height: 90,
              //       ),
              //     ),
              //   ),
              // ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('View Profile'),
                onTap: () async {
                  Get.dialog(CustomThreeInOutLoader(),
                      barrierDismissible: false);
                  _profileEmployeeController.profileemployeeApi();
                  // _profileEmployeeController.profileBasicemployeeApi();
                  _profileEmployeeController.profileEmployeBankApi();
                  // await _employeeUpdatePersonalController
                  //     .getStatepi();
                  //profileBasicemployeeApi();
                  //     profileEmployeBankApi();

                  _profileEmployeeController.update();
                  Get.back();
                  // await _profileController.profileApi();
                  // _profileController.update();
                  Future.delayed(Duration(seconds: 1));
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalUpdateProfile()
                          //EmployeeProfile()
                          ));
                },
              ),

              // ListTile(
              //   leading: const Icon(Icons.edit_outlined),
              //   title: const Text('Add/Update Profile'),
              //   onTap: () async {
              //     await _profileEmployeeController.profileemployeeApi();
              //     await _profileEmployeeController.profileBasicemployeeApi();
              //     await _profileEmployeeController.profileEmployeBankApi();
              //
              //     // _getprofilee.profileApi();
              //     // Update UI after fetching profile information
              //     // _getprofilee.update();
              //     // _getprofilee.getprofileModel?.response?.id.toString();
              //     await _employeeUpdatePersonalController.getStatepi();
              //     //_userProfileUodateController.onInit();
              //     _employeeUpdatePersonalController.selectedState.value = null;
              //     // _userProfileUodateController
              //     //     .selectedCity.value = null;
              //     // await Future.delayed(Duration(milliseconds: 300));
              //     // await Get.to(EditProfile());
              //
              //     //profileBasicemployeeApi();
              //     //     profileEmployeBankApi();
              //
              //     _profileEmployeeController.update();
              //     // await _profileController.profileApi();
              //     // _profileController.update();
              //     await Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => EmployeeUpdateProfile()));
              //   },
              // ),

              ListTile(
                leading: const Icon(Icons.account_balance_rounded),
                title: const Text('Bank Details'),
                onTap: () async {
                  Get.dialog(CustomThreeInOutLoader(),
                      barrierDismissible: false);
                  _profileEmployeeController.profileEmployeBankApi();

                 // _allsalaryslipController.fetchSalarySlips();
                 // _allsalaryslipController.onInit();
                  Get.back();
                  Future.delayed(Duration(seconds: 1));
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BankDetailUpdateEmployeeProfile()
                          // EmployeeBankNd()
                          ));
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.done_all),
              //   title: const Text('Apply For Leaves'),
              //   onTap: () {
              //     showdilogleave(context);
              //     // Navigator.push(context,
              //     //     MaterialPageRoute(builder: (context) => Company()));
              //   },
              // ),

              ///todo: payment
              // ListTile(
              //   leading: const Icon(Icons.event),
              //   title: const Text('Events'),
              //   onTap: () async {
              //     Get.dialog(CustomThreeInOutLoader(),
              //         barrierDismissible: false);
              //     Get.back();
              //     // await _employeeController.paymentemployeeApi();
              //     // _employeeController.onInit();
              //     await Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => EventCalendarScreen(id:'12)));
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(Icons.stay_current_landscape_rounded),
              //   title: const Text('Offer latter '),
              //   onTap: () async {
              //     await _aptOfferEmployeeController.ampofferemployeeApi();
              //     _aptOfferEmployeeController.update();
              //
              //     // Get the URL of the PDF file from the profile information
              //     String url =
              //         "${FixedText.offaptpdfurl}${_aptOfferEmployeeController.getampofferModel?.data?.offerletter?.toString()}";
              //     print("url");
              //     print(url);
              //     // final String? url =
              //     //     "https://admin.hirejobindia.com//OfferLetter/6905205d-23cf-46a7-bc12-d708f46ad51120240413162904075.pdf";
              //     //
              //
              //     if (url != null) {
              //       showDialog(
              //         context: context,
              //         barrierDismissible:
              //             false, // Prevent dismissing dialog by tapping outside
              //         builder: (BuildContext context) {
              //           return AlertDialog(
              //             content: Column(
              //               mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 CircularProgressIndicator(), // Circular loader
              //                 SizedBox(height: 10),
              //                 Text(
              //                     'Loading Offer Latter....'), // Text indicating download process
              //               ],
              //             ),
              //           );
              //         },
              //       );
              //
              //       try {
              //         // Load the PDF file from the network
              //         final file = await loadPdfFromNetwork(url);
              //         Navigator.pop(context); // Close the loading dialog
              //
              //         if (file != null) {
              //           // Open the PDF viewer page
              //           openPdf(context, file, url);
              //         } else {
              //           // Handle error if file loading failed
              //           showDialog(
              //             context: context,
              //             builder: (context) => AlertDialog(
              //               title: Text('Error'),
              //               content: Text('Failed to load PDF file.'),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () => Navigator.pop(context),
              //                   child: Text('OK'),
              //                 ),
              //               ],
              //             ),
              //           );
              //         }
              //       } catch (e) {
              //         print('Error downloading PDF: $e');
              //         Navigator.pop(context); // Close the loading dialog
              //         // Handle error if downloading fails
              //         showDialog(
              //           context: context,
              //           builder: (context) => AlertDialog(
              //             title: Text('Error'),
              //             content: Text('Failed to download PDF file.'),
              //             actions: [
              //               TextButton(
              //                 onPressed: () => Navigator.pop(context),
              //                 child: Text('OK'),
              //               ),
              //             ],
              //           ),
              //         );
              //       }
              //     } else {
              //       // Handle error if URL is null
              //       showDialog(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //           title: Text('Error'),
              //           content: Text('URL is null.'),
              //           actions: [
              //             TextButton(
              //               onPressed: () => Navigator.pop(context),
              //               child: Text('OK'),
              //             ),
              //           ],
              //         ),
              //       );
              //       Get.back();
              //     }
              //
              //     //Get.back();
              //
              //     // Navigator.push(context,
              //     //     MaterialPageRoute(builder: (context) => Company()));
              //   },
              // ),

              ///
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('Offer Letter'),
                onTap: () async {
                  Get.dialog(CustomThreeInOutLoader(),
                      barrierDismissible: false);
                  await _homedashboardController.dashboarddApi();
                  _homedashboardController.update();
                  Get.back();
                  if(_homedashboardController.offLetter.isNotEmpty){
                    await _homedashboardController.openDocument(_homedashboardController.offLetter.value);
                  } else {
                    Get.snackbar("Error", "No document found to open.",backgroundColor: Colors.red,colorText: Colors.white);
                  }
                  // await _aptOfferEmployeeController.ampofferemployeeApi();
                  // _aptOfferEmployeeController.update();
                  // //   await Future.delayed(Duration(seconds: 2));
                  // Get.back();
                  // if (_aptOfferEmployeeController.aptLetter.isNotEmpty) {
                  //   await _aptOfferEmployeeController.openDocument(
                  //       _aptOfferEmployeeController.offLetter.value);
                  // } else {
                  //   // Handle the case where `aptLetter` is empty
                  //   Get.snackbar("Error", "No document found to open.");
                  // }
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_document),
                title: const Text('Appointment Letter'),
                onTap: () async {
                  Get.dialog(CustomThreeInOutLoader(),
                      barrierDismissible: false);

                  // await _aptOfferEmployeeController.ampofferemployeeApi();
                  // _aptOfferEmployeeController.update();
                  //   await Future.delayed(Duration(seconds: 2));
                  await _homedashboardController.dashboarddApi();
                  _homedashboardController.update();
                  Get.back();
                  if(_homedashboardController.aptLetter.isNotEmpty){
                    await _homedashboardController.openDocument(_homedashboardController.aptLetter.value);
                  } else {
                    Get.snackbar("Error", "No document found to open.",backgroundColor: Colors.red,colorText: Colors.white);
                  }
                  // if (_aptOfferEmployeeController.aptLetter.isNotEmpty) {
                  //   await _aptOfferEmployeeController.openDocument(
                  //       _aptOfferEmployeeController.aptLetter.value);
                  // } else {
                  //   // Handle the case where `aptLetter` is empty
                  //   Get.snackbar("Error", "No document found to open.");
                  // }
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.picture_as_pdf),
              //   title: const Text('Appointment Latter '),
              //   onTap: () async {
              //     await _aptOfferEmployeeController.ampofferemployeeApi();
              //     await _aptOfferEmployeeController.openDocument(_aptOfferEmployeeController.aptLetter.value);
              //     _aptOfferEmployeeController.update();
              //
              //     // Get the URL of the PDF file from the profile information
              //     String url =
              //         "${FixedText.offaptpdfurl}${_aptOfferEmployeeController.getampofferModel?.data?.appointmentletter?.toString()}";
              //     print("url");
              //     print(url);
              //     // final String? url =
              //     //     "https://admin.hirejobindia.com//OfferLetter/6905205d-23cf-46a7-bc12-d708f46ad51120240413162904075.pdf";
              //     //
              //
              //     if (url != null) {
              //       // Show loading dialog
              //       showDialog(
              //         context: context,
              //         barrierDismissible: false, // Prevent dismissing dialog by tapping outside
              //         builder: (BuildContext context) {
              //           return WillPopScope(
              //             onWillPop: () async => false, // Prevent dialog from being closed by back button
              //             child: AlertDialog(
              //               content: Column(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   CircularProgressIndicator(), // Circular loader
              //                   SizedBox(height: 10),
              //                   Text('Loading Apt letter....'), // Text indicating download process
              //                 ],
              //               ),
              //             ),
              //           );
              //         },
              //       );
              //
              //       try {
              //         // Load the PDF file from the network
              //         final file = await loadPdfFromNetwork(url); // Pass the correct URL
              //
              //         if (Navigator.canPop(context)) {
              //           Navigator.pop(context); // Close the loading dialog if it's still open
              //         }
              //
              //         if (file != null) {
              //           // Open the PDF viewer page
              //           openPdf(context, file, url);
              //         } else {
              //           // Handle error if file loading failed
              //           showDialog(
              //             context: context,
              //             builder: (context) => AlertDialog(
              //               title: Text('Error'),
              //               content: Text('Failed to load PDF file.'),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () => Navigator.pop(context),
              //                   child: Text('OK'),
              //                 ),
              //               ],
              //             ),
              //           );
              //         }
              //       } catch (e) {
              //         print('Error downloading PDF: $e');
              //
              //         if (Navigator.canPop(context)) {
              //           Navigator.pop(context); // Close the loading dialog if it's still open
              //         }
              //
              //         // Handle error if downloading fails
              //         showDialog(
              //           context: context,
              //           builder: (context) => AlertDialog(
              //             title: Text('Error'),
              //             content: Text('Failed to download PDF file.'),
              //             actions: [
              //               TextButton(
              //                 onPressed: () => Navigator.pop(context),
              //                 child: Text('OK'),
              //               ),
              //             ],
              //           ),
              //         );
              //       }
              //     } else {
              //       // Handle error if URL is null
              //       showDialog(
              //         context: context,
              //         builder: (context) => AlertDialog(
              //           title: Text('Error'),
              //           content: Text('URL is null.'),
              //           actions: [
              //             TextButton(
              //               onPressed: () => Navigator.pop(context),
              //               child: Text('OK'),
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              //
              //
              //     // Navigator.push(context,
              //     //     MaterialPageRoute(builder: (context) => Company()));
              //   },
              // ),

              ///

              ///todo: inbox and chat features.....
              ListTile(
                leading: const Icon(Icons.add_moderator),
                title: const Text('Privacy Policy'),
                onTap: () {
                  _launchPrivacyUrl();
                  Get.back();
                },
              ),

              ///todo: end inbox and chat features.....

              ListTile(
                leading: const Icon(Icons.document_scanner_sharp),
                title: const Text('Terms & Condition'),
                onTap: () {
                  _launchUrl();
                  Get.back();

                },
              ),
              ListTile(
                leading: const Icon(Icons.question_mark_sharp),
                title: const Text('FAQs'),
                onTap: ()async {
                  await faqController.FaqApi();
                 await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Faqs()));
                  //Faqs();
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_business_rounded),
                title: const Text('About Company'),
                onTap: () async {
                Get.dialog(CustomThreeInOutLoader(), barrierDismissible: false);

                // Call the API and wait for the response
                await aboutCompanyController.AboutCompanyApi();

                // Initialize _aboudCompanyUrl after the API response is received
                final Uri? _aboudCompanyUrl = aboutCompanyController.aboutCompanyModel?.data?.companylink != null
                ? Uri.tryParse('${aboutCompanyController.aboutCompanyModel?.data?.companylink}')
                    : null;

                print("_aboudCompanyUrl: $_aboudCompanyUrl");

                // Close the dialog after API response
                Get.back();

                // Launch the URL if it's valid
                if (_aboudCompanyUrl != null && await canLaunchUrl(_aboudCompanyUrl)) {
                await launchUrl(_aboudCompanyUrl);
                } else {
                print('Could not launch $_aboudCompanyUrl');
                 }
                },
               ),
               ListTile(
                leading: const Icon(Icons.business),
                title: const Text('ND Connect'),
                onTap: () {
                  _launchNdConnectUrl();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.password),
                title: const Text('Change Password'),
                onTap: () async {
                  //  _supportEmployeeController.supportemployeeApi();
                  // _supportEmployeeController.update();
                  // _registrationController.getStatepi();
                  //_registrationController.onInit();
                  // _registrationController.selectedState.value = null;
                  // await Future.delayed(Duration(milliseconds: 800));

                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeEmployeePassword()
                          //InviteFriend()
                          ));
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () async {
                  // Show loading dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );

                  _employeeloginController.onInit();

                  await Future.delayed(Duration(seconds: 1));

                  await SharedPreferences.getInstance()
                      .then((prefs) => prefs.clear());

                  // Hide loading dialog
                  //Get.back();

                  // Navigate to login screen
                  Get.offAll(() => Login());

                  // Show success snackbar
                  // Get.snackbar(
                  //   'Success',
                  //   'Successfully logged out',
                  //   snackPosition: SnackPosition.TOP,
                  //   backgroundColor: Colors.green,
                  //   duration: snackBarDuration, // Set the duration
                  // );
                },
              ),
            ],
          ),
        );
      });
    });
  }

  ///pdf:downlload...
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;
    return File(result.paths.first ?? '');
  }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }

  //final file = File('example.pdf');
  //await file.writeAsBytes(await pdf.save());

  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );

  ///dilog box
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
