import 'package:ecosphere/pages/green_the_home.dart';
import 'package:ecosphere/services/authwrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:ecosphere/pages/calendar.dart';
import 'package:ecosphere/pages/home.dart';
import 'package:ecosphere/pages/my_trees.dart';
import 'package:ecosphere/pages/sponsor_tree.dart';
import 'package:ecosphere/pages/sponsor.dart';
import 'package:ecosphere/pages/user_profile.dart';
import 'package:ecosphere/pages/sponsor_overview_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Ecosphere());
}

class Ecosphere extends StatelessWidget {
  const Ecosphere({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecosphere',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff276027),
        colorScheme: ColorScheme.light(
          primary: const Color(0xff276027),       // Primary color for buttons
          onPrimary: Colors.white,     // Text/icon color on primary buttons
          secondary: const Color.fromARGB(255, 41, 94, 41),      // Secondary color for accents
          onSecondary: Colors.white,   // Text/icon color on secondary elements
          surface: Colors.grey[100]!,  // Surface color
          onSurface: Colors.black,     // Text color on surfaces
          error: Colors.red,           // Error color
          onError: Colors.white,       // Error text color
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          ),
        ), 
      debugShowCheckedModeBanner: false,

      // Initial route based on user authentication state
      home: const AuthWrapper(), 

      //routes
      routes: {
        '/calendar': (context) => const CalendarPage(), // Define the calendar route
        '/user_profile': (context) => const UserProfilePage(), // Define the user profile route
        '/sponsor': (context) => const SponsorPage(), // Define the sponsor route
        '/sponsor_overview': (context) => const SponsorOverviewPage(), // Define the sponsor overview route
        '/sponsorpage': (context) => const SponsorTreePage(), // Define the sponsor tree route
        '/mytrees': (context) => const MyTreesPage(), // Define the my trees route
        '/greenthehome': (context) => const GreenTheHomePage(), // Define the home route
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const Home());
      },
    );
  }
}