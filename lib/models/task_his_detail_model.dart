// To parse this JSON data, do
//
//     final taskHisDetailModel = taskHisDetailModelFromJson(jsonString);

import 'dart:convert';

TaskHisDetailModel taskHisDetailModelFromJson(String str) => TaskHisDetailModel.fromJson(json.decode(str));

String taskHisDetailModelToJson(TaskHisDetailModel data) => json.encode(data.toJson());

class TaskHisDetailModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  List<TaskHisDetailData>? data;

  TaskHisDetailModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory TaskHisDetailModel.fromJson(Map<String, dynamic> json) => TaskHisDetailModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TaskHisDetailData>.from(json["data"]!.map((x) => TaskHisDetailData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TaskHisDetailData {
  num? id;
  String? taskTittle;
  String? tasksubTittle;
  String? taskStatus;
  String? taskDescription;
  String? duration;

  TaskHisDetailData({
    this.id,
    this.taskTittle,
    this.tasksubTittle,
    this.taskStatus,
    this.taskDescription,
    this.duration,
  });

  factory TaskHisDetailData.fromJson(Map<String, dynamic> json) => TaskHisDetailData(
    id: json["id"],
    taskTittle: json["taskTittle"],
    tasksubTittle: json["tasksubTittle"],
    taskStatus: json["taskStatus"],
    taskDescription: json["taskDescription"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "taskTittle": taskTittle,
    "tasksubTittle": tasksubTittle,
    "taskStatus": taskStatus,
    "taskDescription": taskDescription,
    "duration": duration,
  };
}
