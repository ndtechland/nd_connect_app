// To parse this JSON data, do
//
//     final taskDetailModel = taskDetailModelFromJson(jsonString);

import 'dart:convert';

TaskDetailModel taskDetailModelFromJson(String str) => TaskDetailModel.fromJson(json.decode(str));

String taskDetailModelToJson(TaskDetailModel data) => json.encode(data.toJson());

class TaskDetailModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  TaskDetailsData? data;

  TaskDetailModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) => TaskDetailModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : TaskDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class TaskDetailsData {
  int? id;
  String? taskTittle;
  String? taskDescription;
  String? status;
  List<Empdatum>? empdata;

  TaskDetailsData({
    this.id,
    this.taskTittle,
    this.taskDescription,
    this.status,
    this.empdata,
  });

  factory TaskDetailsData.fromJson(Map<String, dynamic> json) => TaskDetailsData(
    id: json["id"],
    taskTittle: json["taskTittle"],
    taskDescription: json["taskDescription"],
    status: json["status"],
    empdata: json["empdata"] == null ? [] : List<Empdatum>.from(json["empdata"]!.map((x) => Empdatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "taskTittle": taskTittle,
    "taskDescription": taskDescription,
    "status": status,
    "empdata": empdata == null ? [] : List<dynamic>.from(empdata!.map((x) => x.toJson())),
  };
}

class Empdatum {
  int? id;
  String? tasksubTittle;
  String? taskStatus;

  Empdatum({
    this.id,
    this.tasksubTittle,
    this.taskStatus,
  });

  factory Empdatum.fromJson(Map<String, dynamic> json) => Empdatum(
    id: json["id"],
    tasksubTittle: json["tasksubTittle"],
    taskStatus: json["taskStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tasksubTittle": tasksubTittle,
    "taskStatus": taskStatus,
  };
}
