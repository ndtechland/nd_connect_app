// To parse this JSON data, do
//
//     final getPickupShiftTimeModel = getPickupShiftTimeModelFromJson(jsonString);

import 'dart:convert';

GetPickupShiftTimeModel getPickupShiftTimeModelFromJson(String str) => GetPickupShiftTimeModel.fromJson(json.decode(str));

String getPickupShiftTimeModelToJson(GetPickupShiftTimeModel data) => json.encode(data.toJson());

class GetPickupShiftTimeModel {
  bool? succeeded;
  int? statusCode;
  String? message;
  List<PickupTimeData>? data;

  GetPickupShiftTimeModel({
    this.succeeded,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetPickupShiftTimeModel.fromJson(Map<String, dynamic> json) => GetPickupShiftTimeModel(
    succeeded: json["Succeeded"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    data: json["data"] == null ? [] : List<PickupTimeData>.from(json["data"]!.map((x) => PickupTimeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Succeeded": succeeded,
    "StatusCode": statusCode,
    "Message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PickupTimeData {
  int? id;
  int? tripTypeId;
  String? shiftTime;
  int? companyId;
  int? departmentId;
  String? shiftBufferTime;
  int? companyZoneId;

  PickupTimeData({
    this.id,
    this.tripTypeId,
    this.shiftTime,
    this.companyId,
    this.departmentId,
    this.shiftBufferTime,
    this.companyZoneId,
  });

  factory PickupTimeData.fromJson(Map<String, dynamic> json) => PickupTimeData(
    id: json["Id"],
    tripTypeId: json["TripTypeId"],
    shiftTime: json["ShiftTime"],
    companyId: json["CompanyId"],
    departmentId: json["DepartmentId"],
    shiftBufferTime: json["ShiftBufferTime"],
    companyZoneId: json["CompanyZoneId"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "TripTypeId": tripTypeId,
    "ShiftTime": shiftTime,
    "CompanyId": companyId,
    "DepartmentId": departmentId,
    "ShiftBufferTime": shiftBufferTime,
    "CompanyZoneId": companyZoneId,
  };
}
