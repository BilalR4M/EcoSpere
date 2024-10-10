import 'package:flutter/material.dart';

import 'green_the_home_ov.dart';
import 'green_the_home_donate.dart';

class GreenTheHomePage extends StatelessWidget {
  const GreenTheHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final style2 =
        TextStyle(letterSpacing: 5, color: theme.colorScheme.primary);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                    size: 20,
                  ),
                ),
              ),
            ),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/indoor_plants.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Join our indoor plant distribution program to bring more greenery into your home. '
                    'We provide a variety of indoor plants that are easy to care for and perfect for any living space. '
                    'Sign up today and start your journey towards a greener, healthier home!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 20),
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
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GreenTheHomeDonate()),
                    );
                  },
                  icon: const Icon(
                    Icons.volunteer_activism,
                    size: 40,
                  ),
                  label: const Text('Donate'),
                ),
                const SizedBox(height: 20),
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
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GreenTheHomePO()),
                    );
                  },
                  icon: const Icon(
                    Icons.book,
                    size: 40,
                  ),
                  label: const Text('Program Overview'),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    fixedSize: const Size(300, 80),
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: theme.colorScheme.primary,
                    side: BorderSide(color: theme.colorScheme.primary, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  icon: const Icon(
                    Icons.history,
                    size: 40,
                  ),
                  label: const Text('My Donations'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        selectedItemColor: const Color(0xff276027),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation based on tapped icon
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Adjust route as needed
              break;
            case 1:
              Navigator.pushNamed(context, '/calendar'); // Adjust route as needed
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications'); // Adjust route as needed
              break;
            case 3:
              Navigator.pushNamed(context, '/user_profile'); // Adjust route as needed
              break;
          }
        },
      ),
    );
  }
}
