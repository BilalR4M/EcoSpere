import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String id;
  final DateTime date;
  final String activity;

  Schedule({
    required this.id,
    required this.date,
    required this.activity,
  });

  factory Schedule.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Schedule(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      activity: data['activity'] ?? '',
    );
  }
}
