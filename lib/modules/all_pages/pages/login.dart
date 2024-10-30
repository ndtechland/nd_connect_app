import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/registration_test.dart';
import 'package:nd_connect_techland/services_apis/get_server_key.dart';


import '../../../components/styles.dart';
import '../../../controllers/attendance_controller.dart';
import '../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../controllers/employeee_controllersss/employee_dashboard_controller/employee_dashboardcontroller.dart';
import '../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../../controllers/location_controller.dart';
import '../../../controllers/login_controllers/login_controllersss.dart';
import '../../../controllers/registrationss/registration_controller.dart';
import '../../../widget/elevated_button.dart';
import '../../../widget/text_btn.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _loginController = Get.put(LoginController());

  final RegistrationController _registrationController = Get.put(RegistrationController());

  final EmployeeLoginController _employeeloginController = Get.put(EmployeeLoginController());
  final LocationController locationController = Get.put(LocationController());
  final AttendanceController attendanceController = Get.put(AttendanceController());

  // FocusNode for User login
  final FocusNode _employeeFocusNode = FocusNode();
  final FocusNode _employeeFocusNode2 = FocusNode();

  // FocusNode for Employee login
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Obx(
                () => (_loginController.isLoading.value ||
                        _employeeloginController.isLoading.value)
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                        // color: Colors.pink,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 25,
                                child: SizedBox(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width , // Adjust width based on screen
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: appColor2,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60),bottomRight: Radius.circular(60))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30.0,left: 18),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          logoImg(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'Welcome to ND Connect',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20, fontFamily: 'medium'),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Text(
                                          //   'Login With Us.',
                                          //   style: TextStyle(
                                          //       color: Colors.white,
                                          //       fontSize: 17,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontFamily: 'medium'),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 200.0),
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 30),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [

                                      Container(
                                        height: 350, // Adjust as necessary
                                        child:
                                        // TabBarView(
                                        //   children: [
                                            //buildUserLoginForm(),
                                            buildEmployeeLoginForm(),
                                        //  ],
                                       // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              //appBar: _buildAppBar(),
            );
          },
        );
      },
    );
  }
  Widget buildEmployeeLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Obx(
        () => _employeeloginController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _employeeloginController.loginFormKey2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    'Login',
                    style: TextStyle(
                        color: appColor2,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'medium'),
                  ),
                    Container(
                      height: 5,
                      width: 50,
                      // color: appColor2,
                      decoration: BoxDecoration(
                        color: appColor2,
                        borderRadius: BorderRadius.circular(18)
                      ),
                    ),
                    textField2(
                      hint: 'Employee ID',

                      suffixIcon: Icons.person_outline,
                      controller: _employeeloginController.usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Employee ID';
                        }
                        return null;
                      },
                      focusNode: _employeeFocusNode, // Assign FocusNode
                    ),
                    PasswordTextField(
                      hint: 'Password',
                      //suffixIcon: Icons.lock,
                      controller: _employeeloginController.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      focusNode: _employeeFocusNode2, // Assign FocusNode
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyTextButton(
                          onPressed: () {
                            Get.to(ForgotPassword());
                          },
                          text: 'Forgot Password',
                          colors: appColor2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: appColor2,
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: TextButton(
                            onPressed: () async{
                          if (_employeeloginController.loginFormKey2.currentState
                              ?.validate() ??
                              false) {
                           // await _profileEmployeeController.profileemployeeApi();
                           await _employeeloginController.checkemployeeLogin();
                           // await _homedashboardController.dashboarddApi();
                            GetServerKey getServerKey = GetServerKey();
                            String accessToken = await getServerKey.GetServerKeyToken();
                            print("server keyyy:$accessToken");
                          }

                          await attendanceController.EmpActivityApi();
                          print("attendance activity:${attendanceController.attendanceActivityModel?.data?.checkIn}");
                        }, child: Text('Login',style: TextStyle(color: Colors.white),),),
                      ),
                    ),

                    const SizedBox(height: 34),
                  ],
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
     //   flexibleSpace: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        height: 220,
        //MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
        decoration: BoxDecoration(
          color: logoColor
          //   gradient: LinearGradient(
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
          // colors: [
          //   appColor2,
          //   appColor,
          //   //appColor
          // ],
       // )
    ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            // SizedBox(
            //   height: 15,
            // ),
            logoImg(),
            const Text(
              'Welcome to ND Connect',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'medium'),
            ),
            Text(
              'Login With Us.'.toUpperCase(),
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
      width: 80,
      height: 80,
      decoration: BoxDecoration(shape: BoxShape.circle,
      color: Colors.white),
      child: Image.asset(
        'lib/assets/images/logoo.png',
        // fit: BoxFit.contain,
        width: 60,
        height: 60,
      ),
    );
  }
}
