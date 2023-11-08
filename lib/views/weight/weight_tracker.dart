import 'package:flutter/material.dart';
import 'package:pregnancy/models/developers.dart'; // Import Developer model here

import '../../widgets/developers.dart'; // Import DeveloperCard and DevelopersList widgets here

class WeightTrackerPage extends StatelessWidget {
  const WeightTrackerPage({Key? key}) : super(key: key); // Remove super.key

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Our Team',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          DevelopersList(),
        ],
      ),
    );
  }
}

class DevelopersList extends StatelessWidget {
  const DevelopersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final developers = Developer.developers;
    return Column(
      children: developers.map((developer) {
        return DeveloperCard(
          developer: developer,
        );
      }).toList(),
    );
  }
}
