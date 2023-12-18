import 'package:pregnancy/models/quiz.dart';

class Assessments {
  String id;
  final String userID;
  final List<QuizQuestion> quizList;
  final List<int> answers;
  final int score;
  final DateTime createdAt;

  Assessments({
    required this.id,
    required this.userID,
    required this.quizList,
    required this.answers,
    required this.score,
    required this.createdAt,
  });

  // Convert AssessmentScore to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'quizList': quizList.map((question) => question.toJson()).toList(),
      'answers': answers,
      'score': score,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Assessments.fromJson(Map<String, dynamic> json) {
    return Assessments(
      id: json['id'],
      userID: json['userID'],
      quizList: (json['quizList'] as List)
          .map((questionJson) => QuizQuestion.fromJson(questionJson))
          .toList(),
      answers: List<int>.from(json['answers']),
      score: json['score'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
