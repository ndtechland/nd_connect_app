// To parse this JSON data, do
//
//     final empTasksAssignModel = empTasksAssignModelFromJson(jsonString);

import 'dart:convert';

EmpTasksAssignModel empTasksAssignModelFromJson(String str) => EmpTasksAssignModel.fromJson(json.decode(str));

String empTasksAssignModelToJson(EmpTasksAssignModel data) => json.encode(data.toJson());

class EmpTasksAssignModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  EmpTaskAssignData? data;

  EmpTasksAssignModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory EmpTasksAssignModel.fromJson(Map<String, dynamic> json) => EmpTasksAssignModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : EmpTaskAssignData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class EmpTaskAssignData {
  int? id;
  String? taskreason;
  DateTime? replydate;
  int? taskstatus;
  bool? isApprove;
  int? subtaskid;
  int? taskid;

  EmpTaskAssignData({
    this.id,
    this.taskreason,
    this.replydate,
    this.taskstatus,
    this.isApprove,
    this.subtaskid,
    this.taskid,
  });

  factory EmpTaskAssignData.fromJson(Map<String, dynamic> json) => EmpTaskAssignData(
    id: json["id"],
    taskreason: json["taskreason"],
    replydate: json["replydate"] == null ? null : DateTime.parse(json["replydate"]),
    taskstatus: json["taskstatus"],
    isApprove: json["isApprove"],
    subtaskid: json["subtaskid"],
    taskid: json["taskid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "taskreason": taskreason,
    "replydate": replydate?.toIso8601String(),
    "taskstatus": taskstatus,
    "isApprove": isApprove,
    "subtaskid": subtaskid,
    "taskid": taskid,
  };
}
