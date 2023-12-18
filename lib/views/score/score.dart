import 'package:flutter/material.dart';
import 'package:pregnancy/models/quiz.dart';
import 'package:pregnancy/utils/constants.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final List<int> answers;
  final List<QuizQuestion> questions;
  const ScorePage(
      {super.key,
      required this.score,
      required this.answers,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    print(answers);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assessment Result"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${score} / 100',
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Your Score",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return QuestionCard(
                      question: questions[index], answer: answers[index]);
                }),
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final QuizQuestion question;
  final int answer;
  const QuestionCard({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              question.question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: question.choices.length,
              itemBuilder: (BuildContext context, int index) {
                final isCorrect = question.answer == indexToAlphabet(answer);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            return index == answer
                                ? isCorrect
                                    ? Colors.green
                                    : Colors.red
                                : Colors.white;
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          question.choices[index],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: index == answer
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
