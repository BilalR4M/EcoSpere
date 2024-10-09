import 'package:ecosphere/pages/home.dart';
import 'package:ecosphere/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the snapshot has a valid user, navigate to Home, else go to Login
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for authentication state
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const Home(); // User is logged in, go to Home
        } else {
          return Login(); // User is not logged in, go to Login
        }
      },
    );
  }
}