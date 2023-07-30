import 'package:flutter/material.dart';

import '../components/browse_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'What do you want to listen to today?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    BrowseCategory(title: 'Top Podcasts'),
                    BrowseCategory(
                      title: 'Technology Podcasts',
                      genre: 'Technology',
                    ),
                    BrowseCategory(
                      title: 'Sports Podcasts',
                      genre: 'Sports',
                    ),
                    BrowseCategory(
                      title: 'Business Podcasts',
                      genre: 'Business',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
