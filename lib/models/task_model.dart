// // To parse this JSON data, do
// //
// //     final taskModel = taskModelFromJson(jsonString);
//
// import 'dart:convert';
//
// TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));
//
// String taskModelToJson(TaskModel data) => json.encode(data.toJson());
//
// class TaskModel {
//   bool? succeeded;
//   int? statusCode;
//   String? status;
//   String? message;
//   List<TasksModells>? data;
//
//   TaskModel({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
//     succeeded: json["succeeded"],
//     statusCode: json["statusCode"],
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? [] : List<TasksModells>.from(json["data"]!.map((x) => TasksModells.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "succeeded": succeeded,
//     "statusCode": statusCode,
//     "status": status,
//     "message": message,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class TasksModells {
//   String? taskName;
//   String? taskTittle;
//   String? taskDate;
//   String? taskDescription;
//   String? taskStatus;
//
//   TasksModells({
//     this.taskName,
//     this.taskTittle,
//     this.taskDate,
//     this.taskDescription,
//     this.taskStatus,
//   });
//
//   factory TasksModells.fromJson(Map<String, dynamic> json) => TasksModells(
//     taskName: json["taskName"],
//     taskTittle: json["taskTittle"],
//     taskDate: json["taskDate"],
//     taskDescription: json["taskDescription"],
//     taskStatus: json["taskStatus"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "taskName": taskName,
//     "taskTittle": taskTittle,
//     "taskDate": taskDate,
//     "taskDescription": taskDescription,
//     "taskStatus": taskStatus,
//   };
// }
// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);


// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  List<TasksModells>? data;

  TaskModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<TasksModells>.from(json["data"]!.map((x) => TasksModells.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TasksModells {
  int? id;
  String? taskName;
  String? taskTittle;
  DateTime? taskstartdate;
  DateTime? taskEnddate;
  String? taskDescription;
  String? taskStatus;

  TasksModells({
    this.id,
    this.taskName,
    this.taskTittle,
    this.taskstartdate,
    this.taskEnddate,
    this.taskDescription,
    this.taskStatus,
  });

  factory TasksModells.fromJson(Map<String, dynamic> json) => TasksModells(
    id: json["id"],
    taskName: json["taskName"],
    taskTittle: json["taskTittle"],
    taskstartdate: json["taskstartdate"] == null ? null : DateTime.parse(json["taskstartdate"]),
    taskEnddate: json["taskEnddate"] == null ? null : DateTime.parse(json["taskEnddate"]),
    taskDescription: json["taskDescription"],
    taskStatus: json["taskStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "taskName": taskName,
    "taskTittle": taskTittle,
    "taskstartdate": taskstartdate?.toIso8601String(),
    "taskEnddate": taskEnddate?.toIso8601String(),
    "taskDescription": taskDescription,
    "taskStatus": taskStatus,
  };
}

