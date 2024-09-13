//
//
// import 'dart:convert';
//
// BankDetailInformationModel bankDetailInformationModelFromJson(String str) => BankDetailInformationModel.fromJson(json.decode(str));
//
// String bankDetailInformationModelToJson(BankDetailInformationModel data) => json.encode(data.toJson());
//
// class BankDetailInformationModel {
//   bool? succeeded;
//   int? statusCode;
//   String? status;
//   String? message;
//   Data? data;
//
//   BankDetailInformationModel({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory BankDetailInformationModel.fromJson(Map<String, dynamic> json) => BankDetailInformationModel(
//     succeeded: json["succeeded"],
//     statusCode: json["statusCode"],
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "succeeded": succeeded,
//     "statusCode": statusCode,
//     "status": status,
//     "message": message,
//     "data": data?.toJson(),
//   };
// }
//
// class Data {
//   int? id;
//   String? accountHolderName;
//   String? bankName;
//   String? accountNumber;
//   String? reEnterAccountNumber;
//   String? ifsc;
//   int? accountTypeId;
//   String? employeeId;
//   String? epfNumber;
//   String? nominee;
//   dynamic chequeimage;
//   bool? isApproved;
//   DateTime? updateDate;
//
//   Data({
//     this.id,
//     this.accountHolderName,
//     this.bankName,
//     this.accountNumber,
//     this.reEnterAccountNumber,
//     this.ifsc,
//     this.accountTypeId,
//     this.employeeId,
//     this.epfNumber,
//     this.nominee,
//     this.chequeimage,
//     this.isApproved,
//     this.updateDate,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     accountHolderName: json["accountHolderName"],
//     bankName: json["bankName"],
//     accountNumber: json["accountNumber"],
//     reEnterAccountNumber: json["reEnterAccountNumber"],
//     ifsc: json["ifsc"],
//     accountTypeId: json["accountTypeId"],
//     employeeId: json["employeeId"],
//     epfNumber: json["epfNumber"],
//     nominee: json["nominee"],
//     chequeimage: json["chequeimage"],
//     isApproved: json["isApproved"],
//     updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "accountHolderName": accountHolderName,
//     "bankName": bankName,
//     "accountNumber": accountNumber,
//     "reEnterAccountNumber": reEnterAccountNumber,
//     "ifsc": ifsc,
//     "accountTypeId": accountTypeId,
//     "employeeId": employeeId,
//     "epfNumber": epfNumber,
//     "nominee": nominee,
//     "chequeimage": chequeimage,
//     "isApproved": isApproved,
//     "updateDate": updateDate?.toIso8601String(),
//   };
// }

// To parse this JSON data, do
//
//     final bankDetailInformationModel = bankDetailInformationModelFromJson(jsonString);

import 'dart:convert';

BankDetailInformationModel bankDetailInformationModelFromJson(String str) => BankDetailInformationModel.fromJson(json.decode(str));

String bankDetailInformationModelToJson(BankDetailInformationModel data) => json.encode(data.toJson());

class BankDetailInformationModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  BankData? data;

  BankDetailInformationModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory BankDetailInformationModel.fromJson(Map<String, dynamic> json) => BankDetailInformationModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : BankData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class BankData {
  String? accountHolderName;
  String? bankName;
  String? accountNumber;
  String? reEnterAccountNumber;
  String? ifsc;
  var accountTypeId;
  String? epfNumber;
  String? nominee;
  String? chequeimage;
  dynamic chequebase64;

  BankData({
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
    this.reEnterAccountNumber,
    this.ifsc,
    this.accountTypeId,
    this.epfNumber,
    this.nominee,
    this.chequeimage,
    this.chequebase64,
  });

  factory BankData.fromJson(Map<String, dynamic> json) => BankData(
    accountHolderName: json["accountHolderName"],
    bankName: json["bankName"],
    accountNumber: json["accountNumber"],
    reEnterAccountNumber: json["reEnterAccountNumber"],
    ifsc: json["ifsc"],
    accountTypeId: json["accountTypeId"],
    epfNumber: json["epfNumber"],
    nominee: json["nominee"],
    chequeimage: json["chequeimage"],
    chequebase64: json["chequebase64"],
  );

  Map<String, dynamic> toJson() => {
    "accountHolderName": accountHolderName,
    "bankName": bankName,
    "accountNumber": accountNumber,
    "reEnterAccountNumber": reEnterAccountNumber,
    "ifsc": ifsc,
    "accountTypeId": accountTypeId,
    "epfNumber": epfNumber,
    "nominee": nominee,
    "chequeimage": chequeimage,
    "chequebase64": chequebase64,
  };
}

