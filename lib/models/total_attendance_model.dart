
// To parse this JSON data, do
//
//     final totalAttendanceModel = totalAttendanceModelFromJson(jsonString);

import 'dart:convert';

TotalAttendanceModel totalAttendanceModelFromJson(String str) => TotalAttendanceModel.fromJson(json.decode(str));

String totalAttendanceModelToJson(TotalAttendanceModel data) => json.encode(data.toJson());

class TotalAttendanceModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  List<TotalAttendanceData>? data;

  TotalAttendanceModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory TotalAttendanceModel.fromJson(Map<String, dynamic> json) => TotalAttendanceModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TotalAttendanceData>.from(json["data"]!.map((x) => TotalAttendanceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TotalAttendanceData {
  String? year;
  String? month;
  int? value;

  TotalAttendanceData({
    this.year,
    this.month,
    this.value,
  });

  factory TotalAttendanceData.fromJson(Map<String, dynamic> json) => TotalAttendanceData(
    year: json["year"],
    month: json["month"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "month": month,
    "value": value,
  };
}
