
// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  LocationData? data;

  LocationModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : LocationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LocationData {
  int? id;
  String? employeeId;
  String? currentLat;
  String? currentlong;
  DateTime? checkInTime;
  dynamic checkOutTime;
  DateTime? currentdate;
  bool? checkIn;
  bool? breakin;
  bool? breakout;

  LocationData({
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

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    id: json["id"],
    employeeId: json["employeeId"],
    currentLat: json["currentLat"],
    currentlong: json["currentlong"],
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"],
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
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime,
    "currentdate": currentdate?.toIso8601String(),
    "checkIn": checkIn,
    "breakin": breakin,
    "breakout": breakout,
  };
}
