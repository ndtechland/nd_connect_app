// To parse this JSON data, do
//
//     final getShiftTypeModel = getShiftTypeModelFromJson(jsonString);

import 'dart:convert';

GetShiftTypeModel getShiftTypeModelFromJson(String str) => GetShiftTypeModel.fromJson(json.decode(str));

String getShiftTypeModelToJson(GetShiftTypeModel data) => json.encode(data.toJson());

class GetShiftTypeModel {
  bool? succeeded;
  int? statusCode;
  String? message;
  List<GetShiftTypeData>? data;

  GetShiftTypeModel({
    this.succeeded,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetShiftTypeModel.fromJson(Map<String, dynamic> json) => GetShiftTypeModel(
    succeeded: json["Succeeded"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    data: json["data"] == null ? [] : List<GetShiftTypeData>.from(json["data"]!.map((x) => GetShiftTypeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Succeeded": succeeded,
    "StatusCode": statusCode,
    "Message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetShiftTypeData {
  int? id;
  String? tripName;

  GetShiftTypeData({
    this.id,
    this.tripName,
  });

  factory GetShiftTypeData.fromJson(Map<String, dynamic> json) => GetShiftTypeData(
    id: json["Id"],
    tripName: json["TripName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "TripName": tripName,
  };
}
