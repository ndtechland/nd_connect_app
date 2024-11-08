// To parse this JSON data, do
//
//     final eventModel2 = eventModel2FromJson(jsonString);

import 'dart:convert';

EventModel2 eventModel2FromJson(String str) => EventModel2.fromJson(json.decode(str));

String eventModel2ToJson(EventModel2 data) => json.encode(data.toJson());

class EventModel2 {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  EventData2? data;

  EventModel2({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory EventModel2.fromJson(Map<String, dynamic> json) => EventModel2(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : EventData2.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class EventData2 {
  List<OfficeEventsDto>? officeEventsDtos;
  List<MeetEventsDto>? meetEventsDtos;

  EventData2({
    this.officeEventsDtos,
    this.meetEventsDtos,
  });

  factory EventData2.fromJson(Map<String, dynamic> json) => EventData2(
    officeEventsDtos: json["officeEventsDtos"] == null ? [] : List<OfficeEventsDto>.from(json["officeEventsDtos"]!.map((x) => OfficeEventsDto.fromJson(x))),
    meetEventsDtos: json["meetEventsDtos"] == null ? [] : List<MeetEventsDto>.from(json["meetEventsDtos"]!.map((x) => MeetEventsDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "officeEventsDtos": officeEventsDtos == null ? [] : List<dynamic>.from(officeEventsDtos!.map((x) => x.toJson())),
    "meetEventsDtos": meetEventsDtos == null ? [] : List<dynamic>.from(meetEventsDtos!.map((x) => x.toJson())),
  };
}

class MeetEventsDto {
  String? eventTittle;
  DateTime? eventdate;
  String? eventType;
  String? eventTime;
  String? eventDescription;

  MeetEventsDto({
    this.eventTittle,
    this.eventdate,
    this.eventType,
    this.eventTime,
    this.eventDescription,
  });

  factory MeetEventsDto.fromJson(Map<String, dynamic> json) => MeetEventsDto(
    eventTittle: json["eventTittle"],
    eventdate: json["eventdate"] == null ? null : DateTime.parse(json["eventdate"]),
    eventType: json["eventType"],
    eventTime: json["eventTime"],
    eventDescription: json["eventDescription"],
  );

  Map<String, dynamic> toJson() => {
    "eventTittle": eventTittle,
    "eventdate": eventdate?.toIso8601String(),
    "eventType": eventType,
    "eventTime": eventTime,
    "eventDescription": eventDescription,
  };
}

class OfficeEventsDto {
  String? subtittle;
  String? tittle;
  DateTime? date;

  OfficeEventsDto({
    this.subtittle,
    this.tittle,
    this.date,
  });

  factory OfficeEventsDto.fromJson(Map<String, dynamic> json) => OfficeEventsDto(
    subtittle: json["subtittle"],
    tittle: json["tittle"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "subtittle": subtittle,
    "tittle": tittle,
    "date": date?.toIso8601String(),
  };
}
