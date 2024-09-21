// To parse this JSON data, do
//
//     final profileUpdateEmployeeModel = profileUpdateEmployeeModelFromJson(jsonString);

import 'dart:convert';

ProfileUpdateEmployeeModel profileUpdateEmployeeModelFromJson(String str) => ProfileUpdateEmployeeModel.fromJson(json.decode(str));

String profileUpdateEmployeeModelToJson(ProfileUpdateEmployeeModel data) => json.encode(data.toJson());

class ProfileUpdateEmployeeModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  ProfileUpdateData? data;

  ProfileUpdateEmployeeModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory ProfileUpdateEmployeeModel.fromJson(Map<String, dynamic> json) => ProfileUpdateEmployeeModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileUpdateData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileUpdateData {
  int? id;
  String? personalEmailAddress;
  int? mobileNumber;
  DateTime? dateOfBirth;
  String? pan;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? stateId;
  String? pincode;
  String? employeeId;
  String? aadharNo;
  String? aadharOne;
  String? panimg;
  String? aadharTwo;
  bool? isApproved;
  DateTime? updateDate;
  int? vendorid;
  String? empProfile;
  String? fullName;

  ProfileUpdateData({
    this.id,
    this.personalEmailAddress,
    this.mobileNumber,
    this.dateOfBirth,
    this.pan,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.stateId,
    this.pincode,
    this.employeeId,
    this.aadharNo,
    this.aadharOne,
    this.panimg,
    this.aadharTwo,
    this.isApproved,
    this.updateDate,
    this.vendorid,
    this.empProfile,
    this.fullName,
  });

  factory ProfileUpdateData.fromJson(Map<String, dynamic> json) => ProfileUpdateData(
    id: json["id"],
    personalEmailAddress: json["personalEmailAddress"],
    mobileNumber: json["mobileNumber"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    pan: json["pan"],
    addressLine1: json["addressLine1"],
    addressLine2: json["addressLine2"],
    city: json["city"],
    stateId: json["stateId"],
    pincode: json["pincode"],
    employeeId: json["employeeId"],
    aadharNo: json["aadharNo"],
    aadharOne: json["aadharOne"],
    panimg: json["panimg"],
    aadharTwo: json["aadharTwo"],
    isApproved: json["isApproved"],
    updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
    vendorid: json["vendorid"],
    empProfile: json["empProfile"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "personalEmailAddress": personalEmailAddress,
    "mobileNumber": mobileNumber,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "pan": pan,
    "addressLine1": addressLine1,
    "addressLine2": addressLine2,
    "city": city,
    "stateId": stateId,
    "pincode": pincode,
    "employeeId": employeeId,
    "aadharNo": aadharNo,
    "aadharOne": aadharOne,
    "panimg": panimg,
    "aadharTwo": aadharTwo,
    "isApproved": isApproved,
    "updateDate": updateDate?.toIso8601String(),
    "vendorid": vendorid,
    "empProfile": empProfile,
    "fullName": fullName,
  };
}
