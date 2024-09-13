import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  var currentTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateTime();
  }

  void updateTime() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      currentTime.value = DateFormat('h:mm a').format(DateTime.now()); // 12-hour format with AM/PM
    });
  }
}

class TimeDisplay extends StatelessWidget {
  final DateTimeController timeController = Get.put(DateTimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Time'),
      ),
      body: Center(
        child: Obx(
              () => Text(
            timeController.currentTime.value,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}