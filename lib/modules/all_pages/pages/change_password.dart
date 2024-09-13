// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../components/responsive_text.dart';
// import '../../../components/styles.dart';
// import '../../../controllers/change_password_controllerss/change_password_user_controller.dart';
// import '../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
// import '../../../controllers/registrationss/registration_controller.dart';
// import '../../../widget/elevated_button.dart';
//
// class ChangePassword extends StatefulWidget {
//   ChangePassword({Key? key}) : super(key: key);
//
//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }
//
// class _ChangePasswordState extends State<ChangePassword> {
//   final ChangePasswordController _changepassuserController =
//       Get.put(ChangePasswordController());
//
//   final RegistrationController _registrationController =
//       Get.put(RegistrationController());
//
//   final EmployeeLoginController _employeeloginController =
//       Get.put(EmployeeLoginController());
//
//   final FocusNode _userFocusNode = FocusNode();
//   final FocusNode _userFocusNode2 = FocusNode();
//   final FocusNode _userFocusNode3 = FocusNode();
//
//   // FocusNode for User login
//   final FocusNode _employeeFocusNode = FocusNode();
//   final FocusNode _employeeFocusNode2 = FocusNode();
//
//   // FocusNode for Employee login
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         return LayoutBuilder(
//           builder: (context, constraints) {
//             return Scaffold(
//               backgroundColor: Colors.white,
//               body: Obx(
//                 () => (_changepassuserController.isLoading.value ||
//                         _employeeloginController.isLoading.value)
//                     ? Center(child: CircularProgressIndicator())
//                     : SingleChildScrollView(
//                         child: Center(
//                           child: Container(
//                             width: double.infinity,
//                             //height: size.height * 0.0,
//                             margin: const EdgeInsets.symmetric(
//                                 horizontal: 24, vertical: 30),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 20.0,
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 Container(
//                                     // height: size.height,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white, // Change color here
//                                     ),
//                                     child: buildUserLoginForm()),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//               ),
//               appBar: PreferredSize(
//                 preferredSize: Size.fromHeight(
//                     MediaQuery.of(context).size.width >
//                             MediaQuery.of(context).size.height
//                         ? MediaQuery.of(context).size.height *
//                             0.35 // Landscape mode
//                         : MediaQuery.of(context).size.height *
//                             0.2), // Portrait mode
//                 child: AppBar(
//                   //automaticallyImplyLeading: false,
//                   backgroundColor: logoColor,
//                   flexibleSpace: responsiveContainer(
//                     heightLandscape: size.height * 0.49,
//                     heightPortrait: size.height * 0.29,
//                     color: logoColor,
//                     context: context,
//                     child: Padding(
//                       padding: const EdgeInsets.all(9.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           logoImg(),
//                           responsiveText(
//                               text: 'User Change Password!',
//                               fontSizeLandscape: 19,
//                               fontSizePortrait: 20,
//                               color: Colors.white,
//                               context: context),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildUserLoginForm() {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Obx(
//         () => _changepassuserController.isLoading.value
//             ? Center(child: CircularProgressIndicator())
//             : Form(
//                 key: _changepassuserController.changepasswordFormKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   children: [
//                     PasswordTextField(
//                       hint: 'Old Password',
//                       //suffixIcon: Icons.lock,
//                       controller: _changepassuserController.passwordController1,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your Old password';
//                         }
//                         return null;
//                       },
//                       focusNode: _userFocusNode, // Assign FocusNode
//                     ),
//                     PasswordTextField(
//                       hint: 'Password',
//                       //suffixIcon: Icons.lock,
//                       controller: _changepassuserController.passwordController2,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                       focusNode: _userFocusNode2, // Assign FocusNode
//                     ),
//                     PasswordTextField(
//                       hint: 'Confirm Password',
//                       //suffixIcon: Icons.lock,
//                       controller: _changepassuserController.passwordController3,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Re enter your password';
//                         }
//                         if (value !=
//                             _changepassuserController
//                                 .passwordController2.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                       focusNode: _userFocusNode3, // Assign FocusNode
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         // MyTextButton(
//                         //   onPressed: () {
//                         //     Get.to(ForgotPassword());
//                         //   },
//                         //   text: 'Forgot Password',
//                         //   colors: appColor,
//                         // ),
//                       ],
//                     ),
//                     const SizedBox(height: 34),
//                     MyElevatedButton(
//                       onPressed: () {
//                         if (_changepassuserController
//                                 .changepasswordFormKey.currentState
//                                 ?.validate() ??
//                             false) {
//                           _changepassuserController
//                               .checkPasswordchange(context);
//                         }
//                       },
//                       text: Text('Update'),
//                       height: 40,
//                       width: 200,
//                     ),
//                     const SizedBox(height: 14),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
//
//   logoImg() {
//     return Image.asset(
//       'lib/assets/logo/hirelogo11.png',
//       width: 120,
//       height: 90,
//     );
//   }
// }
