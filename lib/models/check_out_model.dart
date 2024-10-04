// To parse this JSON data, do
//
//     final checkOutModel = checkOutModelFromJson(jsonString);

import 'dart:convert';

CheckOutModel checkOutModelFromJson(String str) => CheckOutModel.fromJson(json.decode(str));

String checkOutModelToJson(CheckOutModel data) => json.encode(data.toJson());

class CheckOutModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  CheckOutData? data;

  CheckOutModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : CheckOutData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CheckOutData {
  int? id;
  String? employeeId;
  String? currentLat;
  String? currentlong;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  DateTime? currentdate;
  bool? checkIn;

  CheckOutData({
    this.id,
    this.employeeId,
    this.currentLat,
    this.currentlong,
    this.checkInTime,
    this.checkOutTime,
    this.currentdate,
    this.checkIn,
  });

  factory CheckOutData.fromJson(Map<String, dynamic> json) => CheckOutData(
    id: json["id"],
    employeeId: json["employeeId"],
    currentLat: json["currentLat"],
    currentlong: json["currentlong"],
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
    currentdate: json["currentdate"] == null ? null : DateTime.parse(json["currentdate"]),
    checkIn: json["checkIn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "currentLat": currentLat,
    "currentlong": currentlong,
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime?.toIso8601String(),
    "currentdate": currentdate?.toIso8601String(),
    "checkIn": checkIn,
  };
}
