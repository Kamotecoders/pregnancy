import 'package:flutter/material.dart';
import 'package:pregnancy/styles/color_pallete.dart';
import 'package:pregnancy/widgets/lessons_card.dart';

import '../../../models/lessons.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Lesson",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          backgroundColor: ColorStyle.primary,
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Lessons",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              ListLessons()
            ],
          ),
        ));
  }
}

class ListLessons extends StatelessWidget {
  const ListLessons({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = Lessons.lesson1;
    return Column(
      children: lessons.map((lesson) {
        return LessonsCard(
          lessons: lesson,
        );
      }).toList(),
    );
  }
}
