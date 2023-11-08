class QuizQuestion {
  final int id;
  final String question;
  final List<String> choices;
  final String answer;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.choices,
    required this.answer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as int,
      question: json['question'] as String,
      choices: List<String>.from(json['choices'] as List),
      answer: json['answer'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices,
      'answer': answer,
    };
  }
}
