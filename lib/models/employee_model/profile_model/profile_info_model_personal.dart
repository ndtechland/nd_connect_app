// To parse this JSON data, do
//
//     final getProfileEmployeePersonalModel = getProfileEmployeePersonalModelFromJson(jsonString);

// import 'dart:convert';
//
// GetProfileEmployeePersonalModel getProfileEmployeePersonalModelFromJson(
//         String str) =>
//     GetProfileEmployeePersonalModel.fromJson(json.decode(str));
//
// String getProfileEmployeePersonalModelToJson(
//         GetProfileEmployeePersonalModel data) =>
//     json.encode(data.toJson());
//
// class GetProfileEmployeePersonalModel {
//   bool? succeeded;
//   int? statusCode;
//   String? status;
//   String? message;
//   dynamic error;
//   Data? data;
//
//   GetProfileEmployeePersonalModel({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.error,
//     this.data,
//   });
//
//   factory GetProfileEmployeePersonalModel.fromJson(Map<String, dynamic> json) =>
//       GetProfileEmployeePersonalModel(
//         succeeded: json["succeeded"],
//         statusCode: json["statusCode"],
//         status: json["status"],
//         message: json["message"],
//         error: json["error"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "succeeded": succeeded,
//         "statusCode": statusCode,
//         "status": status,
//         "message": message,
//         "error": error,
//         "data": data?.toJson(),
//       };
// }
//
// class Data {
//   String? name;
//   String? personalEmailAddress;
//   num? mobileNumber;
//   String? dateOfBirth;
//   num? age;
//   String? fatherName;
//   String? pan;
//   String? addressLine1;
//   String? addressLine2;
//   String? statename;
//   String? cityname;
//   String? pincode;
//   String? aadharNo;
//   String? aadharOne;
//   String? panimg;
//   String? aadharTwo;
//   String? profileImage;
//   num? stateid;
//   num? cityid;
//
//   Data({
//     this.name,
//     this.personalEmailAddress,
//     this.mobileNumber,
//     this.dateOfBirth,
//     this.age,
//     this.fatherName,
//     this.pan,
//     this.addressLine1,
//     this.addressLine2,
//     this.statename,
//     this.cityname,
//     this.pincode,
//     this.aadharNo,
//     this.aadharOne,
//     this.panimg,
//     this.aadharTwo,
//     this.profileImage,
//     this.stateid,
//     this.cityid,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         name: json["name"],
//         personalEmailAddress: json["personalEmailAddress"],
//         mobileNumber: json["mobileNumber"],
//         dateOfBirth: json["dateOfBirth"],
//         age: json["age"],
//         fatherName: json["fatherName"],
//         pan: json["pan"],
//         addressLine1: json["addressLine1"],
//         addressLine2: json["addressLine2"],
//         statename: json["statename"],
//         cityname: json["cityname"],
//         pincode: json["pincode"],
//         aadharNo: json["aadharNo"],
//         aadharOne: json["aadharOne"],
//         panimg: json["panimg"],
//         aadharTwo: json["aadharTwo"],
//         profileImage: json["profileImage"],
//         stateid: json["stateid"],
//         cityid: json["cityid"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "personalEmailAddress": personalEmailAddress,
//         "mobileNumber": mobileNumber,
//         "dateOfBirth": dateOfBirth,
//         "age": age,
//         "fatherName": fatherName,
//         "pan": pan,
//         "addressLine1": addressLine1,
//         "addressLine2": addressLine2,
//         "statename": statename,
//         "cityname": cityname,
//         "pincode": pincode,
//         "aadharNo": aadharNo,
//         "aadharOne": aadharOne,
//         "panimg": panimg,
//         "aadharTwo": aadharTwo,
//         "profileImage": profileImage,
//         "stateid": stateid,
//         "cityid": cityid,
//       };
// }


// To parse this JSON data, do
//
//     final getProfileEmployeePersonalModel = getProfileEmployeePersonalModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final getProfileEmployeePersonalModel = getProfileEmployeePersonalModelFromJson(jsonString);

import 'dart:convert';

GetProfileEmployeePersonalModel getProfileEmployeePersonalModelFromJson(String str) => GetProfileEmployeePersonalModel.fromJson(json.decode(str));

String getProfileEmployeePersonalModelToJson(GetProfileEmployeePersonalModel data) => json.encode(data.toJson());

class GetProfileEmployeePersonalModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  GetProfileEmployeePersonalModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory GetProfileEmployeePersonalModel.fromJson(Map<String, dynamic> json) => GetProfileEmployeePersonalModel(
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
  String? fullName;
  String? workEmail;
  String? mobileNumber;
  String? dateOfBirth;
  String? stateName;
  String? cityName;
  int? stateid;
  int? cityid;
  String? address1;
  String? address2;
  String? pincode;
  String? personalEmailAddress;
  String? dateOfJoining;
  String? departmentName;
  String? designationName;
  String? companyName;
  String? companyLocationName;
  String? employeeId;
  dynamic aadharNo;
  String? panNo;
  String? empProfile;
  String? aadharOne;
  String? panimg;
  String? aadharTwo;
  String? fatherName;
  String? shiftTime;
  String? shiftType;
  Data({
    this.fullName,
    this.workEmail,
    this.mobileNumber,
    this.dateOfBirth,
    this.stateName,
    this.cityName,
    this.stateid,
    this.cityid,
    this.address1,
    this.address2,
    this.pincode,
    this.personalEmailAddress,
    this.dateOfJoining,
    this.departmentName,
    this.designationName,
    this.companyName,
    this.companyLocationName,
    this.employeeId,
    this.aadharNo,
    this.panNo,
    this.empProfile,
    this.aadharOne,
    this.panimg,
    this.aadharTwo,
    this.fatherName,
    this.shiftTime,
    this.shiftType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fullName: json["fullName"],
    workEmail: json["workEmail"],
    mobileNumber: json["mobileNumber"],
    dateOfBirth: json["dateOfBirth"],
    stateName: json["stateName"],
    cityName: json["cityName"],
    stateid: json["stateid"],
    cityid: json["cityid"],
    address1: json["address1"],
    address2: json["address2"],
    pincode: json["pincode"],
    personalEmailAddress: json["personalEmailAddress"],
    dateOfJoining: json["dateOfJoining"],
    departmentName: json["departmentName"],
    designationName: json["designationName"],
    companyName: json["companyName"],
    companyLocationName: json["companyLocationName"],
    employeeId: json["employeeId"],
    aadharNo: json["aadharNo"],
    panNo: json["panNo"],
    empProfile: json["empProfile"],
    aadharOne: json["aadharOne"],
    panimg: json["panimg"],
    aadharTwo: json["aadharTwo"],
    fatherName: json["fatherName"],
    shiftTime: json["shiftTime"],
    shiftType: json["shiftType"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "workEmail": workEmail,
    "mobileNumber": mobileNumber,
    "dateOfBirth": dateOfBirth,
    "stateName": stateName,
    "cityName": cityName,
    "stateid": stateid,
    "cityid": cityid,
    "address1": address1,
    "address2": address2,
    "pincode": pincode,
    "personalEmailAddress": personalEmailAddress,
    "dateOfJoining": dateOfJoining,
    "departmentName": departmentName,
    "designationName": designationName,
    "companyName": companyName,
    "companyLocationName": companyLocationName,
    "employeeId": employeeId,
    "aadharNo": aadharNo,
    "panNo": panNo,
    "empProfile": empProfile,
    "aadharOne": aadharOne,
    "panimg": panimg,
    "aadharTwo": aadharTwo,
    "fatherName": fatherName,
    "shiftTime": shiftTime,
    "shiftType": shiftType,
  };
}

