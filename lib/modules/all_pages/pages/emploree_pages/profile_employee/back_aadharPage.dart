import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/static_text.dart';
import '../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';

class BackAadharpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedAdharImage = Rxn<Uint8List>(); // Use Rxn for nullable values
    var selectedAdhar2Image = Rxn<Uint8List>(); // Use Rxn for nullable values
    final ProfileEmployeeController _getprofileebnk = Get.put(ProfileEmployeeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Back Aadhar Card'),
      ),
      body: GestureDetector(
        onTap: () { Navigator.pop(context); },
        child: Center(
            child: Obx(() {
              return Container(
                child: Hero(
                  tag: 'aadharImg1',
                  child: selectedAdhar2Image.value != null
                      ? Image.memory(
                    selectedAdhar2Image.value!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  )
                      : (_getprofileebnk.getprofileemployeeModel?.data?.aadharTwo != null
                      ? Image.network(
                    "${FixedText.imageUrlll}${_getprofileebnk.getprofileemployeeModel?.data?.aadharTwo}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                        fit: BoxFit.contain,
                      );
                    },
                  )
                      : Image.asset(
                    'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
                    fit: BoxFit.contain,
                  )),
                ),
              );
            })
          // Hero(
          //   tag: 'aadharImg',
          //   child: Image.network(
          //     'https://cdn.pixabay.com/photo/2022/11/09/00/44/aadhaar-card-7579588_1280.png',
          //   ),
          // ),
        ),
      ),
    );
  }
}
