import 'package:pregnancy/models/quiz.dart';

class QuizServiceImpl {
  final List<QuizQuestion> _questions;
  List<String?> _answers;
  QuizServiceImpl({required List<QuizQuestion> questions})
      : _questions = questions,
        _answers = List<String?>.filled(questions.length, null) {}

  void answerQuestion(int questionIndex, String? answer) {
    _answers[questionIndex] = answer;
  }

  void printQuestions() {
    print(_questions);
    print(_answers);
  }

  List<String?> getAnswers() => _answers;

  int? isAnswered(int index, String? indexToAlphabet) {
    if (_answers[index] == null) {
      return null;
    }
    return index;
  }
}
