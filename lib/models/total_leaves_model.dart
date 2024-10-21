// To parse this JSON data, do
//
//     final totalLeavesModel = totalLeavesModelFromJson(jsonString);

import 'dart:convert';

TotalLeavesModel totalLeavesModelFromJson(String str) => TotalLeavesModel.fromJson(json.decode(str));

String totalLeavesModelToJson(TotalLeavesModel data) => json.encode(data.toJson());

class TotalLeavesModel {
  bool? succeeded;
  num? statusCode;
  String? status;
  String? message;
  TotalLeavesData? data;

  TotalLeavesModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory TotalLeavesModel.fromJson(Map<String, dynamic> json) => TotalLeavesModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : TotalLeavesData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class TotalLeavesData {
  num? totalLeaves;
  List<Type>? type;

  TotalLeavesData({
    this.totalLeaves,
    this.type,
  });

  factory TotalLeavesData.fromJson(Map<String, dynamic> json) => TotalLeavesData(
    totalLeaves: json["totalLeaves"],
    type: json["type"] == null ? [] : List<Type>.from(json["type"]!.map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalLeaves": totalLeaves,
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x.toJson())),
  };
}

class Type {
  int? id;
  DateTime? leavedate;
  String? reason;
  num? nodays;
  String? leaveType;
  String? leaveapplydate;
  String? leaveSearchdate;

  Type({
    this.id,
    this.leavedate,
    this.reason,
    this.nodays,
    this.leaveType,
    this.leaveapplydate,
    this.leaveSearchdate,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    leavedate: json["leavedate"] == null ? null : DateTime.parse(json["leavedate"]),
    reason: json["reason"],
    nodays: json["nodays"],
    leaveType: json["leaveType"],
    leaveapplydate: json["leaveapplydate"],
    leaveSearchdate: json["leaveSearchdate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "leavedate": leavedate?.toIso8601String(),
    "reason": reason,
    "nodays": nodays,
    "leaveType": leaveType,
    "leaveapplydate": leaveapplydate,
    "leaveSearchdate": leaveSearchdate,
  };
}
