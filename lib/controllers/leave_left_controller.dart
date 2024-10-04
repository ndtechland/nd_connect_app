import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveLeftController extends GetxController{
  var typeOfLeave = ''.obs;
  var leaveLeft = ''.obs;
  final allLeave = <LeaveLeftData>[
    LeaveLeftData(leftLeave: '2',leaveType: 'Monthly' ),
    LeaveLeftData(leftLeave: '6',leaveType: 'Sick Leave' ,),
    LeaveLeftData(leftLeave: '4',leaveType: 'Casual Leave' ,),
    LeaveLeftData(leftLeave: '12',leaveType: 'Paid Leave' ,),
    LeaveLeftData(leftLeave: '18',leaveType: 'Yearly' ,),
  ];
  void fetchLeaveLeft() {
    Map<String,String> dummy ={
      'Monthly' :"2",
      'Sick Leave' :"2",
      'Casual Leave' :"2",
      'Paid Leave' :"2",
      'Medical' :"2",
      'Yearly' :"2",
    };
    //typeOfLeave.value = dummy
  }
}
class LeaveLeftData {
  final String leaveType;
  final String leftLeave;

  LeaveLeftData({required this.leaveType,required this.leftLeave,});
}