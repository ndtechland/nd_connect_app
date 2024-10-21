// To parse this JSON data, do
//
//     final taskHistoryModel = taskHistoryModelFromJson(jsonString);

import 'dart:convert';

TaskHistoryModel taskHistoryModelFromJson(String str) => TaskHistoryModel.fromJson(json.decode(str));

String taskHistoryModelToJson(TaskHistoryModel data) => json.encode(data.toJson());

class TaskHistoryModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  TaskHisData? data;

  TaskHistoryModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory TaskHistoryModel.fromJson(Map<String, dynamic> json) => TaskHistoryModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : TaskHisData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class TaskHisData {
  List<Completed>? reassigned;
  List<Completed>? completed;
  List<Completed>? unCompleted;

  TaskHisData({
    this.reassigned,
    this.completed,
    this.unCompleted,
  });

  factory TaskHisData.fromJson(Map<String, dynamic> json) => TaskHisData(
    reassigned: json["reassigned"] == null ? [] : List<Completed>.from(json["reassigned"]!.map((x) => Completed.fromJson(x))),
    completed: json["completed"] == null ? [] : List<Completed>.from(json["completed"]!.map((x) => Completed.fromJson(x))),
    unCompleted: json["unCompleted"] == null ? [] : List<Completed>.from(json["unCompleted"]!.map((x) => Completed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reassigned": reassigned == null ? [] : List<dynamic>.from(reassigned!.map((x) => x.toJson())),
    "completed": completed == null ? [] : List<dynamic>.from(completed!.map((x) => x.toJson())),
    "unCompleted": unCompleted == null ? [] : List<dynamic>.from(unCompleted!.map((x) => x.toJson())),
  };
}

class Completed {
  int? id;
  String? taskname;
  String? duration;
  String? status;

  Completed({
    this.id,
    this.taskname,
    this.duration,
    this.status,
  });

  factory Completed.fromJson(Map<String, dynamic> json) => Completed(
    id: json["id"],
    taskname: json["taskname"],
    duration: json["duration"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "taskname": taskname,
    "duration": duration,
    "status": status,
  };
}
