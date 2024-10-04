import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nd_connect_techland/controllers/forgot_password_controller.dart';


import '../../../components/styles.dart';
import '../../../widget/custom_loader.dart';
import '../../../widget/elevated_button.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'ForgotPassword';

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      // Obx(()=>
      //     Form(
      //       key: forgotPasswordController.forgotPassFormKey,
      //     child:
          _buildBody(),
          //)),
      appBar: _buildAppBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(180),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: _buildHeader(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: _buildLoginDetail(),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: const BoxDecoration(
          color:appColor2,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoImg(),
            const Text(
              'Forgot Password',
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontFamily: 'medium'),
            ),
          ],
        ));
  }

  Widget _buildLoginDetail() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              )
            ]),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: TextFormField(
                      controller: forgotPasswordController.forgotEmailController,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        hintStyle: (TextStyle(
                          fontSize: 13,
                        )),
                        labelStyle: const TextStyle(
                            color: Colors.black54, fontSize: 13),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: appColor),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                //  textFielddd('Email Address', Icons.mail_outline),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            MyElevatedButton(
                onPressed: () async {
                  print("forgot pass");
                  // Get.dialog(CustomThreeInOutLoader(),
                  //     barrierDismissible: false);

                 // if (forgotPasswordController.forgotPassFormKey.currentState?.validate() ?? false) {
                 await forgotPasswordController.ForgotPassword(context);
                 // Get.back();

                // }
                  print("forgot pass done");

                  //Get.offAll(Login());
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Login()));
                },
                text: const Icon(Icons.arrow_forward,color: Colors.white,),
                height: 40,
                width: 40),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  textFielddd(hint, icn) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          suffixIcon: Icon(
            icn,
            size: 23,
            color: Colors.black12,
          ),
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 15),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: appColor),
          ),
        ),
      ),
    );
  }
  logoImg() {
    return Container(
      // width: 120,
      // height: 90,
      // decoration: BoxDecoration(shape: BoxShape.circle,
      // color: Colors.white),
      child: Image.asset(
        'lib/assets/images/logoo.png',
        fit: BoxFit.contain,
        width: 60,
        height: 60,
      ),
    );
  }
}
