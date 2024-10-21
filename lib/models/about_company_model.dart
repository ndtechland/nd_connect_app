
// To parse this JSON data, do
//
//     final aboutCompanyModel = aboutCompanyModelFromJson(jsonString);

import 'dart:convert';

AboutCompanyModel aboutCompanyModelFromJson(String str) => AboutCompanyModel.fromJson(json.decode(str));

String aboutCompanyModelToJson(AboutCompanyModel data) => json.encode(data.toJson());

class AboutCompanyModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  CompanyData? data;

  AboutCompanyModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory AboutCompanyModel.fromJson(Map<String, dynamic> json) => AboutCompanyModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : CompanyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class CompanyData {
  String? companylink;

  CompanyData({
    this.companylink,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) => CompanyData(
    companylink: json["companylink"],
  );

  Map<String, dynamic> toJson() => {
    "companylink": companylink,
  };
}
