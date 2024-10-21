// To parse this JSON data, do
//
//     final currentMonthAttendanceModel = currentMonthAttendanceModelFromJson(jsonString);

import 'dart:convert';

CurrentMonthAttendanceModel currentMonthAttendanceModelFromJson(String str) => CurrentMonthAttendanceModel.fromJson(json.decode(str));

String currentMonthAttendanceModelToJson(CurrentMonthAttendanceModel data) => json.encode(data.toJson());

class CurrentMonthAttendanceModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  CurrentMonthData? data;

  CurrentMonthAttendanceModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory CurrentMonthAttendanceModel.fromJson(Map<String, dynamic> json) => CurrentMonthAttendanceModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : CurrentMonthData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CurrentMonthData {
  int? totalWorkingDays;
  int? totalPresentDays;
  int? totalAbsentDays;
  String? attendance;

  CurrentMonthData({
    this.totalWorkingDays,
    this.totalPresentDays,
    this.totalAbsentDays,
    this.attendance,
  });

  factory CurrentMonthData.fromJson(Map<String, dynamic> json) => CurrentMonthData(
    totalWorkingDays: json["totalWorkingDays"],
    totalPresentDays: json["totalPresentDays"],
    totalAbsentDays: json["totalAbsentDays"],
    attendance: json["attendance"],
  );

  Map<String, dynamic> toJson() => {
    "totalWorkingDays": totalWorkingDays,
    "totalPresentDays": totalPresentDays,
    "totalAbsentDays": totalAbsentDays,
    "attendance": attendance,
  };
}
