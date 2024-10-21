// To parse this JSON data, do
//
//     final leavesDetailModel = leavesDetailModelFromJson(jsonString);

import 'dart:convert';

LeavesDetailModel leavesDetailModelFromJson(String str) => LeavesDetailModel.fromJson(json.decode(str));

String leavesDetailModelToJson(LeavesDetailModel data) => json.encode(data.toJson());

class LeavesDetailModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  LeavesDeatildata? data;

  LeavesDetailModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory LeavesDetailModel.fromJson(Map<String, dynamic> json) => LeavesDetailModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : LeavesDeatildata.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class LeavesDeatildata {
  String? reason;
  num? totaldays;
  num? paidLeave;
  num? unPaidLeave;

  LeavesDeatildata({
    this.reason,
    this.totaldays,
    this.paidLeave,
    this.unPaidLeave,
  });

  factory LeavesDeatildata.fromJson(Map<String, dynamic> json) => LeavesDeatildata(
    reason: json["reason"],
    totaldays: json["totaldays"]?.toDouble(),
    paidLeave: json["paidLeave"]?.toDouble(),
    unPaidLeave: json["unPaidLeave"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "totaldays": totaldays,
    "paidLeave": paidLeave,
    "unPaidLeave": unPaidLeave,
  };
}
