import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constants/static_text.dart';
import '../../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
class ChequePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var selectedChequeImage = Rxn<Uint8List>(); // Use Rxn for nullable values
    final ProfileEmployeeController _getprofileebnk = Get.put(ProfileEmployeeController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Cheque'),
      ),
      body: GestureDetector(
        onTap: () { Navigator.pop(context); },
        child: Center(
          child: Obx(() {
            return Hero(
              tag: 'chequeImg',
              child: selectedChequeImage.value != null
                  ? Image.memory(
                selectedChequeImage.value!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              )
                  : (_getprofileebnk.getbankprofiledetail!.data!.chequeimage != null
                  ? Image.network(
                "${FixedText.imageUrlll}${_getprofileebnk.getbankprofiledetail!.data!.chequeimage}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://media.geeksforgeeks.org/wp-content/uploads/20230711180739/Date-the-Cheque.jpg',
                    fit: BoxFit.contain,
                  );
                },
              )
                  : Image.asset(
                'https://media.geeksforgeeks.org/wp-content/uploads/20230711180739/Date-the-Cheque.jpg',
                fit: BoxFit.contain,
              )),
            );
          }),
        ),
      ),
    );
  }
}
