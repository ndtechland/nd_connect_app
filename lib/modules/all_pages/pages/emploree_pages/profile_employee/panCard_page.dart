import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/static_text.dart';
import '../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
class PancardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedPanImage = Rxn<Uint8List>(); // Use Rxn for nullable values
    final ProfileEmployeeController _getprofileebnk = Get.put(ProfileEmployeeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Pan Card Image'),
      ),
      body: GestureDetector(
        onTap: () { Navigator.pop(context); },
        child: Center(
          child:Obx(() {
            return Hero(
              tag: 'panImg',
              child: selectedPanImage.value != null
                  ? Image.memory(
                selectedPanImage.value!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              )
                  : (_getprofileebnk.getprofileemployeeModel?.data?.panimg != null
                  ? Image.network(
                "${FixedText.imageUrlll}${_getprofileebnk.getprofileemployeeModel?.data?.panimg}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
                    fit: BoxFit.contain,
                  );
                },
              )
                  : Image.asset(
                'https://www.pngitem.com/pimgs/m/18-182217_pan-card-pan-card-with-cartoon-hd-png.png',
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
