import 'package:flutter/material.dart';
import 'package:pregnancy/models/lessons.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class LessonsCard extends StatelessWidget {
  final Lessons lessons;
  const LessonsCard({super.key, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 220, 246, 235),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                lessons.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                lessons.description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
