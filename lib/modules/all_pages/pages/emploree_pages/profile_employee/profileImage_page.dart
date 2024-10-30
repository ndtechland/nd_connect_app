import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/static_text.dart';
import '../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
class ProfileImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedPanImage = Rxn<Uint8List>(); // Use Rxn for nullable values
    final ProfileEmployeeController _getprofileebnk = Get.put(ProfileEmployeeController());
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile Image'),
      // ),
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () { Navigator.pop(context); },
        child: Center(
          child:Obx(() {
            return Hero(
              tag: 'profileImg',
              child: selectedPanImage.value != null
                  ? Image.memory(
                selectedPanImage.value!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              )
                  : (_getprofileebnk.getprofileemployeeModel?.data?.empProfile != null
                  ? Image.network(
                "${FixedText.imageUrlll}${_getprofileebnk.getprofileemployeeModel?.data?.empProfile}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png',
                    fit: BoxFit.contain,
                  );
                },
              )
                  : Image.asset(
                'https://e7.pngegg.com/pngimages/81/570/png-clipart-profile-logo-computer-icons-user-user-blue-heroes-thumbnail.png',
                fit: BoxFit.contain,
              )),
            );
          }),
          // Hero(
          //   tag: 'panImg',
          //   child: Image.network(
          //     'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
          //   ),
          // ),
        ),
      ),
    );
  }
}
