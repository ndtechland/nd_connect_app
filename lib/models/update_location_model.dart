// To parse this JSON data, do
//
//     final updateLocationModel = updateLocationModelFromJson(jsonString);

import 'dart:convert';

UpdateLocationModel updateLocationModelFromJson(String str) => UpdateLocationModel.fromJson(json.decode(str));

String updateLocationModelToJson(UpdateLocationModel data) => json.encode(data.toJson());

class UpdateLocationModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  UpdateLocationData? data;

  UpdateLocationModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory UpdateLocationModel.fromJson(Map<String, dynamic> json) => UpdateLocationModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : UpdateLocationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class UpdateLocationData {
  int? id;
  String? employeeId;
  String? currentLat;
  String? currentlong;
  dynamic checkInTime;
  DateTime? checkOutTime;
  DateTime? currentdate;
  bool? checkIn;
  bool? breakin;
  bool? breakout;

  UpdateLocationData({
    this.id,
    this.employeeId,
    this.currentLat,
    this.currentlong,
    this.checkInTime,
    this.checkOutTime,
    this.currentdate,
    this.checkIn,
    this.breakin,
    this.breakout,
  });

  factory UpdateLocationData.fromJson(Map<String, dynamic> json) => UpdateLocationData(
    id: json["id"],
    employeeId: json["employeeId"],
    currentLat: json["currentLat"],
    currentlong: json["currentlong"],
    checkInTime: json["checkInTime"],
    checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
    currentdate: json["currentdate"] == null ? null : DateTime.parse(json["currentdate"]),
    checkIn: json["checkIn"],
    breakin: json["breakin"],
    breakout: json["breakout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "currentLat": currentLat,
    "currentlong": currentlong,
    "checkInTime": checkInTime,
    "checkOutTime": checkOutTime?.toIso8601String(),
    "currentdate": currentdate?.toIso8601String(),
    "checkIn": checkIn,
    "breakin": breakin,
    "breakout": breakout,
  };
}
