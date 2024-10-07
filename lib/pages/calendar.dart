// lib/pages/calendar_page.dart


import 'package:ecosphere/pages/search.dart';
import 'package:ecosphere/src/add_schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ecosphere/models/schedule.dart';
import 'package:ecosphere/services/firestore_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final FirestoreService _firestoreService = FirestoreService();
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _fetchSchedules();
  }
  
  String getFormattedDay() {
    // If a day is selected, show its day name, otherwise show "Today"
  return _selectedDay != null 
      ? DateFormat('EEEE').format(_selectedDay!) 
      : 'Today';
  }


  Future<void> _fetchSchedules() async {
    List<Schedule> schedules = await _firestoreService.getAllSchedules();
    Map<DateTime, List<String>> events = {};

    for (var schedule in schedules) {
      DateTime day = DateTime(schedule.date.year, schedule.date.month, schedule.date.day);
      if (events[day] == null) {
        events[day] = [];
      }
      for (var activity in schedule.activities) {
        String activityStr = '${activity.activity} in ${activity.city} at ${activity.collectionTime}';
        events[day]!.add(activityStr);
      }
    }

    setState(() {
      _events = events;
    });
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  /// Helper function to get the SVG path based on the waste collection type
  String _getSvgForActivity(String activity) {
    switch (activity) {
      case 'Recyclable Waste Collection1':
        return 'assets/icons/recyclable_waste.svg';
      case 'E-Waste Collection1':
        return 'assets/icons/e_waste.svg';
      case 'Battery Collection1':
        return 'assets/icons/battery_waste.svg';
      case 'Plastics Recycling Collection':
        return 'assets/icons/plastics_recycling.svg';
      // Add more cases for other activity types
      default:
        return 'assets/icons/default_waste.svg'; // Fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Schedule', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff185519),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,),
            onPressed: () {
              // Navigate to the SearchPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ScheduleService().addSchedules();
          _fetchSchedules();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Center(child: Text(getFormattedDay(), style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
          TableCalendar<String>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Divider(),
          const SizedBox(height: 8.0),
          const Center(
            child: Text(
            'Schedules',
            style: TextStyle(
              color: Colors.black, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),)),
          const SizedBox(height: 8.0),
          Expanded(
            child: _getEventsForDay(_selectedDay ?? _focusedDay).isEmpty
                ? const Center(child: Text('No schedules for this day.'))
                : ListView(
                    children: _getEventsForDay(_selectedDay ?? _focusedDay).map((event) {
                      // Assuming `event` is a String in the format 'activity in city at collectionTime'
                      final parts = event.split(' in ');
                      final activity = parts[0];
                      final cityAndTime = parts[1].split(' at ');
                      final city = cityAndTime[0];
                      final collectionTime = cityAndTime[1];
                      
                      // Select an SVG asset based on the activity
                      String svgPath = _getSvgForActivity(activity); // Helper function

                      return ListTile(
                        leading: SvgPicture.asset(
                          svgPath,
                          width: 40, // Set the size of the SVG icon
                          height: 40,
                          semanticsLabel: 'Waste Collection Icon',
                        ),
                        title: Text(activity),
                        subtitle: Text('City: $city  |  Collection Time: $collectionTime'),
                      );
                    }).toList(),
                  ),
          )
  
        ],
      ),
    );
  }
}
