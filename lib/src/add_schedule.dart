import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSchedules() async {
    // Sample waste schedules
    List<Map<String, dynamic>> schedules = [
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-08T00:00:00Z')),
        'activity': ['Recyclable Waste Collection', 'E-Waste Collection', 'Battery Collection', 'Plastics Recycling Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-10T00:00:00Z')),
        'activity': ['Organic Waste Collection', 'General Waste Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-12T00:00:00Z')),
        'activity': ['General Waste Collection', 'Hazardous Waste Collection', 'Medical Waste Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-15T00:00:00Z')),
        'activity': ['E-Waste Collection', 'Recyclable Waste Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-18T00:00:00Z')),
        'activity': ['Hazardous Waste Collection', 'Plastics Recycling Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-20T00:00:00Z')),
        'activity': ['Bulky Waste Collection', 'Medical Waste Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-25T00:00:00Z')),
        'activity': ['Yard Waste Collection', 'Battery Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-10-30T00:00:00Z')),
        'activity': ['Medical Waste Collection', 'Recyclable Waste Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-11-01T00:00:00Z')),
        'activity': ['Battery Collection', 'Hazardous Waste Collection'],
      },
      {
        'date': Timestamp.fromDate(DateTime.parse('2024-11-05T00:00:00Z')),
        'activity': ['Plastics Recycling Collection', 'E-Waste Collection'],
      }

    ];

    for (var schedule in schedules) {
      await _firestore.collection('schedules').add(schedule);
    }

    log('Schedules added successfully');
  }
}
