import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecosphere/pages/calendar.dart';
import 'package:ecosphere/pages/notifications.dart';
import 'package:ecosphere/pages/user_profile.dart';
import 'package:ecosphere/src/citywidget.dart';
import 'package:ecosphere/src/namewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ecosphere/services/firestore_service.dart';
import 'package:ecosphere/models/schedule.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int rewardPoints = 0; // Initialize reward points
  int lastPointsEarned = 0; // Initialize last points earned
  int _currentIndex = 0; // Keeps track of the selected index on the bottom navigation bar

  final FirestoreService _firestoreService = FirestoreService();
  List<String> _todaySchedules = [];

  @override
  void initState() {
    super.initState();
    _fetchTodaySchedules();
    _initializeRewardPoints();
    _generateRandomLastPoints();
  }

  // Function to initialize reward points from Firestore
  Future<void> _initializeRewardPoints() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      final QuerySnapshot snapshot = await firestore
          .collection('rewardpoints')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final DocumentSnapshot document = snapshot.docs[0];
        setState(() {
          rewardPoints = document['rewardPoints'];
        });
      }
    } catch (e) {
      print('Failed to fetch reward points: $e');
    }
  }

  // Function to generate a random number for last points earned
  void _generateRandomLastPoints() {
    setState(() {
      lastPointsEarned = Random().nextInt(10) + 1; // Random number between 1 and 10
    });
  }

    

  Future<void> _fetchTodaySchedules() async {
    try {
      List<Schedule> schedules = await _firestoreService.getAllSchedules();
      List<String> todayEvents = [];
      DateTime today = DateTime.now();

      for (var schedule in schedules) {
        DateTime scheduleDate = DateTime(schedule.date.year, schedule.date.month, schedule.date.day);
        if (scheduleDate == DateTime(today.year, today.month, today.day)) {
          for (var activity in schedule.activities) {
            String activityStr = '${activity.activity} in ${activity.city} at ${activity.collectionTime}';
            todayEvents.add(activityStr);
          }
        }
      }

      setState(() {
        _todaySchedules = todayEvents;
      });
    } catch (e) {
      // Handle errors appropriately in a real app
      print('Error fetching schedules: $e');
    }
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Row
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
              const SizedBox(height: 10),
              // Date and City Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: const TextStyle(
                      color: Color(0xff028960),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const DisplayCityWidget(),
                ],
              ),
              const SizedBox(height: 30),
              // Today's Waste Collection Section
              Text(
                'Today\'s Waste Collection',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _todaySchedules.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: Text('No waste collection for today.')),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _todaySchedules.length,
                      itemBuilder: (context, index) {
                        final event = _todaySchedules[index];
                        final parts = event.split(' in ');
                        final activity = parts[0];
                        final cityAndTime = parts[1].split(' at ');
                        final city = cityAndTime[0];
                        final collectionTime = cityAndTime[1];

                        String svgPath = _getSvgForActivity(activity);

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9BF3D6),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  svgPath,
                                  width: 40,
                                  height: 40,
                                  semanticsLabel: 'Waste Collection Icon',
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activity,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Text('City: ', style: TextStyle(fontWeight: FontWeight.w600)),
                                          Text(
                                            city,
                                            style: const TextStyle(fontWeight: FontWeight.bold,),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Text('Collection Time: ', style: TextStyle(fontWeight: FontWeight.w600)),
                                          Text(
                                            collectionTime,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                          ),
                        );
                      },
                    ),
              // Recycle Rewards Section
              const SizedBox(height: 30),
              Text(
                'Your Recycle Reward Points',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Reward Points',
                                  style: TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  '$rewardPoints',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Last Points Earned',
                                  style: TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                Text(
                                  '$lastPointsEarned',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Redeem Button
                        ElevatedButton.icon(
                          onPressed: () {
                                  Navigator.pushNamed(context, '/recycle');
                                }, 
                          icon: const Icon(Icons.redeem),
                          label: Text('Redeem - $rewardPoints'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: rewardPoints == 0
                                ? Colors.grey // Disable button color when reward points are 0
                                : Colors.green,
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), 
              
              // Reward Section End

              // Grow with us Section

              const SizedBox(height: 30),
              Text(
                'Grow With Us 🌱',
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Action Buttons
              Column(
                children: [
                  const SizedBox(height: 20),
                  _buildActionButton(
                    label: "Green the Home",
                    onPressed: () {
                      Navigator.pushNamed(context, '/greenthehome');
                    },
                    icon: Icons.spa,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(
                    label: "Sponsor a Tree",
                    onPressed: () {
                      Navigator.pushNamed(context, '/sponsor');
                    },
                    icon: Icons.volunteer_activism,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index != _currentIndex) { // Prevent redundant navigation
            setState(() {
              _currentIndex = index;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _pages[index]),
            );
          }
        },
        selectedItemColor: const Color(0xff276027),
        unselectedItemColor: const Color(0xffB9B9B9),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed, // Ensures all items are displayed
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Added labels for accessibility
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

  // Helper method to build action buttons
  Widget _buildActionButton({
    required String label, 
    required VoidCallback onPressed, 
    required IconData icon, // Add icon as a parameter
  }) {
    return ElevatedButton.icon( // Use ElevatedButton.icon for both text and icon
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff185519),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: onPressed,
      icon: Icon( // Add the icon here
        icon,
        size: 24,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

}
