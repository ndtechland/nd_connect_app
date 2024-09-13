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
class EventModel {
  final DateTime date;
  final String title;
  final String subtitle;

  EventModel({
    required this.date,
    required this.title,
    required this.subtitle,
  });

  // Convert a JSON map to an EventModel instance
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      date: DateTime.parse(json['date']),
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  // Convert an EventModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'title': title,
      'subtitle': subtitle,
    };
  }
}


///
// lib/models/static_event_data.dart

// lib/models/static_event_data.dart

class StaticEventData {
  static List<EventModel> getEvents() {
    return [
      EventModel(
        date: DateTime.utc(2024, 9, 2),
        title: "Event 1",
        subtitle: "Subtitle 1",
      ),
      EventModel(
        date: DateTime.utc(2024, 9, 2),
        title: "Event 1.2",
        subtitle: "Subtitle 1.2",
      ),
      EventModel(
        date: DateTime.utc(2024, 9, 5),
        title: "Event 2",
        subtitle: "Subtitle 2",
      ),
      EventModel(
        date: DateTime.utc(2024, 9, 10),
        title: "Event 3",
        subtitle: "Subtitle 3",
      ),
      EventModel(
        date: DateTime.utc(2024, 9, 15),
        title: "Event 4",
        subtitle: "Subtitle 4",
      ),
      EventModel(
        date: DateTime.utc(2024, 9, 20),
        title: "Event 5",
        subtitle: "Subtitle 5",
      ),
    ];
  }
}