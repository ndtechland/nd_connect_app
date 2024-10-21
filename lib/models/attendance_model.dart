// To parse this JSON data, do
//
//     final attendanceDetailsModel = attendanceDetailsModelFromJson(jsonString);

import 'dart:convert';

AttendanceDetailsModel attendanceDetailsModelFromJson(String str) => AttendanceDetailsModel.fromJson(json.decode(str));

String attendanceDetailsModelToJson(AttendanceDetailsModel data) => json.encode(data.toJson());

class AttendanceDetailsModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  AttendanceData? data;

  AttendanceDetailsModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory AttendanceDetailsModel.fromJson(Map<String, dynamic> json) => AttendanceDetailsModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : AttendanceData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class AttendanceData {
  String? officeHour;
  String? checkInTime;
  String? checkOutTime;
  String? startOverTime;
  String? finishOverTime;
  String? totalWorkingHours;
  String? monthlyWorkingHours;
  String? presencepercentage;
  String? absencepercentage;
  String? overtimeWorkingHours;
  String? currentdate;
  String? loginStatus;
  List<Loginactivity>? loginactivities;

  AttendanceData({
    this.officeHour,
    this.checkInTime,
    this.checkOutTime,
    this.startOverTime,
    this.finishOverTime,
    this.totalWorkingHours,
    this.monthlyWorkingHours,
    this.presencepercentage,
    this.absencepercentage,
    this.overtimeWorkingHours,
    this.currentdate,
    this.loginStatus,
    this.loginactivities,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
    officeHour: json["officeHour"],
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"],
    startOverTime: json["startOverTime"],
    finishOverTime: json["finishOverTime"],
    totalWorkingHours: json["totalWorkingHours"],
    monthlyWorkingHours: json["monthlyWorkingHours"],
    presencepercentage: json["presencepercentage"],
    absencepercentage: json["absencepercentage"],
    overtimeWorkingHours: json["overtimeWorkingHours"],
    currentdate: json["currentdate"],
    loginStatus: json["loginStatus"],
    loginactivities: json["loginactivities"] == null ? [] : List<Loginactivity>.from(json["loginactivities"]!.map((x) => Loginactivity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "officeHour": officeHour,
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime,
    "startOverTime": startOverTime,
    "finishOverTime": finishOverTime,
    "totalWorkingHours": totalWorkingHours,
    "monthlyWorkingHours": monthlyWorkingHours,
    "presencepercentage": presencepercentage,
    "absencepercentage": absencepercentage,
    "overtimeWorkingHours": overtimeWorkingHours,
    "currentdate": currentdate,
    "loginStatus": loginStatus,
    "loginactivities": loginactivities == null ? [] : List<dynamic>.from(loginactivities!.map((x) => x.toJson())),
  };
}

class Loginactivity {
  String? checkIn;
  String? checkOut;
  String? loginStatus;

  Loginactivity({
    this.checkIn,
    this.checkOut,
    this.loginStatus,
  });

  factory Loginactivity.fromJson(Map<String, dynamic> json) => Loginactivity(
    checkIn: json["checkIN"],
    checkOut: json["checkOut"],
    loginStatus: json["loginStatus"],
  );

  Map<String, dynamic> toJson() => {
    "checkIN": checkIn,
    "checkOut": checkOut,
    "loginStatus": loginStatus,
  };
}
