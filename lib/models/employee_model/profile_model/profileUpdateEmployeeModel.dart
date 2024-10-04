// To parse this JSON data, do
//
//     final profileUpdateEmployeeModel = profileUpdateEmployeeModelFromJson(jsonString);

// import 'dart:convert';
//
// ProfileUpdateEmployeeModel profileUpdateEmployeeModelFromJson(String str) => ProfileUpdateEmployeeModel.fromJson(json.decode(str));
//
// String profileUpdateEmployeeModelToJson(ProfileUpdateEmployeeModel data) => json.encode(data.toJson());
//
// class ProfileUpdateEmployeeModel {
//   bool? succeeded;
//   int? statusCode;
//   String? status;
//   String? message;
//   ProfileUpdateData? data;
//
//   ProfileUpdateEmployeeModel({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory ProfileUpdateEmployeeModel.fromJson(Map<String, dynamic> json) => ProfileUpdateEmployeeModel(
//     succeeded: json["succeeded"],
//     statusCode: json["statusCode"],
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? null : ProfileUpdateData.fromJson(json["data"]),
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
// class ProfileUpdateData {
//   int? id;
//   String? personalEmailAddress;
//   int? mobileNumber;
//   DateTime? dateOfBirth;
//   String? pan;
//   String? addressLine1;
//   String? addressLine2;
//   String? city;
//   String? stateId;
//   String? pincode;
//   String? employeeId;
//   String? aadharNo;
//   String? aadharOne;
//   String? panimg;
//   String? aadharTwo;
//   bool? isApproved;
//   DateTime? updateDate;
//   int? vendorid;
//   String? empProfile;
//   String? fullName;
//
//   ProfileUpdateData({
//     this.id,
//     this.personalEmailAddress,
//     this.mobileNumber,
//     this.dateOfBirth,
//     this.pan,
//     this.addressLine1,
//     this.addressLine2,
//     this.city,
//     this.stateId,
//     this.pincode,
//     this.employeeId,
//     this.aadharNo,
//     this.aadharOne,
//     this.panimg,
//     this.aadharTwo,
//     this.isApproved,
//     this.updateDate,
//     this.vendorid,
//     this.empProfile,
//     this.fullName,
//   });
//
//   factory ProfileUpdateData.fromJson(Map<String, dynamic> json) => ProfileUpdateData(
//     id: json["id"],
//     personalEmailAddress: json["personalEmailAddress"],
//     mobileNumber: json["mobileNumber"],
//     dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
//     pan: json["pan"],
//     addressLine1: json["addressLine1"],
//     addressLine2: json["addressLine2"],
//     city: json["city"],
//     stateId: json["stateId"],
//     pincode: json["pincode"],
//     employeeId: json["employeeId"],
//     aadharNo: json["aadharNo"],
//     aadharOne: json["aadharOne"],
//     panimg: json["panimg"],
//     aadharTwo: json["aadharTwo"],
//     isApproved: json["isApproved"],
//     updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
//     vendorid: json["vendorid"],
//     empProfile: json["empProfile"],
//     fullName: json["fullName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "personalEmailAddress": personalEmailAddress,
//     "mobileNumber": mobileNumber,
//     "dateOfBirth": dateOfBirth?.toIso8601String(),
//     "pan": pan,
//     "addressLine1": addressLine1,
//     "addressLine2": addressLine2,
//     "city": city,
//     "stateId": stateId,
//     "pincode": pincode,
//     "employeeId": employeeId,
//     "aadharNo": aadharNo,
//     "aadharOne": aadharOne,
//     "panimg": panimg,
//     "aadharTwo": aadharTwo,
//     "isApproved": isApproved,
//     "updateDate": updateDate?.toIso8601String(),
//     "vendorid": vendorid,
//     "empProfile": empProfile,
//     "fullName": fullName,
//   };
// }
// To parse this JSON data, do
//
//     final profileUpdateEmployeeModel = profileUpdateEmployeeModelFromJson(jsonString);



// To parse this JSON data, do
//
//     final profileUpdateEmployeeModel = profileUpdateEmployeeModelFromJson(jsonString);

import 'dart:convert';

ProfileUpdateEmployeeModel profileUpdateEmployeeModelFromJson(String str) => ProfileUpdateEmployeeModel.fromJson(json.decode(str));

String profileUpdateEmployeeModelToJson(ProfileUpdateEmployeeModel data) => json.encode(data.toJson());

class ProfileUpdateEmployeeModel {
  Response? response;

  ProfileUpdateEmployeeModel({
    this.response,
  });

  factory ProfileUpdateEmployeeModel.fromJson(Map<String, dynamic> json) => ProfileUpdateEmployeeModel(
    response: json["response"] == null ? null : Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
  };
}

class Response {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  Response({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? personalEmailAddress;
  int? mobileNumber;
  String? dateOfBirth;
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
  String? fullName;
  String? fatherName;
  String? empProfile;

  Data({
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
    this.fullName,
    this.fatherName,
    this.empProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    personalEmailAddress: json["personalEmailAddress"],
    mobileNumber: json["mobileNumber"],
    dateOfBirth: json["dateOfBirth"],
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
    fullName: json["fullName"],
    fatherName: json["fatherName"],
    empProfile: json["empProfile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "personalEmailAddress": personalEmailAddress,
    "mobileNumber": mobileNumber,
    "dateOfBirth": dateOfBirth,
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
    "fullName": fullName,
    "fatherName": fatherName,
    "empProfile": empProfile,
  };
}
///todo: correct working previous
// import 'dart:convert';
//
// ProfileUpdateEmployeeModel profileUpdateEmployeeModelFromJson(String str) => ProfileUpdateEmployeeModel.fromJson(json.decode(str));
//
// String profileUpdateEmployeeModelToJson(ProfileUpdateEmployeeModel data) => json.encode(data.toJson());
//
// class ProfileUpdateEmployeeModel {
//   bool? succeeded;
//   int? statusCode;
//   String? status;
//   String? message;
//   Data? data;
//
//   ProfileUpdateEmployeeModel({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory ProfileUpdateEmployeeModel.fromJson(Map<String, dynamic> json) => ProfileUpdateEmployeeModel(
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
//   String? fullName;
//   String? workEmail;
//   String? mobileNumber;
//   String? dateOfBirth;
//   String? stateName;
//   String? cityName;
//   int? stateid;
//   int? cityid;
//   String? address1;
//   String? address2;
//   String? pincode;
//   String? personalEmailAddress;
//   String? dateOfJoining;
//   String? departmentName;
//   String? designationName;
//   String? companyName;
//   String? companyLocationName;
//   String? employeeId;
//   String? aadharNo;
//   String? panNo;
//   String? empProfile;
//   String? aadharOne;
//   String? panimg;
//   String? aadharTwo;
//   String? fatherName;
//   String? shiftTime;
//   String? shiftType;
//
//   Data({
//     this.fullName,
//     this.workEmail,
//     this.mobileNumber,
//     this.dateOfBirth,
//     this.stateName,
//     this.cityName,
//     this.stateid,
//     this.cityid,
//     this.address1,
//     this.address2,
//     this.pincode,
//     this.personalEmailAddress,
//     this.dateOfJoining,
//     this.departmentName,
//     this.designationName,
//     this.companyName,
//     this.companyLocationName,
//     this.employeeId,
//     this.aadharNo,
//     this.panNo,
//     this.empProfile,
//     this.aadharOne,
//     this.panimg,
//     this.aadharTwo,
//     this.fatherName,
//     this.shiftTime,
//     this.shiftType,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     fullName: json["fullName"],
//     workEmail: json["workEmail"],
//     mobileNumber: json["mobileNumber"],
//     dateOfBirth: json["dateOfBirth"],
//     stateName: json["stateName"],
//     cityName: json["cityName"],
//     stateid: json["stateid"],
//     cityid: json["cityid"],
//     address1: json["address1"],
//     address2: json["address2"],
//     pincode: json["pincode"],
//     personalEmailAddress: json["personalEmailAddress"],
//     dateOfJoining: json["dateOfJoining"],
//     departmentName: json["departmentName"],
//     designationName: json["designationName"],
//     companyName: json["companyName"],
//     companyLocationName: json["companyLocationName"],
//     employeeId: json["employeeId"],
//     aadharNo: json["aadharNo"],
//     panNo: json["panNo"],
//     empProfile: json["empProfile"],
//     aadharOne: json["aadharOne"],
//     panimg: json["panimg"],
//     aadharTwo: json["aadharTwo"],
//     fatherName: json["fatherName"],
//     shiftTime: json["shiftTime"],
//     shiftType: json["shiftType"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fullName": fullName,
//     "workEmail": workEmail,
//     "mobileNumber": mobileNumber,
//     "dateOfBirth": dateOfBirth,
//     "stateName": stateName,
//     "cityName": cityName,
//     "stateid": stateid,
//     "cityid": cityid,
//     "address1": address1,
//     "address2": address2,
//     "pincode": pincode,
//     "personalEmailAddress": personalEmailAddress,
//     "dateOfJoining": dateOfJoining,
//     "departmentName": departmentName,
//     "designationName": designationName,
//     "companyName": companyName,
//     "companyLocationName": companyLocationName,
//     "employeeId": employeeId,
//     "aadharNo": aadharNo,
//     "panNo": panNo,
//     "empProfile": empProfile,
//     "aadharOne": aadharOne,
//     "panimg": panimg,
//     "aadharTwo": aadharTwo,
//     "fatherName": fatherName,
//     "shiftTime": shiftTime,
//     "shiftType": shiftType,
//   };
// }
