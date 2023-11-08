import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:pregnancy/models/developers.dart';

class DeveloperCard extends StatelessWidget {
  final Developer developer;

  DeveloperCard({
    required this.developer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.all(12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Image.asset(
              developer.image,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  developer.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  developer.role,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  developer.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
