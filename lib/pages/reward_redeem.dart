import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExchangePointsPage extends StatelessWidget {
  const ExchangePointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int rewardPoints = 0; // Store reward points here

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
            Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Section
            Text(
              'Exchange Points',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Points Display
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('rewardpoints')
                  .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No data found');
                } else {
                  // Fetch the first document from the results (assuming userId is unique)
                  var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                  rewardPoints = data['rewardPoints'] ?? 0;

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '$rewardPoints',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),

            // Exchange Option Cards
            ExchangeOptionCard(
              title: 'Cash',
              subtitle: 'Reward as cash',
              icon: Icons.monetization_on,
              onTap: () => _showCashDialog(context, rewardPoints), // Pass the rewardPoints
            ),
            const SizedBox(height: 16),
            ExchangeOptionCard(
              title: 'Garbage Equipment',
              subtitle: 'Free garbage equipment',
              icon: Icons.cleaning_services,
              onTap: () => _showEquipmentDialog(context, rewardPoints), // Pass the rewardPoints
            ),
            const SizedBox(height: 16),
            ExchangeOptionCard(
              title: '1 Free Food collection',
              subtitle: 'Free food waste collection',
              icon: Icons.local_shipping,
              onTap: () => _showDateDialog(context, rewardPoints), // Pass the rewardPoints
            ),
          ],
        ),
      ),
    );
  }

  // Function to store exchange data in Firestore
  Future<void> _storeExchange(int points) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('exchanges').add({
      'userId': userId,
      'exchangePoints': points,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Cash exchange confirmation dialog
  void _showCashDialog(BuildContext context, int points) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Exchange"),
          content: const Text("Do you want to exchange points for cash?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Perform exchange logic and store it in Firebase
                await _storeExchange(points);
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  // Garbage equipment selection dialog
  void _showEquipmentDialog(BuildContext context, int points) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Equipment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text("Garbage Bag"), onTap: () {}),
              ListTile(title: const Text("Garbage Bin"), onTap: () {}),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Perform exchange logic and store it in Firebase
                await _storeExchange(points);
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  // Date picker dialog for scheduling
  void _showDateDialog(BuildContext context, int points) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Schedule Collection"),
          content: ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: const Text("Choose Date"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Perform exchange logic and store it in Firebase
                await _storeExchange(points);
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  // Date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Handle the selected date here
    }
  }

  // Success dialog after exchange
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Congrats!"),
          content: const Text("Points exchanged successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exchange_success');
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class ExchangeOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const ExchangeOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}