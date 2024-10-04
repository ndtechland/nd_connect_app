// To parse this JSON data, do
//
//     final companyLocationModel = companyLocationModelFromJson(jsonString);

import 'dart:convert';

CompanyLocationModel companyLocationModelFromJson(String str) => CompanyLocationModel.fromJson(json.decode(str));

String companyLocationModelToJson(CompanyLocationModel data) => json.encode(data.toJson());

class CompanyLocationModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  CompanyLocData? data;

  CompanyLocationModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory CompanyLocationModel.fromJson(Map<String, dynamic> json) => CompanyLocationModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : CompanyLocData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CompanyLocData {
  String? companyOfficeLocation;
  String? radious;

  CompanyLocData({
    this.companyOfficeLocation,
    this.radious,
  });

  factory CompanyLocData.fromJson(Map<String, dynamic> json) => CompanyLocData(
    companyOfficeLocation: json["companyOfficeLocation"],
    radious: json["radious"],
  );

  Map<String, dynamic> toJson() => {
    "companyOfficeLocation": companyOfficeLocation,
    "radious": radious,
  };
}
