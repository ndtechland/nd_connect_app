// To parse this JSON data, do
//
//     final overtimeModel = overtimeModelFromJson(jsonString);

import 'dart:convert';

OvertimeModel overtimeModelFromJson(String str) => OvertimeModel.fromJson(json.decode(str));

String overtimeModelToJson(OvertimeModel data) => json.encode(data.toJson());

class OvertimeModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  OvertimeData? data;

  OvertimeModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory OvertimeModel.fromJson(Map<String, dynamic> json) => OvertimeModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : OvertimeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class OvertimeData {
  String? employeeId;
  String? startTime;

  OvertimeData({
    this.employeeId,
    this.startTime,
  });

  factory OvertimeData.fromJson(Map<String, dynamic> json) => OvertimeData(
    employeeId: json["employeeId"],
    startTime: json["startTime"],
  );

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "startTime": startTime,
  };
}
