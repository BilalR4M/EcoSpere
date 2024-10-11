import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  
  @override
  void initState() {
    super.initState();
    _resetRewardPoints();
  }

  Future<void> _resetRewardPoints() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Update the rewardPoints to zero for the current user in Firestore
      final userRef = FirebaseFirestore.instance
          .collection('rewardpoints')
          .where('userId', isEqualTo: userId);

      // Fetch the document of the current user
      final snapshot = await userRef.get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id; // Get the document ID
        FirebaseFirestore.instance
            .collection('rewardpoints')
            .doc(docId)
            .update({'rewardPoints': 0});
      }
    } catch (e) {
      print("Failed to reset reward points: $e");
    }
  }

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
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/recycle');
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color(0xffF7F7F9),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Congrats!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              // Success Card
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF4ADE80).withOpacity(0.2), // Light green background
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.check,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Points exchanged\nSuccessfully!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Buttons
              Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle Go Back action
                        Navigator.pushNamed(context, '/recycle');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF185519)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 30), // Full width button
                      ),
                      child: const Text(
                        'Go Back',
                        style: TextStyle(
                          color: Color(0xFF185519),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Exchange History action
                        Navigator.pushNamed(context, '/exchange_history');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF185519), // Dark green background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        minimumSize: const Size(double.infinity, 30),
                      ),
                      child: const Text(
                        'Exchange History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
