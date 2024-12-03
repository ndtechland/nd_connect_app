// To parse this JSON data, do
//
//     final getTripTypeModel = getTripTypeModelFromJson(jsonString);

import 'dart:convert';

GetTripTypeModel getTripTypeModelFromJson(String str) => GetTripTypeModel.fromJson(json.decode(str));

String getTripTypeModelToJson(GetTripTypeModel data) => json.encode(data.toJson());

class GetTripTypeModel {
  bool? succeeded;
  int? statusCode;
  String? message;
  List<GetTripTypeData>? data;

  GetTripTypeModel({
    this.succeeded,
    this.statusCode,
    this.message,
    this.data,
  });

  factory GetTripTypeModel.fromJson(Map<String, dynamic> json) => GetTripTypeModel(
    succeeded: json["Succeeded"],
    statusCode: json["StatusCode"],
    message: json["Message"],
    data: json["data"] == null ? [] : List<GetTripTypeData>.from(json["data"]!.map((x) => GetTripTypeData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Succeeded": succeeded,
    "StatusCode": statusCode,
    "Message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetTripTypeData {
  int? id;
  int? tripMasterId;
  String? tripTypeName;

  GetTripTypeData({
    this.id,
    this.tripMasterId,
    this.tripTypeName,
  });

  factory GetTripTypeData.fromJson(Map<String, dynamic> json) => GetTripTypeData(
    id: json["Id"],
    tripMasterId: json["TripMasterId"],
    tripTypeName: json["TripTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "TripMasterId": tripMasterId,
    "TripTypeName": tripTypeName,
  };
}
