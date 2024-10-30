// To parse this JSON data, do
//
//     final dashbordModel = dashbordModelFromJson(jsonString);

import 'dart:convert';

DashbordModel dashbordModelFromJson(String str) => DashbordModel.fromJson(json.decode(str));

String dashbordModelToJson(DashbordModel data) => json.encode(data.toJson());

class DashbordModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  DashboardData? data;

  DashbordModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory DashbordModel.fromJson(Map<String, dynamic> json) => DashbordModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : DashboardData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class DashboardData {
  String? totalAttendance;
  String? attendance;
  double? leaveLeft;
  int? leave;
  String? offerletter;
  String? appointmentletter;

  DashboardData({
    this.totalAttendance,
    this.attendance,
    this.leaveLeft,
    this.leave,
    this.offerletter,
    this.appointmentletter,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
    totalAttendance: json["totalAttendance"],
    attendance: json["attendance"],
    leaveLeft: json["leaveLeft"].toDouble(),
    leave: json["leave"],
    offerletter: json["offerletter"],
    appointmentletter: json["appointmentletter"],
  );

  Map<String, dynamic> toJson() => {
    "totalAttendance": totalAttendance,
    "attendance": attendance,
    "leaveLeft": leaveLeft,
    "leave": leave,
    "offerletter": offerletter,
    "appointmentletter": appointmentletter,
  };
}
