import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/schedule.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all schedules
  Future<List<Schedule>> getAllSchedules() async {
    try {
      QuerySnapshot snapshot = await _db.collection('schedules').get();
      return snapshot.docs.map((doc) => Schedule.fromDocument(doc)).toList();
    } catch (e) {
      log('Error fetching schedules: $e');
      return [];
    }
  }

  // Optionally, fetch schedules for a specific date
  Future<List<Schedule>> getSchedulesForDate(DateTime date) async {
    try {
      // Assuming 'date' field is stored as Timestamp in Firestore
      // We need to fetch schedules where the 'date' is the same day
      DateTime startOfDay = DateTime(date.year, date.month, date.day);
      DateTime endOfDay = startOfDay.add(Duration(days: 1));

      QuerySnapshot snapshot = await _db
          .collection('schedules')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThan: Timestamp.fromDate(endOfDay))
          .get();

      return snapshot.docs.map((doc) => Schedule.fromDocument(doc)).toList();
    } catch (e) {
      log('Error fetching schedules for date: $e');
      return [];
    }
  }
}