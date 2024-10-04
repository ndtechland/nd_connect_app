// To parse this JSON data, do
//
//     final employeeCheckInModel = employeeCheckInModelFromJson(jsonString);

import 'dart:convert';

EmployeeCheckInModel employeeCheckInModelFromJson(String str) => EmployeeCheckInModel.fromJson(json.decode(str));

String employeeCheckInModelToJson(EmployeeCheckInModel data) => json.encode(data.toJson());

class EmployeeCheckInModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  ChecInData? data;

  EmployeeCheckInModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeCheckInModel.fromJson(Map<String, dynamic> json) => EmployeeCheckInModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ChecInData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ChecInData {
  int? id;
  String? employeeId;
  String? currentLat;
  String? currentlong;
  DateTime? checkInTime;
  dynamic checkOutTime;
  DateTime? currentdate;
  bool? checkIn;

  ChecInData({
    this.id,
    this.employeeId,
    this.currentLat,
    this.currentlong,
    this.checkInTime,
    this.checkOutTime,
    this.currentdate,
    this.checkIn,
  });

  factory ChecInData.fromJson(Map<String, dynamic> json) => ChecInData(
    id: json["id"],
    employeeId: json["employeeId"],
    currentLat: json["currentLat"],
    currentlong: json["currentlong"],
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"],
    currentdate: json["currentdate"] == null ? null : DateTime.parse(json["currentdate"]),
    checkIn: json["checkIn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "currentLat": currentLat,
    "currentlong": currentlong,
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime,
    "currentdate": currentdate?.toIso8601String(),
    "checkIn": checkIn,
  };
}
