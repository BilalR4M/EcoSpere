import 'package:ecosphere/pages/calendar.dart';
import 'package:ecosphere/pages/home.dart';
import 'package:ecosphere/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),

      //routes
      routes: {
        '/calendar': (context) => const CalendarPage(), // Define the calendar route
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const Home());
      },
    );
    
  }
}