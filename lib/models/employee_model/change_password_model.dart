// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  ChangePassData? data;

  ChangePasswordModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ChangePassData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ChangePassData {
  int? userId;
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;

  ChangePassData({
    this.userId,
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
  });

  factory ChangePassData.fromJson(Map<String, dynamic> json) => ChangePassData(
    userId: json["userId"],
    currentPassword: json["currentPassword"],
    newPassword: json["newPassword"],
    confirmPassword: json["confirmPassword"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "currentPassword": currentPassword,
    "newPassword": newPassword,
    "confirmPassword": confirmPassword,
  };
}
