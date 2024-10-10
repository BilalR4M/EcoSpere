import 'dart:async';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to HomeScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // Add gradient background
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF006400), // Dark Green at the bottom
                Color(0xFF00FF7F), // Light Green at the top
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section (Text + Icon)
              SizedBox(
                height: 100,
                child: Image.asset('assets/light_logo.png'),
              ),

              const SizedBox(height: 16.0),
              // Welcome Message Section
              Text(
                'Welcome to Ecosphere!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[50],
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Thank you for joining our mission to make the world greener and more sustainable. Let\'s plant trees, reduce waste, and create a cleaner future together. Ready to make an impact today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

