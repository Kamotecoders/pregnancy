import 'package:flutter/material.dart';
import 'package:pregnancy/models/exercise_data.dart';
import 'package:pregnancy/views/exercise/exercise_card.dart';

class ExerciseCardList extends StatelessWidget {
  final List<Exercises>
      exerciseDataList; // Assuming you have a list of ExerciseData

  ExerciseCardList({required this.exerciseDataList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exerciseDataList.length,
      itemBuilder: (context, index) {
        final exercise = exerciseDataList[index];
        return ExcerciseCard(exercise);
      },
    );
  }
}
