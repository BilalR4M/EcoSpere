import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationHistoryPage extends StatelessWidget {
  const DonationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current logged-in user
    User? currentUser = FirebaseAuth.instance.currentUser;

    final theme = Theme.of(context);
    theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final style2 =
        TextStyle(letterSpacing: 5, color: theme.colorScheme.primary);

    // Check if the user is logged in
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to see your donations')),
      );
    }

    String userId = currentUser.uid;

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Green the Home', style: style1),
                  Text(
                    'Plant distribution program',
                    style: style2,
                  ),
                ],
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('indoor_plant_donations')
                .where('userId', isEqualTo: userId) // Filter by current user ID
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(
                    child:
                        Text('Something went wrong. Please try again later.'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No donations found.'));
              }

              List<DocumentSnapshot> donations = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: donations.length,
                itemBuilder: (context, index) {
                  var donationData =
                      donations[index].data() as Map<String, dynamic>;
                  String amount = donationData['amount'] ?? '0.00';
                  DateTime dateTime =
                      donationData['timestamp'] ?? FieldValue.serverTimestamp();

                  return GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Icon(Icons.grass)),
                        title: Text(
                          amount,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${dateTime.toLocal()}'.split(' ')[0]),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
