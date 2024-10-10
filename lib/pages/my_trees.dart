import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tree_details.dart'; // Import the details page

final Map<String, String> treeImages = {
  'Tree 1': 'assets/images/tree1.png',
  'Tree 2': 'assets/images/tree2.png',
  'Tree 3': 'assets/images/tree3.png',
  'Tree 4': 'assets/images/tree4.png',
};

class MyTreesPage extends StatelessWidget {
  const MyTreesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current logged-in user
    User? currentUser = FirebaseAuth.instance.currentUser;

    // Check if the user is logged in
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in to see your trees')),
      );
    }

    String userId = currentUser.uid;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/sponsor');
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
                size: 20,
              ),
            ),
          ),
        ),
        title: const Text(
          'My Trees',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sponsored_trees')
            .where('userId', isEqualTo: userId) // Filter by current user ID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong. Please try again later.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No sponsored trees found.'));
          }

          List<DocumentSnapshot> trees = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trees.length,
            itemBuilder: (context, index) {
              var treeData = trees[index].data() as Map<String, dynamic>;
              String treeName = treeData['treeType'] ?? 'Tree';
              String city = treeData['city'] ?? 'Unknown City';
              String status = treeData['status'] ?? 'Unknown Status';
              String treeImage = treeImages[treeName] ?? 'assets/images/default_tree.png';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TreeDetailsPage(
                        treeName: treeName,
                        city: city,
                        status: status,
                        treeImage: treeImage,
                      ),
                    ),
                  );
                },
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
                      child: Image.asset(
                        treeImage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      treeName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(city),
                        const SizedBox(height: 4),
                        Text(
                          status,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: status == 'healthy'
                                ? Colors.green
                                : status == 'good'
                                    ? Colors.orange
                                    : Colors.red, // Default color for other statuses
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
