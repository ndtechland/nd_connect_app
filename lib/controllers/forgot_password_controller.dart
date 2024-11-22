import 'package:get/get.dart';
import 'package:nd_connect_techland/modules/all_pages/pages/login.dart';
import '../../services_apis/api_servicesss.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> forgotPassFormKey = GlobalKey<FormState>();
  final TextEditingController forgotEmailController = TextEditingController();
  final RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
   // ForgotPassword();
    // Initialize controllers, listeners, etc.
  }
  Future<void> ForgotPassword(BuildContext context) async {
    try{
      isLoading.value = false;
      final res = await ApiProvider.ForgotPasswordApi(
        //  context,
          forgotEmailController.text
      );
      if(res?.statusCode == 200){
        print("forgot pass contro 200");
        print("forgotPass contro:${res?.statusCode}");
        print("forgotPass contro:${res?.body}");

       // Get.to(()=>Login());
      }else {
        Get.snackbar('Error', 'Failed to forgot password. Please try again.',backgroundColor: Colors.red,colorText: Colors.white);
      }
    }catch(e){
      Get.snackbar('Error', '$e',backgroundColor: Colors.red,colorText: Colors.white);
    }
  }
  void forgotPasswordchange(BuildContext context) {
    if (forgotPassFormKey.currentState!.validate()) {
      forgotPassFormKey.currentState!.save();
      ForgotPassword(context); // Pass the context
    }
  }
}