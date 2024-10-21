// class Event {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime date;
//
//   Event({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.date,
//   });
//
//   // Static method to generate some dummy events
//   static List<Event> getDummyEvents() {
//     return [
//       Event(
//         id: '1',
//         title: 'Meeting with Bob',
//         description: 'Discuss the new project timeline.',
//         date: DateTime(2024, 9, 10),
//       ),
//       Event(
//         id: '2',
//         title: 'Dentist Appointment',
//         description: 'Routine check-up.',
//         date: DateTime(2024, 9, 12),
//       ),
//       Event(
//         id: '3',
//         title: 'Team Lunch',
//         description: 'Lunch with the team at the new restaurant.',
//         date: DateTime(2024, 9, 12),
//       ),
//       Event(
//         id: '4',
//         title: 'Project Deadline',
//         description: 'Submit the final report.',
//         date: DateTime(2024, 9, 14),
//       ),
//       Event(
//         id: '5',
//         title: 'Conference Call',
//         description: 'Call with the clients to discuss feedback.',
//         date: DateTime(2024, 9, 14),
//       ),
//     ];
//   }
// }
// lib/models/event_model.dart
import 'dart:convert';



// class StaticEventData {
//   static List<EventModel> getEvents() {
//     return [
//       EventModel(
//         date: DateTime.utc(2024, 9, 2),
//         title: "Event 1",
//         subtitle: "Subtitle 1",
//       ),
//       EventModel(
//         date: DateTime.utc(2024, 9, 2),
//         title: "Event 1.2",
//         subtitle: "Subtitle 1.2",
//       ),
//       EventModel(
//         date: DateTime.utc(2024, 9, 5),
//         title: "Event 2",
//         subtitle: "Subtitle 2",
//       ),
//       EventModel(
//         date: DateTime.utc(2024, 9, 10),
//         title: "Event 3",
//         subtitle: "Subtitle 3",
//       ),
//       EventModel(
//         date: DateTime.utc(2024, 9, 15),
//         title: "Event 4",
//         subtitle: "Subtitle 4",
//       ),
//       EventModel(
//         date: DateTime.utc(2024, 9, 20),
//         title: "Event 5",
//         subtitle: "Subtitle 5",
//       ),
//     ];
//   }
// }



// EventsModell eventsModellFromJson(String str) => EventsModell.fromJson(json.decode(str));
//
// String eventsModellToJson(EventsModell data) => json.encode(data.toJson());
//
// class EventsModell {
//   bool? succeeded;
//   int? statusCode;
//   String? status;
//   String? message;
//   List<EventModel>? data;
//
//   EventsModell({
//     this.succeeded,
//     this.statusCode,
//     this.status,
//     this.message,
//     this.data,});
//
//   factory EventsModell.fromJson(Map<String, dynamic> json) => EventsModell(
//     succeeded: json["succeeded"],
//     statusCode: json["statusCode"],
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? [] : List<EventModel>.from(json["data"]!.map((x) => EventModel.fromJson(x))),);
//
//   Map<String, dynamic> toJson() => {
//     "succeeded": succeeded,
//     "statusCode": statusCode,
//     "status": status,
//     "message": message,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),};}
//
//
// class EventModel {
//   final DateTime date;
//   final String title;
//   final String subtitle;
//
//   EventModel({
//     required this.date,
//     required this.title,
//     required this.subtitle,});
//
//   factory EventModel.fromJson(Map<String, dynamic> json) {
//     return EventModel(
//       date: DateTime.parse(json['date']),
//       title: json['tittle'],
//       subtitle: json['subtittle'],
//     );}
//
//   Map<String, dynamic> toJson() {
//     return {
//       'date': date.toIso8601String(),
//       'tittle': title,
//       'subtittle': subtitle,
//     };}}


// To parse this JSON data, do
//
//     final eventsModell = eventsModellFromJson(jsonString);

import 'dart:convert';

EventsModell eventsModellFromJson(String str) => EventsModell.fromJson(json.decode(str));

String eventsModellToJson(EventsModell data) => json.encode(data.toJson());

class EventsModell {
  bool? succeeded;
  int? statusCode;
  String? status;
  String? message;
  List<EventModel>? data;

  EventsModell({
    this.succeeded,
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  factory EventsModell.fromJson(Map<String, dynamic> json) => EventsModell(
    succeeded: json["succeeded"],
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<EventModel>.from(json["data"]!.map((x) => EventModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succeeded": succeeded,
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EventModel {
  String? subtittle;
  String? tittle;
  DateTime? date;

  EventModel({
    this.subtittle,
    this.tittle,
    this.date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
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

// class EventsData {String? subtittle;String? tittle;String? date;EventsData({this.subtittle, this.tittle, this.date,});
//
//   factory EventsData.fromJson(Map<String, dynamic> json) => EventsData(subtittle: json["subtittle"], tittle: json["tittle"], date: json["date"],);
//   Map<String, dynamic> toJson() => {"subtittle": subtittle, "tittle": tittle, "date": date,};}
