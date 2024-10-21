// To parse this JSON data, do
//
//     final attendanceActivityModel = attendanceActivityModelFromJson(jsonString);

import 'dart:convert';

AttendanceActivityModel attendanceActivityModelFromJson(String str) => AttendanceActivityModel.fromJson(json.decode(str));

String attendanceActivityModelToJson(AttendanceActivityModel data) => json.encode(data.toJson());

class AttendanceActivityModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  AttendanceActivityModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory AttendanceActivityModel.fromJson(Map<String, dynamic> json) => AttendanceActivityModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? checkIn;
  String? checkOut;
  String? loginStatus;
  List<Data>? loginactivities;

  Data({
    this.checkIn,
    this.checkOut,
    this.loginStatus,
    this.loginactivities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    checkIn: json["checkIN"],
    checkOut: json["checkOut"],
    loginStatus: json["loginStatus"],
    loginactivities: json["loginactivities"] == null ? [] : List<Data>.from(json["loginactivities"]!.map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "checkIN": checkIn,
    "checkOut": checkOut,
    "loginStatus": loginStatus,
    "loginactivities": loginactivities == null ? [] : List<dynamic>.from(loginactivities!.map((x) => x.toJson())),
  };
}
