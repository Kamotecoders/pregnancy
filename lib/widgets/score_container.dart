import 'package:flutter/material.dart';

class ScoreContainer extends StatelessWidget {
  final int score;
  const ScoreContainer({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 88, // Set the width and height to create a circle
          height: 88,
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // Create a circular shape
            image: DecorationImage(
              image: AssetImage(
                  'lib/images/circle.png'), // Replace with your image path
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
        ),
        Center(
          child: Text(
            "$score",
            style: const TextStyle(
              fontSize: 32,
              color: Color(0xFF004643), // Use the color #004643
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
