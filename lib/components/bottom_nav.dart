import 'package:flutter/material.dart';
import 'package:ecosphere/pages/calendar.dart';
import 'package:ecosphere/pages/home.dart';
import 'package:ecosphere/pages/notifications.dart';
import 'package:ecosphere/pages/user_profile.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;

  const BottomNav({Key? key, required this.currentIndex}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _currentIndex;
  final List<Widget> _pages = [
    const Home(),          // Home Page
    const CalendarPage(),   // Calendar Page
    const NotificationsPage(), // Notifications Page
    const UserProfilePage(), // User Profile Page
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex; // Set initial index based on the passed parameter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav(currentIndex: index)),
          );
        },
        selectedItemColor: const Color(0xff276027),
        unselectedItemColor: const Color(0xffB9B9B9),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
