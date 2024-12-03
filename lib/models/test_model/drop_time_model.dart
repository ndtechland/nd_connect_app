// To parse this JSON data, do
//
//     final getDropShiftTimeModel = getDropShiftTimeModelFromJson(jsonString);

import 'dart:convert';

GetDropShiftTimeModel getDropShiftTimeModelFromJson(String str) => GetDropShiftTimeModel.fromJson(json.decode(str));

String getDropShiftTimeModelToJson(GetDropShiftTimeModel data) => json.encode(data.toJson());

class GetDropShiftTimeModel {
  bool? succeeded;
  int? statusCode;
  String? message;
  List<dropTimeData>? data;

  GetDropShiftTimeModel({
    this.succeeded,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetDropShiftTimeModel.fromJson(Map<String, dynamic> json) => GetDropShiftTimeModel(
    succeeded: json["Succeeded"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    data: json["data"] == null ? [] : List<dropTimeData>.from(json["data"]!.map((x) => dropTimeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Succeeded": succeeded,
    "StatusCode": statusCode,
    "Message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class dropTimeData {
  int? id;
  int? tripTypeId;
  String? shiftTime;
  int? companyId;
  int? departmentId;
  String? shiftBufferTime;
  int? companyZoneId;

  dropTimeData({
    this.id,
    this.tripTypeId,
    this.shiftTime,
    this.companyId,
    this.departmentId,
    this.shiftBufferTime,
    this.companyZoneId,
  });

  factory dropTimeData.fromJson(Map<String, dynamic> json) => dropTimeData(
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
