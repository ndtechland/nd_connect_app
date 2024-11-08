import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../components/responsive_text.dart';
import '../../../../components/styles.dart';
import '../../../../controllers/change_password_employee_controller/change_password_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../../../controllers/registrationss/registration_controller.dart';
import '../../../../widget/elevated_button.dart';
import '../../../bottom_bar/bottom_bar.dart';

class ChangeEmployeePassword extends StatefulWidget {
  ChangeEmployeePassword({Key? key}) : super(key: key);

  @override
  State<ChangeEmployeePassword> createState() => _ChangeEmployeePasswordState();
}

class _ChangeEmployeePasswordState extends State<ChangeEmployeePassword> {
  final ChangePasswordEmployeeController _changepassempController =
      Get.put(ChangePasswordEmployeeController());

  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  final EmployeeLoginController _employeeloginController =
      Get.put(EmployeeLoginController());

  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _userFocusNode2 = FocusNode();
  final FocusNode _userFocusNode3 = FocusNode();

  // FocusNode for User login
  final FocusNode _employeeFocusNode = FocusNode();
  final FocusNode _employeeFocusNode2 = FocusNode();
  bool obscureText1 = true;

  void _toggleVisibility1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }
 bool obscureText2 = true;

  void _toggleVisibility2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
  }

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
                () => (_changepassempController.isLoading.value ||
                        _employeeloginController.isLoading.value)
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Form(
                          key: _changepassempController.changepasswordemployeeFormKey,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Your new password must be different from previous used passwords.",
                                      style:TextStyle(
                                          fontSize: 16
                                      )),
                                  SizedBox(height: 20,),
                                  Text("Old Password",
                                      style:TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black87
                                      )),
                                  SizedBox(height: 10,),
                                  Container(
                                    decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black54,width: 1),
                                      borderRadius: BorderRadius.circular(10.0)
                                    ) ,
                                    padding: EdgeInsets.only(left: 14),
                                    child: TextFormField(
                                      controller: _changepassempController.passwordController1,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Old Password',
                                        hintStyle: TextStyle(fontSize: 14)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Text("New Password",
                                      style:TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black87
                                      )),
                                  SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.only(left: 14),
                                child: TextFormField(
                                  controller: _changepassempController.passwordController2,
                                  obscureText: obscureText1,
                                  decoration: InputDecoration( // Remove const here
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        obscureText1 ? Icons.visibility_off : Icons.visibility,
                                        color: obscureText1 ? Colors.red : Colors.green,
                                      ),
                                      onPressed: _toggleVisibility1,
                                    ),
                                    hintText: 'New Password',
                                    hintStyle: TextStyle(fontSize: 14),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                  focusNode: _userFocusNode2,
                                ),
                              ),
                                  SizedBox(height: 5,),
                                  Text("Must be atleats 8 characters",
                                      style:TextStyle(
                                          fontSize: 12,color: Colors.black45,fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: 20,),
                                  Text("Confirm Password",
                                      style:TextStyle(
                                          fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black87
                                      )),
                                  SizedBox(height: 10,),
                                  Container(
                                    decoration:BoxDecoration(
                                      border: Border.all(color: Colors.black54,width: 1),
                                      borderRadius: BorderRadius.circular(10.0)
                                    ) ,
                                    padding: EdgeInsets.only(left: 14),
                                    child: TextFormField(
                                      controller: _changepassempController.passwordController3,
                                      obscureText: obscureText2,
                                      decoration:  InputDecoration(
                                        border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              obscureText2 ? Icons.visibility_off : Icons.visibility,
                                              color: obscureText2 ? Colors.red : Colors.green,
                                            ),
                                            onPressed: _toggleVisibility2,
                                          ),
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Re enter your password';
                                        }
                                        if (value !=
                                            _changepassempController.passwordController2.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                      focusNode: _userFocusNode3,
                                    ),
                                  ),
                                  SizedBox(height: 20,),

                                  Center(
                                    child: MyElevatedButton(
                                      onPressed: () {
                                        print("changePass");

                                        if (_changepassempController
                                            .changepasswordemployeeFormKey.currentState
                                            ?.validate() ??
                                            false) {
                                          _changepassempController.checkPasswordchange(context);
                                        }
                                        print("changePass done");

                                      },
                                      text: Text('Update',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17
                                        ),),
                                      height: 40,
                                      width: 200,
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    //height: size.height * 0.0,
                                    // margin: const EdgeInsets.symmetric(
                                    //     horizontal: 24, vertical: 30),
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
                                    child: Column(
                                      children: [

                                        Container(
                                            // height: size.height,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white, // Change color here
                                            ),
                                            child: Container()
                                         //   buildUserLoginForm()
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              appBar:
              // PreferredSize(
              //   preferredSize: Size.fromHeight(
              //       MediaQuery.of(context).size.width >
              //               MediaQuery.of(context).size.height
              //           ? MediaQuery.of(context).size.height *
              //               0.35 // Landscape mode
              //           : MediaQuery.of(context).size.height *
              //               0.2), // Portrait mode
              //   child:
            AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.white,),
                    onPressed: (){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>BottomBar()));
                    },
                  ),
                  // automaticallyImplyLeading: false,
                  backgroundColor: appColor2,
                  title: Text("Create New Password",style: TextStyle(
                    color: Colors.white,
                  ),),
                  centerTitle: true,
                  // flexibleSpace: responsiveContainer(
                  //   heightLandscape: size.height * 0.49,
                  //   heightPortrait: size.height * 0.29,
                  //   color: logoColor,
                  //   context: context,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(9.0),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         logoImg(),
                  //         SizedBox(
                  //           height: 10,
                  //         ),
                  //         responsiveText(
                  //             text: 'Change Password!',
                  //             fontSizeLandscape: 19,
                  //             fontSizePortrait: 20,
                  //             color: Colors.white,
                  //             context: context),
                  //       ],
                  //     ),
                  //   ),
                 // ),
                ),
            //  ),
            );
          },
        );
      },
    );
  }

  Widget buildUserLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Obx(
        () => _changepassempController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _changepassempController.changepasswordemployeeFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    PasswordTextField(
                      hint: 'Old Password',
                      //suffixIcon: Icons.lock,
                      controller: _changepassempController.passwordController1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Old password';
                        }
                        return null;
                      },
                      focusNode: _userFocusNode, // Assign FocusNode
                    ),
                    PasswordTextField(
                      hint: 'Password',
                      //suffixIcon: Icons.lock,
                      controller: _changepassempController.passwordController2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      focusNode: _userFocusNode2, // Assign FocusNode
                    ),
                    PasswordTextField(
                      hint: 'Confirm Password',
                      //suffixIcon: Icons.lock,
                      controller: _changepassempController.passwordController3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Re enter your password';
                        }
                        if (value !=
                            _changepassempController.passwordController2.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      focusNode: _userFocusNode3, // Assign FocusNode
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // MyTextButton(
                        //   onPressed: () {
                        //     Get.to(ForgotPassword());
                        //   },
                        //   text: 'Forgot Password',
                        //   colors: appColor,
                        // ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    MyElevatedButton(
                      onPressed: () {
                        print("changePass");

                        if (_changepassempController
                                .changepasswordemployeeFormKey.currentState
                                ?.validate() ??
                            false) {
                          _changepassempController.checkPasswordchange(context);
                        }
                        print("changePass done");

                      },
                      text: Text('Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17
                      ),),
                      height: 40,
                      width: 200,
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
      ),
    );
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
        width: 120,
        height: 90,
      ),
    );
  }
}
