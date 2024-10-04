class LeaveLeftModel {
  final String title;
  final String subtitle;

  LeaveLeftModel({
    required this.title,
    required this.subtitle,
  });

  // Convert a JSON map to an LeaveLeftModel instance
  factory LeaveLeftModel.fromJson(Map<String, dynamic> json) {
    return LeaveLeftModel(
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  // Convert an LeaveLeftModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}


///
// lib/models/static_event_data.dart

// lib/models/static_event_data.dart

class StaticLeaveData {
  static List<LeaveLeftModel> getLeaves() {
    return [
      LeaveLeftModel(
        title: "Event 1",
        subtitle: "Subtitle 1",
      ),
      LeaveLeftModel(
        title: "Event 1.2",
        subtitle: "Subtitle 1.2",
      ),
      LeaveLeftModel(
        title: "Event 2",
        subtitle: "Subtitle 2",
      ),
      LeaveLeftModel(
        title: "Event 3",
        subtitle: "Subtitle 3",
      ),
      LeaveLeftModel(
        title: "Event 4",
        subtitle: "Subtitle 4",
      ),
      LeaveLeftModel(
        title: "Event 5",
        subtitle: "Subtitle 5",
      ),
    ];
  }
}