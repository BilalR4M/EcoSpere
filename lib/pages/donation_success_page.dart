import 'package:flutter/material.dart';

import 'green_the_home_donation_history.dart';

class GreenTheHomeDonateSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 150,
                color: theme.colorScheme.secondary,
              ),
              Text(
                'Donation Successful',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      //navigate to home
                    },
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DonationHistoryPage()),
                      );
                    },
                    icon: Icon(Icons.history),
                    label: Text('History'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
