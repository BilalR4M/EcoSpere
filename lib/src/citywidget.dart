import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayCityWidget extends StatelessWidget {
  const DisplayCityWidget({super.key});

  Future<String?> getUserCity() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        return userDoc.get('city'); // Fetch the city field
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserCity(), // Call the method to fetch the user's city
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return const Text('Error fetching city');
        } else if (snapshot.hasData && snapshot.data != null) {
          return Text(
            '${snapshot.data!}⨺',
            style: const TextStyle(
              color: Color(0xff028960),
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          );
        } else {
          return const Text('City not available');
        }
      },
    );
  }
}
