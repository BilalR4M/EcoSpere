import 'package:flutter/material.dart';

class SponsorOverviewPage extends StatelessWidget {
  const SponsorOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final style2 = TextStyle(letterSpacing: 5, color: theme.colorScheme.primary);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sponsor A Tree', style: style1),
                        Text(
                          'Contribute to a Greener Future',
                          style: style2,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Program Overview',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    Icon(
                      Icons.park_outlined,
                      size: 40,
                      color: theme.colorScheme.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Section 1: How it works
                _buildSection(
                  context,
                  title: "How it works",
                  description:
                      "Sponsor a tree, make a donation, and track its growth with real-time updates through the app.",
                  imageUrl: 'assets/images/how_it_works.png',
                ),
                const SizedBox(height: 32),
                // Section 2: Purpose of the program
                _buildSection2(
                  context,
                  title: "Purpose of the program",
                  description:
                      "To encourage individuals to contribute to urban greening and environmental sustainability.",
                  imageUrl: 'assets/images/purpose.png',
                ),
                const SizedBox(height: 32),
                // Section 3: Impact so far
                _buildSection(
                  context,
                  title: "Impact so far",
                  description:
                      "Helps reduce carbon footprint, improve air quality, and foster greener urban spaces.",
                  imageUrl: 'assets/images/impact.png',
                ),
                const SizedBox(height: 64),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 80),
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the sponsor tree page
                    Navigator.pushNamed(context, '/sponsorpage');
                  },
                  icon: const Icon(
                    Icons.volunteer_activism,
                    size: 40,
                  ),
                  label: const Text('Sponsor'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSection(BuildContext context,
    {required String title, required String description, required String imageUrl}) {
  return Row(
    children: [
      Container(
        width: 200,
        height: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 10.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildSection2(BuildContext context,
    {required String title, required String description, required String imageUrl}) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
      const SizedBox(width: 10.0),
      Container(
        width: 200,
        height: 155,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}
