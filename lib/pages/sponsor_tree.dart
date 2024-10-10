import 'package:ecosphere/pages/sponsor_payment.dart';
import 'package:flutter/material.dart';

class SponsorTreePage extends StatefulWidget {
  const SponsorTreePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SponsorTreePageState createState() => _SponsorTreePageState();
}

class _SponsorTreePageState extends State<SponsorTreePage> {
  final List<String> cities = ['City 1', 'City 2', 'City 3', 'City 4'];
  String? selectedCity;
  final Map<String, bool> selectedTrees = {
    'Tree 1 - 5000': false,
    'Tree 2 - 7500': false,
    'Tree 3 - 10000': false,
    'Tree 4 - 15000': false,
  };

  final Map<String, String> treeImages = {
    'Tree 1 - 5000': 'assets/images/tree1.png',
    'Tree 2 - 7500': 'assets/images/tree2.png',
    'Tree 3 - 10000': 'assets/images/tree3.png',
    'Tree 4 - 15000': 'assets/images/tree4.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sponsor Trees',
          style: TextStyle(
            color: Color(0xff185519),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16), // Add this line
            // Dropdown for City Selection
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select City',
                labelStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff228B22), // Darker green for label
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: const Color(0xffE8F5E9), // Light green background
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: const Color(0xff66BB6A), // Light green border when enabled
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: const Color(0xff43A047), // Darker green border when focused
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              dropdownColor: const Color(0xffE8F5E9), // Dropdown menu background color (light green)
              value: selectedCity,
              icon: const Icon(
                Icons.arrow_drop_down, // Dropdown arrow icon
                color: Color(0xff388E3C), // Green icon color
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87, // Text color inside dropdown
                fontWeight: FontWeight.w500,
              ),
              items: cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(
                    city,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff2E7D32), // Darker green for dropdown text
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),

            const SizedBox(height: 20),
            // Text for Tree Selection
            const Text(
              'Select Tree',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff185519)),
            ),
            const SizedBox(height: 10),

            // GridView for Tree Images with Checkboxes
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: selectedTrees.keys.length,
                itemBuilder: (context, index) {
                  String tree = selectedTrees.keys.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTrees[tree] = !selectedTrees[tree]!;
                      });
                    },
                    child: Stack(
                      children: [
                        // Tree Image with rounded corners and shadow
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: selectedTrees[tree]!
                                    ? Colors.green.shade400
                                    : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0.5, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                treeImages[tree]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // Checkbox in the top right corner
                        Positioned(
                          
                          right: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedTrees[tree]!
                                  ? Colors.green.shade400
                                  : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              selectedTrees[tree]!
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: selectedTrees[tree]!
                                  ? Colors.white
                                  : Colors.grey,
                              size: 26,
                            ),
                          ),
                        ),

                        // Tree label
                        Positioned(
                          bottom: 60,
                          left: 40,
                          child: Text(
                            tree.split(' - ')[0], // Display Tree 1, Tree 2, etc.
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff185519),
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Spacer
            const SizedBox(height: 20),

            // Sponsor Button
            Center(
              child: ElevatedButton(
                onPressed: selectedCity != null
                    ? () {
                        List<String> sponsoredTrees = selectedTrees.entries
                            .where((element) => element.value)
                            .map((e) => e.key)
                            .toList();
                        int totalAmount = calculateTotalAmount(sponsoredTrees);

                        // Navigate to Payment Page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SponsorPaymentPage(
                              city: selectedCity!,
                              trees: sponsoredTrees,
                              totalAmount: totalAmount,
                            ),
                          ),
                        );
                      }
                    : null, // Disable button if no city selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff185519), // Dark green color for background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  shadowColor: Colors.greenAccent, // Light green shadow for emphasis
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Sponsor Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8), // Space between text and icon
                    Icon(
                      Icons.double_arrow, // Right arrow icon
                      color: Colors.white,  // White icon color to match text
                      size: 24,            // Icon size
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  int calculateTotalAmount(List<String> trees) {
    int total = 0;
    for (String tree in trees) {
      if (tree.contains('5000')) {
        total += 5000;
      } else if (tree.contains('7500')) {
        total += 7500;
      } else if (tree.contains('10000')) {
        total += 10000;
      } else if (tree.contains('15000')) {
        total += 15000;
      }
    }
    return total;
  }
}
