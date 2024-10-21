// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'dart:convert';

FaqModel faqModelFromJson(String str) => FaqModel.fromJson(json.decode(str));

String faqModelToJson(FaqModel data) => json.encode(data.toJson());

class FaqModel {
  bool? succeeded;
  int? statusCode;
  dynamic status;
  String? message;
  List<FaqData>? data;

  FaqModel({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<FaqData>.from(json["data"]!.map((x) => FaqData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FaqData {
  int? id;
  String? tittle;
  String? subtittle;

  FaqData({
    this.id,
    this.tittle,
    this.subtittle,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) => FaqData(
    id: json["id"],
    tittle: json["tittle"],
    subtittle: json["subtittle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tittle": tittle,
    "subtittle": subtittle,
  };
}
