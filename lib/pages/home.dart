import 'package:ecosphere/pages/calendar.dart';
import 'package:ecosphere/pages/notifications.dart';
import 'package:ecosphere/pages/user_profile.dart';
import 'package:ecosphere/src/namewidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // Keeps track of the selected index on the bottom navigation bar

  final List<Widget> _pages = [
    const Home(),          // Home Page
    const CalendarPage(),   // Calendar Page (replace with your actual calendar page)
    const NotificationsPage(), // Notifications Page (replace with actual notifications page)
    const UserProfilePage(), // User Profile Page (replace with actual user profile page)
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
        
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Hello👋,',
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const DisplayNameWidget(),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff185519),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/recycle');
                },
                child: const Text(
                  "Recycle Rewards",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff185519),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/greenthehome');
                },
                child: const Text(
                  "Green the home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff185519),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/sponsor');
                },
                child: const Text(
                  "Sponsor a tree",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff185519),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                child: const Text(
                  "Waste Schedule",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
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


