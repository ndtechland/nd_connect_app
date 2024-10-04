




///todo:correct
// To parse this JSON data, do
//
//     final employeeLogin = employeeLoginFromJson(jsonString);

// To parse this JSON data, do
//
//     final employeeLogin = employeeLoginFromJson(jsonString);

// import 'dart:convert';
//
// EmployeeLogin employeeLoginFromJson(String str) => EmployeeLogin.fromJson(json.decode(str));
//
// String employeeLoginToJson(EmployeeLogin data) => json.encode(data.toJson());
//
// class EmployeeLogin {
//   Loginemp? response;
//   String? token;
//
//   EmployeeLogin({
//     this.response,
//     this.token,
//   });
//
//   factory EmployeeLogin.fromJson(Map<String, dynamic> json) => EmployeeLogin(
//     response: json["response"] == null ? null : Loginemp.fromJson(json["response"]),
//     token: json["token"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "response": response?.toJson(),
//     "token": token,
//   };
// }
//
// class Loginemp {
//   bool? succeeded;
//   num? statusCode;
//   String? status;
//   String? message;
//   dynamic error;
//   dynamic errors;
//   Data? data;
//
//   Loginemp({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.error,
//     this.errors,
//     this.data,
//   });
//
//   factory Loginemp.fromJson(Map<String, dynamic> json) => Loginemp(
//     succeeded: json["succeeded"],
//     statusCode: json["statusCode"],
//     status: json["status"],
//     message: json["message"],
//     error: json["error"],
//     errors: json["errors"],
//     data: json["data"] == null ? null : Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "succeeded": succeeded,
//     "statusCode": statusCode,
//     "status": status,
//     "message": message,
//     "error": error,
//     "errors": errors,
//     "data": data?.toJson(),
//   };
// }
//
// class Data {
//   num? userid;
//   String? employeeName;
//   String? employeeId;
//
//   Data({
//     this.userid,
//     this.employeeName,
//     this.employeeId,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     userid: json["userid"],
//     employeeName: json["employee_Name"],
//     employeeId: json["employee_ID"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userid": userid,
//     "employee_Name": employeeName,
//     "employee_ID": employeeId,
//   };
// }
// To parse this JSON data, do
//
//     final employeeLogin = employeeLoginFromJson(jsonString);

import 'dart:convert';

EmployeeLogin employeeLoginFromJson(String str) => EmployeeLogin.fromJson(json.decode(str));

String employeeLoginToJson(EmployeeLogin data) => json.encode(data.toJson());

class EmployeeLogin {
  Loginemp? response;
  String? token;
  String? refreshToken;

  EmployeeLogin({
    this.response,
    this.token,
    this.refreshToken,
  });

  factory EmployeeLogin.fromJson(Map<String, dynamic> json) => EmployeeLogin(
    response: json["response"] == null ? null : Loginemp.fromJson(json["response"]),
    token: json["token"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
    "token": token,
    "refreshToken": refreshToken,
  };
}

class Loginemp {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  Loginemp({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory Loginemp.fromJson(Map<String, dynamic> json) => Loginemp(
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
  int? userid;
  String? employeeName;
  String? employeeId;

  Data({
    this.userid,
    this.employeeName,
    this.employeeId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userid: json["userid"],
    employeeName: json["employee_Name"],
    employeeId: json["employee_ID"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "employee_Name": employeeName,
    "employee_ID": employeeId,
  };
}
