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
      body: SingleChildScrollView(
        child: SafeArea(
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
              const SizedBox(height: 20),
                Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                  'assets/images/indoor_plants.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
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
                    MaterialPageRoute(builder: (context) => const GreenTheHomeDonate()),
                  );
                },
                // child: Text('Donate'),
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
                    MaterialPageRoute(builder: (context) => const GreenTheHomePO()),
                  );
                },
                // child: Text('Donate'),
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
                  // backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.primary,
                  // elevation: 15,
                  side: BorderSide(color: theme.colorScheme.primary, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/donations');
                },
                // child: Text('Donate'),
                icon: const Icon(
                  Icons.history,
                  size: 40,
                ),
                label: const Text('My Donations'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0, // Change this based on the active page
        selectedItemColor: const Color(0xff185519),
        unselectedItemColor: const Color(0xffB9B9B9),
        elevation: 0,
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
      )
    );
    
  }
}
