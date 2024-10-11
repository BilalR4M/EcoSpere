import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class RecycleRewardPage extends StatefulWidget {
  const RecycleRewardPage({super.key});

  @override
  _RecycleRewardPageState createState() => _RecycleRewardPageState();
}

class _RecycleRewardPageState extends State<RecycleRewardPage> {
  int rewardPoints = 0; // Initialize rewardPoints
  int lastPointsEarned = 0; // Set lastPointsEarned to 0 initially

  @override
  void initState() {
    super.initState();
    _initializeRewardPoints();
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
          lastPointsEarned = document['lastPointsEarned'];
        });
      }
    } catch (e) {
      print('Failed to fetch reward points: $e');
    }
  }

  // Function to add reward points to Firestore
  // Function to add reward points to Firestore and update the UI immediately
  Future<void> _addRewardPoints() async {
    // Generate new random points when the button is pressed
    int pointsEarned = Random().nextInt(10) + 1;

    // Reference to Firestore
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Find the user's document in the 'rewardpoints' collection and update it
      final QuerySnapshot snapshot = await firestore
          .collection('rewardpoints')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      
      if (snapshot.docs.isNotEmpty) {
        // Get the document ID of the first match
        final String docId = snapshot.docs[0].id;

        // Update the existing record in Firestore
        await firestore.collection('rewardpoints').doc(docId).update({
          'rewardPoints': FieldValue.increment(pointsEarned),
          'lastPointsEarned': pointsEarned,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Update the local state immediately
        setState(() {
          rewardPoints += pointsEarned;
          lastPointsEarned = pointsEarned;
        });

        print('Points updated successfully');
      } else {
        // If no document is found, create a new one
        await firestore.collection('rewardpoints').add({
          'userId': userId,
          'rewardPoints': pointsEarned,
          'lastPointsEarned': pointsEarned,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Set initial reward points in the state
        setState(() {
          rewardPoints = pointsEarned;
          lastPointsEarned = pointsEarned;
        });

        print('New points document created');
      }
    } catch (e) {
      print('Failed to update points: $e');
    }
}


  // Function to show a warning if trying to redeem with 0 points
  void _showWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You need to have reward points to redeem!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color(0xffF7F7F9),
              shape: BoxShape.circle
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addRewardPoints,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'Recycle & Win',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  
                  // Reward Points Section
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
                          onPressed: rewardPoints == 0
                              ? _showWarning // Show warning if reward points are 0
                              : () {
                                  Navigator.pushNamed(context, '/rewardredeem');
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
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            
            // Summary Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                DropdownButton<String>(
                  value: 'Month',
                  items: <String>['Month', 'Year'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Summary Cards
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Food Waste Card
                WasteSummaryCard(
                  wasteType: 'Food Waste',
                  wasteAmount: '15',
                  iconData: Icons.food_bank,
                  color: Colors.purpleAccent,
                ),
                // Glass Waste Card
                WasteSummaryCard(
                  wasteType: 'Glass Waste',
                  wasteAmount: '10',
                  iconData: Icons.local_drink,
                  color: Colors.lightBlueAccent,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Paper Waste Card
                WasteSummaryCard(
                  wasteType: 'Paper Waste',
                  wasteAmount: '5',
                  iconData: Icons.book,
                  color: Colors.orangeAccent,
                ),
                // Plastic Waste Card
                WasteSummaryCard(
                  wasteType: 'Plastic Waste',
                  wasteAmount: '8',
                  iconData: Icons.shopping_bag,
                  color: Colors.redAccent,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Change this based on the active page
        selectedItemColor: const Color(0xff185519),
        unselectedItemColor: const Color(0xffB9B9B9),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
        onTap: (index) {
          // Handle navigation based on the tapped item
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/calendar');
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}

class WasteSummaryCard extends StatelessWidget {
  final String wasteType;
  final String wasteAmount;
  final IconData iconData;
  final Color color;

  const WasteSummaryCard({
    super.key,
    required this.wasteType,
    required this.wasteAmount,
    required this.iconData,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: color,
          ),
          const SizedBox(height: 10),
          Text(
            wasteType,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            '$wasteAmount Kg',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
