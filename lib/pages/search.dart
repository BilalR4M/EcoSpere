import 'package:ecosphere/models/schedule.dart';
import 'package:ecosphere/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async'; // Importing Timer

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirestoreService _firestoreService = FirestoreService();

  String _selectedCity = 'All';
  String _searchQuery = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // Debounce function for the search input
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query;
      });
    });
  }

  // Helper function to get the SVG path based on the waste collection type
  String _getSvgForActivity(String activity) {
    switch (activity) {
      case 'Recyclable Waste Collection':
        return 'assets/icons/recyclable_waste.svg';
      case 'E-Waste Collection':
        return 'assets/icons/e_waste.svg';
      case 'Battery Collection':
        return 'assets/icons/battery_waste.svg';
      case 'Plastics Recycling Collection':
        return 'assets/icons/plastics_recycling.svg';
      default:
        return 'assets/icons/default_waste.svg'; // Fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Schedules'),
        backgroundColor: const Color(0xff185519),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Schedule>>(
          stream: _firestoreService.getAllSchedulesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching schedules.'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No schedules available.'));
            }

            List<Schedule> schedules = snapshot.data!;

            // Extract unique cities
            Set<String> citySet = {};
            for (var schedule in schedules) {
              for (var activity in schedule.activities) {
                citySet.add(activity.city);
              }
            }
            List<String> cities = ['All', ...citySet.toList()];

            // Apply filters
            List<Schedule> filteredSchedules = schedules.where((schedule) {
              bool matchesCity = _selectedCity == 'All' ||
                  schedule.activities.any((activity) => activity.city == _selectedCity);
              bool matchesSearch = _searchQuery.isEmpty ||
                  schedule.activities.any((activity) => activity.activity
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()));
              return matchesCity && matchesSearch;
            }).toList();

            return Column(
              children: [
                // Search Bar
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search by Activity',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _onSearchChanged, // Using debounced search
                ),
                const SizedBox(height: 16),
                // Dropdown for City Filter
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: const InputDecoration(
                    labelText: 'Sort by City',
                    border: OutlineInputBorder(),
                  ),
                  items: cities.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Display Filtered Schedules
                Expanded(
                  child: filteredSchedules.isEmpty
                      ? const Center(child: Text('No schedules found.'))
                      : ListView.builder(
                          itemCount: filteredSchedules.length,
                          itemBuilder: (context, index) {
                            Schedule schedule = filteredSchedules[index];
                            return ExpansionTile(
                              title: Text(
                                '${schedule.date.toLocal()}'.split(' ')[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              children: schedule.activities.map((activity) {
                                String svgPath =
                                    _getSvgForActivity(activity.activity);
                                return ListTile(
                                  leading: SvgPicture.asset(
                                    svgPath,
                                    width: 40,
                                    height: 40,
                                    semanticsLabel: 'Waste Collection Icon',
                                  ),
                                  title: Text(activity.activity),
                                  subtitle: Text(
                                      'City: ${activity.city}  |  Collection Time: ${activity.collectionTime}'),
                                );
                              }).toList(),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
