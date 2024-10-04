// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:hirejobindia/constants/themes/theme_colors.dart';
// // import 'package:hirejobindia/controllers/drower_home_controller/drower_home_controller.dart';
// // import 'package:hirejobindia/controllers/nav_bar_controller/nav_controller.dart';
// // import 'package:hirejobindia/modules/drawer_home/drower_page_class.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   BottomNavigationBarController _bottomNavigationBarController =
// //       Get.put(BottomNavigationBarController());
// //   NavController _navcontroller = Get.put(NavController(), permanent: true);
// //
// //   GlobalKey<ScaffoldState> _key = new GlobalKey();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     return Scaffold(
// //       backgroundColor: AppColors.jobbluegray,
// //       key: _key,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.jobbluegray,
// //         elevation: 0,
// //         title: SizedBox(
// //           height: size.height * 0.05,
// //           width: size.width * 0.6,
// //           child: TextField(
// //             decoration: InputDecoration(
// //               prefixIcon: Icon(
// //                 Icons.search,
// //                 color: AppColors.greyColor,
// //               ),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(30.0),
// //                 borderSide: BorderSide.none, // Remove the border color
// //               ),
// //               filled: true,
// //               hintStyle: TextStyle(
// //                 color: Colors.grey[800],
// //                 // Modify the style of the hint text here
// //                 fontSize: 13.0, // Example font size
// //               ),
// //               hintText: "Search jobs here",
// //               fillColor: AppColors.white,
// //               contentPadding: EdgeInsets.symmetric(
// //                   vertical: 12.0, horizontal: 16.0), // Add content padding
// //             ),
// //             textAlign: TextAlign.left, // Align the input text to center
// //             style: TextStyle(
// //               // You can also modify the style of the entered text here
// //               fontSize: 16.0, // Example font size
// //             ),
// //           ),
// //         ),
// //
// //         //Text('Home'),
// //         centerTitle: true,
// //         leading: InkWell(
// //             onTap: () {
// //               /// Get.to(LoginEmailPage());
// //               _key.currentState!.openDrawer();
// //             },
// //             child: Icon(
// //               Icons.menu,
// //               color: AppColors.greyColor,
// //             )),
// //         actions: [
// //           Icon(
// //             Icons.notifications,
// //             color: AppColors.greyColor,
// //           ),
// //         ],
// //       ),
// //       drawer: MainAmbrbDrawer(),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               Container(
// //                 height: size.height * 0.17,
// //                 //width: size.width * 0.3,
// //                 decoration: BoxDecoration(color: AppColors.whiteColor),
// //                 child: ListView.builder(
// //                     scrollDirection:
// //                         Axis.horizontal, // Set scroll direction to horizontal
// //                     itemCount: 5,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(7.0),
// //                         child: Material(
// //                           elevation: 1,
// //                           child: Container(
// //                             //height: size.height * 0.05,
// //                             //width: size.width * 0.6,
// //                             decoration: BoxDecoration(
// //                               color: AppColors.jobgray,
// //                             ),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               crossAxisAlignment: CrossAxisAlignment.center,
// //                               children: [
// //                                 SizedBox(
// //                                   height: size.height * 0.09,
// //                                   width: size.width * 0.2,
// //                                   child: Column(
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: [
// //                                       Container(
// //                                         height: size.height * 0.09,
// //                                         width: size.width * 0.2,
// //                                         decoration: BoxDecoration(
// //                                           color: AppColors.jobbrown,
// //                                           shape: BoxShape.circle,
// //                                         ),
// //                                         child: Icon(Icons.account_circle),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 SizedBox(
// //                                   width: size.width * 0.03,
// //                                 ),
// //                                 SizedBox(
// //                                   height: size.height * 0.09,
// //                                   width: size.width * 0.45,
// //                                   child: Column(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceAround,
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [
// //                                       Text(
// //                                         'Name',
// //                                         style: TextStyle(
// //                                           fontSize: size.width * 0.04,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                       Text(
// //                                         'Update 6 hrs ago',
// //                                         style: TextStyle(
// //                                           fontSize: size.width * 0.03,
// //                                           // fontWeight: FontWeight.,
// //                                           color: Colors.grey,
// //                                         ),
// //                                       ),
// //                                       Text(
// //                                         'View profile',
// //                                         style: TextStyle(
// //                                           fontSize: size.width * 0.035,
// //                                           color: Colors.blue,
// //                                           fontWeight: FontWeight.w600,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //               ),
// //               SizedBox(
// //                 height: size.height * 0.02,
// //               ),
// //               Container(
// //                   height: size.height * 0.055,
// //                   //width: size.width * 0.3,
// //                   decoration: BoxDecoration(color: AppColors.jobbluegray),
// //                   child: Padding(
// //                     padding:
// //                         EdgeInsets.symmetric(horizontal: size.width * 0.03),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           'Jobs based on your\napplies (120)',
// //                           style: TextStyle(
// //                             fontSize: size.width * 0.045,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           'View all',
// //                           style: TextStyle(
// //                             fontSize: size.width * 0.035,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.blue,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   )),
// //               SizedBox(
// //                 height: size.height * 0.02,
// //               ),
// //               Container(
// //                 height: size.height * 0.23,
// //                 // width: size.width * 0.4,
// //                 decoration: BoxDecoration(color: AppColors.whiteColor),
// //                 child: ListView.builder(
// //                     scrollDirection:
// //                         Axis.horizontal, // Set scroll direction to horizontal
// //                     itemCount: 5,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(7.0),
// //                         child: Material(
// //                           elevation: 1,
// //                           borderRadius: BorderRadius.circular(10),
// //                           child: Container(
// //                             //height: size.height * 0.1,
// //                             width: size.width * 0.7,
// //                             decoration: BoxDecoration(
// //                               color: AppColors.jobgray,
// //                               border: Border.all(color: AppColors.jobgray),
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 SizedBox(
// //                                   height: size.height * 0.06,
// //                                   width: size.width * 0.18,
// //                                   child: Padding(
// //                                     padding: EdgeInsets.symmetric(
// //                                         horizontal: size.width * 0.02),
// //                                     child: Container(
// //                                       height: size.height * 0.07,
// //                                       width: size.width * 0.15,
// //                                       decoration: BoxDecoration(
// //                                         color: AppColors.jobbrown,
// //                                         //shape: BoxShape.circle,
// //                                         borderRadius: BorderRadius.circular(10),
// //                                       ),
// //                                       child: Icon(Icons.business_outlined),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Padding(
// //                                   padding: EdgeInsets.symmetric(
// //                                       horizontal: size.width * 0.02),
// //                                   child: SizedBox(
// //                                     height: size.height * 0.13,
// //                                     width: size.width * 0.45,
// //                                     child: Column(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                       children: [
// //                                         Text(
// //                                           'Flutter Developer',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.04,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                         Text(
// //                                           'Posted by Aperiron Management',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.03,
// //                                             // fontWeight: FontWeight.,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                         Text(
// //                                           'Noida (sector-142 Noida)',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.03,
// //                                             // fontWeight: FontWeight.,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                         SizedBox(
// //                                           height: size.height * 0.02,
// //                                         ),
// //                                         Text(
// //                                           '1d ago',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.03,
// //                                             // fontWeight: FontWeight.,
// //                                             color: Colors.grey,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //               ),
// //               SizedBox(
// //                 height: size.height * 0.02,
// //               ),
// //               Container(
// //                   height: size.height * 0.055,
// //                   //width: size.width * 0.3,
// //                   decoration: BoxDecoration(color: AppColors.jobbluegray),
// //                   child: Padding(
// //                     padding:
// //                         EdgeInsets.symmetric(horizontal: size.width * 0.03),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Text(
// //                           'Jobs based on your\nprofile (12)',
// //                           style: TextStyle(
// //                             fontSize: size.width * 0.045,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                         Text(
// //                           'View all',
// //                           style: TextStyle(
// //                             fontSize: size.width * 0.035,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.blue,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   )),
// //               SizedBox(
// //                 height: size.height * 0.02,
// //               ),
// //               Container(
// //                 height: size.height * 0.23,
// //                 // width: size.width * 0.4,
// //                 decoration: BoxDecoration(color: AppColors.whiteColor),
// //                 child: ListView.builder(
// //                     scrollDirection:
// //                         Axis.horizontal, // Set scroll direction to horizontal
// //                     itemCount: 5,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(7.0),
// //                         child: Material(
// //                           elevation: 1,
// //                           borderRadius: BorderRadius.circular(10),
// //                           child: Container(
// //                             //height: size.height * 0.1,
// //                             width: size.width * 0.7,
// //                             decoration: BoxDecoration(
// //                               color: AppColors.jobgray,
// //                               border: Border.all(color: AppColors.jobgray),
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                             child: Column(
// //                               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 SizedBox(
// //                                   height: size.height * 0.06,
// //                                   width: size.width * 0.18,
// //                                   child: Padding(
// //                                     padding: EdgeInsets.symmetric(
// //                                         horizontal: size.width * 0.02),
// //                                     child: Container(
// //                                       height: size.height * 0.06,
// //                                       width: size.width * 0.15,
// //                                       decoration: BoxDecoration(
// //                                         color: AppColors.jobbrown,
// //                                         //shape: BoxShape.circle,
// //                                         borderRadius: BorderRadius.circular(10),
// //                                       ),
// //                                       child: Icon(Icons.business_outlined),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 Padding(
// //                                   padding: EdgeInsets.symmetric(
// //                                       horizontal: size.width * 0.02),
// //                                   child: SizedBox(
// //                                     height: size.height * 0.12,
// //                                     width: size.width * 0.45,
// //                                     child: Column(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                       children: [
// //                                         Text(
// //                                           'Software Developer',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.04,
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                         Text(
// //                                           'Posted by oxford Management',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.03,
// //                                             // fontWeight: FontWeight.,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                         Text(
// //                                           'Noida (sector-12 Noida)',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.03,
// //                                             // fontWeight: FontWeight.,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                         SizedBox(
// //                                           height: size.height * 0.02,
// //                                         ),
// //                                         Text(
// //                                           '2d ago',
// //                                           style: TextStyle(
// //                                             fontSize: size.width * 0.03,
// //                                             // fontWeight: FontWeight.,
// //                                             color: Colors.grey,
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class BusinessScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Business'),
// //       ),
// //       body: Center(
// //         child: Text('Business Screen'),
// //       ),
// //     );
// //   }
// // }
// //
// // class SchoolScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('School'),
// //       ),
// //       body: Center(
// //         child: Text('School Screen'),
// //       ),
// //     );
// //   }
// // }
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// // import 'package:ps_welness/constants/constants/constants.dart';
// // import 'package:ps_welness/controllers/login_email/login_email_controller.dart';
// // import 'package:ps_welness/modules_view/circular_loader/circular_loaders.dart';
// // import 'package:ps_welness/modules_view/forget_password_view/forget_password_view.dart';
// // import 'package:ps_welness/widgets/widgets/neumorphic_text_field_container.dart';
// // import 'package:ps_welness/widgets/widgets/rectangular_button.dart';
//
// class Credentials extends StatefulWidget {
//   Credentials({Key? key}) : super(key: key);
//
//   @override
//   State<Credentials> createState() => _CredentialsState();
// }
//
// ///todo: this is the main state for login status.....
//
// class _CredentialsState extends State<Credentials> {
//   final LoginpasswordController _loginpasswordController =
//   Get.put(LoginpasswordController());
//   NotificationServices notificationServices = NotificationServices();
//   // DriverPayoutHistoryController _driverPayoutHistoryController =
//   // Get.put(DriverPayoutHistoryController());
//   String userId = ''.toString();
//
//   RxBool isChecked = false.obs; // Track the checkbox state
//
//   ///implement firebase.......27..september..2023...........
//   @override
//   void initState() {
//     super.initState();
//     notificationServices.requestNotificationPermission();
//     notificationServices.forgroundMessage();
//     notificationServices.firebaseInit(context);
//     notificationServices.setupInteractMessage(context);
//     notificationServices.isTokenRefresh();
//     // notificationServices.requestNotificationPermission();
//     // notificationServices.isTokenRefresh();
//     // notificationServices.firebaseInit();
//     notificationServices.getDeviceToken().then((value) {
//       if (kDebugMode) {
//         print('device token');
//         print(value);
//       }
//       // print('device token');
//       // print(value);
//     });
//
//     /// 1. This method call when app in terminated state and you get a notification
//     /// when you click on notification app open from terminated state and you can get notification data in this method
//
//     FirebaseMessaging.instance.getInitialMessage().then(
//           (message) {
//         print("FirebaseMessaging.instance.getInitialMessage");
//         if (message != null) {
//           print("New Notification");
//
//           // if (message.data['_id'] != null) {
//           //   Navigator.of(context).push(
//           //     MaterialPageRoute(
//           //       builder: (context) => DemoScreen(
//           //         id: message.data['_id'],
//           //       ),
//           //     ),
//           //   );
//           // }
//         }
//       },
//     );
//     // 2. This method only call when App in forground it mean app must be opened
//     FirebaseMessaging.onMessage.listen(
//           (message) {
//         print("FirebaseMessaging.onMessage.listen");
//         if (message.notification != null) {
//           print(message.notification!.title);
//           print(message.notification!.body);
//           print("message.data11 ${message.data}");
//
//           ///you can call local notification....
//           LocalNotificationService.createanddisplaynotification(message);
//         }
//       },
//     );
//     // 3. This method only call when App in background and not terminated(not closed)
//     FirebaseMessaging.onMessageOpenedApp.listen(
//           (message) {
//         print("FirebaseMessaging.onMessageOpenedApp.listen");
//         if (message.notification != null) {
//           print(message.notification!.title);
//           print(message.notification!.body);
//           print("message.data22 ${message.data['_id']}");
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Form(
//       key: _loginpasswordController.loginpasswordformkey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.09, vertical: size.height * 0.02),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             NeumorphicTextFieldContainer(
//               child: TextFormField(
//                 controller: _loginpasswordController.emailController,
//                 onSaved: (value) {
//                   _loginpasswordController.email = value!;
//                 },
//                 validator: (value) {
//                   return _loginpasswordController.validEmail(value!);
//                 },
//                 cursorColor: Colors.black,
//                 obscureText: false,
//                 decoration: InputDecoration(
//                   hintText: 'User ID',
//                   helperStyle: TextStyle(
//                     color: black.withOpacity(0.7),
//                     fontSize: 18,
//                   ),
//                   prefixIcon: Icon(
//                     Icons.account_circle,
//                     color: black.withOpacity(0.7),
//                     size: 20,
//                   ),
//                   border: InputBorder.none,
//                 ),
//                 keyboardType: TextInputType.visiblePassword,
//                 //obscureText: true,
//                 //controller: _loginpasswordController.mobileController,
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.02,
//             ),
//
//             ///
//             NeumorphicTextFieldContainer(
//               child: TextFormField(
//                 controller: _loginpasswordController.passwordController,
//                 onSaved: (value) {
//                   _loginpasswordController.password = value!;
//                 },
//                 validator: (value) {
//                   return _loginpasswordController.validPassword(value!);
//                 },
//                 cursorColor: Colors.black,
//                 obscureText: false,
//                 decoration: InputDecoration(
//                   hintText: 'Password',
//                   helperStyle: TextStyle(
//                     color: black.withOpacity(0.7),
//                     fontSize: 18,
//                   ),
//                   prefixIcon: Icon(
//                     Icons.lock,
//                     color: black.withOpacity(0.7),
//                     size: 20,
//                   ),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//
//             ///
//
//             // RectangularInputField(
//             //   hintText: 'Password',
//             //   icon: Icons.lock,
//             //   obscureText: true,
//             // ),..
//
//             ///
//
//             SizedBox(
//               height: size.height * 0.00,
//               //appPadding / 2,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: InkWell(
//                 onTap: () {
//                   Get.to(() => ForgotPassword());
//                 },
//                 child: Text(
//                   'Forget Password?',
//                   style: GoogleFonts.alegreya(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.grey.shade700,
//                     fontSize: size.width * 0.035,
//                   ),
//                 ),
//               ),
//             ),
//
//             ///todo:check box....29 apr 2024..
//             // Row(
//             //   crossAxisAlignment: CrossAxisAlignment.center,
//             //   mainAxisAlignment: MainAxisAlignment.start,
//             //   children: [
//             //     Align(
//             //       alignment: Alignment.topLeft,
//             //       child: Obx(
//             //         () => Checkbox(
//             //           value: _loginpasswordController.isChecked.value,
//             //           onChanged: _loginpasswordController.toggleCheckbox,
//             //           activeColor: Colors.white,
//             //           focusColor: Colors.red,
//             //           checkColor: Colors.teal.shade700,
//             //           // fillColor: ,
//             //         ),
//             //       ),
//             //     ),
//             //     Text(
//             //       'I agree to the terms and conditions',
//             //       style: GoogleFonts.roboto(
//             //         fontSize: size.height * 0.015,
//             //         //letterSpacing: 1,
//             //         fontWeight: FontWeight.w500,
//             //         color: Colors.green.shade900,
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             ///
//
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Obx(
//                         () => Checkbox(
//                       value: _loginpasswordController.isChecked.value,
//                       onChanged: (value) {
//                         isChecked.value = value ?? false;
//                         _loginpasswordController.toggleCheckbox(value ?? false);
//                       },
//                       activeColor: Colors.white,
//                       focusColor: Colors.red,
//                       checkColor: Colors.teal.shade700,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'I agree to the terms and conditions',
//                   style: GoogleFonts.roboto(
//                     fontSize: size.height * 0.015,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.green.shade900,
//                   ),
//                 ),
//               ],
//             ),
//             // Align(
//             //   alignment: Alignment.centerRight,
//             //   child: InkWell(
//             //     onTap: () {
//             //
//             //       Get.to(() => ChangePassword());
//             //     },
//             //     child: Text(
//             //       'Change Password?',
//             //       style: GoogleFonts.alegreya(
//             //         fontWeight: FontWeight.w600,
//             //         color: Colors.grey.shade700,
//             //         fontSize: size.width * 0.035,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             RectangularButton(
//               text: 'Sign In',
//               press: () {
//                 if (isChecked.value) {
//                   // Only proceed if the checkbox is checked
//                   _loginpasswordController.checkLoginpassword();
//                 } else {
//                   Get.snackbar(
//                     'Error',
//                     'Please agree to the terms and conditions',
//                     backgroundColor: Colors.red,
//                     colorText: Colors.white,
//                     duration: Duration(seconds: 2), // Set duration to 2 seconds
//                   );
//                   // Show a message indicating the checkbox needs to be checked
//                   // You can use Get.snackbar or any other method to show the message
//                   // Example: Get.snackbar('Error', 'Please agree to the terms and conditions');
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<Position> _getGeoLocationPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     await Future.delayed(Duration(seconds: 2));
//     await Get.dialog(
//       // bool barrierDismissible = true
//
//       AlertDialog(
//         title: const Text('Ps Wellness'),
//         content: const Text(
//             """When you grant permission for  location access in our application, we may collect and process certain information related to your geographical location. This includes GPS coordinates, Wi-Fi network information, cellular tower data, Background Location, and other relevant data sources to determine your device's location."""),
//         actions: [
//           TextButton(
//             child: const Text("Reject"),
//             onPressed: () => Get.back(),
//           ),
//           TextButton(
//             child: const Text("Accept"),
//             onPressed: () => Get.back(),
//           ),
//         ],
//       ),
//       barrierDismissible: false,
//     );
//
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // return Future.value('');
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await Geolocator.openLocationSettings();
//
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
// }