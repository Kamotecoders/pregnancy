import 'package:pregnancy/models/exercise_data.dart';

class ExercisePlanner {
  final String trimester;
  final List<Exercises> exercises;

  ExercisePlanner({required this.trimester, required this.exercises});

  factory ExercisePlanner.fromJson(Map<String, dynamic> json) {
    final trimester = json['trimester'];
    final exercisesList = json['exercises'] as List<dynamic>;
    final exercises = exercisesList.map((exerciseJson) {
      return Exercises.fromJson(exerciseJson as Map<String, dynamic>);
    }).toList();

    return ExercisePlanner(trimester: trimester, exercises: exercises);
  }
  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> exercisesJson =
        exercises.map((exercise) => exercise.toJson()).toList();
    return {
      'trimester': trimester,
      'exercises': exercisesJson,
    };
  }
}
