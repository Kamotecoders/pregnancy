import 'package:flutter/material.dart';

import '../../models/exercise_data.dart';

class ExcerciseCard extends StatelessWidget {
  final Exercises exercise;

  const ExcerciseCard(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height:
                  100, // Set the desired height for the container (match parent's height)
              width:
                  100, // Set the desired width for the container (adjust as needed)
              child: Image.network(
                exercise.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  exercise.description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Duration: ${exercise.duration}',
                ),
                Text(
                  'Frequency: ${exercise.frequency}',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
