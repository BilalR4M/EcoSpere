import 'package:ecosphere/pages/home.dart';
import 'package:ecosphere/pages/notifications.dart';
import 'package:ecosphere/pages/search.dart';
import 'package:ecosphere/pages/user_profile.dart';
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
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _currentIndex = 1; // Set index to 1 for the Calendar page
  CalendarFormat _calendarFormat = CalendarFormat.week;
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

  String _getSvgForActivity(String activity) {
    switch (activity) {
      case 'Recyclable Waste Collection':
        return 'assets/icons/recyclable_waste.svg';
      case 'E-Waste Collection':
        return 'assets/icons/e_waste.svg';
      case 'Battery Collection':
        return 'assets/icons/battery_waste.svg';
      case 'Plastics Recycling Collection':
        return 'assets/icons/plastics_recycling.svg';
      case 'Organic Waste Collection':
        return 'assets/icons/organic.svg';
      case 'Hazardous Waste Collection':
        return 'assets/icons/hazardous.svg';
      case 'Medical Waste Collection':
        return 'assets/icons/medical.svg';
      default:
        return 'assets/icons/default_waste.svg'; 
    }
  }

  final List<Widget> _pages = [
    const Home(), 
    const CalendarPage(),  
    const NotificationsPage(),
    const UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          height: 80,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color(0xffF7F7F9),
              shape: BoxShape.circle
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
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
                color: Color.fromARGB(255, 20, 201, 107),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xff028960),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Divider(
            endIndent: 16,
            indent: 8,
            color: Colors.black.withOpacity(0.5),
            thickness: 0.5,
          ),
          const SizedBox(height: 8.0),
          const Center(
            child: Text(
            'Waste Schedules',
            style: TextStyle(
              color: Colors.black, 
              fontSize: 20, 
              fontWeight: FontWeight.bold,
            ),
          )),
          const SizedBox(height: 8.0),
          Expanded(
            child: _getEventsForDay(_selectedDay ?? _focusedDay).isEmpty
                ? const Center(child: Text('No schedules for this day.'))
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: _getEventsForDay(_selectedDay ?? _focusedDay).map((event) {
                      final parts = event.split(' in ');
                      final activity = parts[0];
                      final cityAndTime = parts[1].split(' at ');
                      final city = cityAndTime[0];
                      final collectionTime = cityAndTime[1];
                      
                      String svgPath = _getSvgForActivity(activity); 

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0), 
                        padding: const EdgeInsets.all(4.0), 
                        decoration: BoxDecoration(
                          color: const Color(0xFF9BF3D6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: SvgPicture.asset(
                            svgPath,
                            width: 40, 
                            height: 40,
                            semanticsLabel: 'Waste Collection Icon',
                          ),
                          title: Text(activity),
                          subtitle: Row(
                            children: [
                              const Text('City: '),
                              Text(city, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8.0),
                              const Text('Collection Time: '),
                              Text(collectionTime, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _pages[index]),
            );
          });
        },
        selectedItemColor: const Color(0xff276027),
        unselectedItemColor: const Color(0xffB9B9B9),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
