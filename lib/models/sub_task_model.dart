
// To parse this JSON data, do
//
//     final subTaskCompletedModel = subTaskCompletedModelFromJson(jsonString);

import 'dart:convert';

SubTaskCompletedModel subTaskCompletedModelFromJson(String str) => SubTaskCompletedModel.fromJson(json.decode(str));

String subTaskCompletedModelToJson(SubTaskCompletedModel data) => json.encode(data.toJson());

class SubTaskCompletedModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  Data? data;

  SubTaskCompletedModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory SubTaskCompletedModel.fromJson(Map<String, dynamic> json) => SubTaskCompletedModel(
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
  dynamic taskreason;
  DateTime? replydate;
  int? taskstatus;
  bool? isApprove;
  int? subtaskid;
  int? taskid;
  String? employeeId;

  Data({
    this.id,
    this.taskreason,
    this.replydate,
    this.taskstatus,
    this.isApprove,
    this.subtaskid,
    this.taskid,
    this.employeeId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    taskreason: json["taskreason"],
    replydate: json["replydate"] == null ? null : DateTime.parse(json["replydate"]),
    taskstatus: json["taskstatus"],
    isApprove: json["isApprove"],
    subtaskid: json["subtaskid"],
    taskid: json["taskid"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "taskreason": taskreason,
    "replydate": replydate?.toIso8601String(),
    "taskstatus": taskstatus,
    "isApprove": isApprove,
    "subtaskid": subtaskid,
    "taskid": taskid,
    "employeeId": employeeId,
  };
}
