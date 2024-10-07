// lib/models/activity.dart

class Activity {
  final String activity;
  final String city;
  final String collectionTime;
  final String svgPath;

  Activity({
    required this.activity,
    required this.city,
    required this.collectionTime,
    required this.svgPath,
  });

  factory Activity.fromMap(Map<String, dynamic> data) {
    return Activity(
      activity: data['activity'] ?? '',
      city: data['city'] ?? '',
      collectionTime: data['collectionTime'] ?? '',
      svgPath: data['svgPath'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activity': activity,
      'city': city,
      'collectionTime': collectionTime,
      'svgPath': svgPath,
    };
  }
}
