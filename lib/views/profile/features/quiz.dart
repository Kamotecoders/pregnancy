import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/models/quiz.dart';
import 'package:pregnancy/service/quiz_service.dart';
import 'package:pregnancy/widgets/score_container.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentPage = 0;
  String backTitle(int currentPage) {
    if (currentPage == 0) {
      return "back";
    }
    return "previous";
  }

  Future<List<QuizQuestion>> loadJsonData() async {
    try {
      final jsonString =
          await rootBundle.loadString('lib/assets/data/quiz.json');

      final List<dynamic> jsonList = json.decode(jsonString);

      return jsonList.map((json) => QuizQuestion.fromJson(json)).toList();
    } catch (e) {
      print('Error loading JSON: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              width: double.infinity,
              child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Container(
              height: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              width: double.infinity,
              child: Center(child: Text('Error: ${snapshot.error}')));
        } else {
          final quizList = snapshot.data ?? [];
          print("quiz :  ${quizList.length}");
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  if (_currentPage == 0) {
                    context.pop();
                  }
                  setState(() {
                    if (_currentPage > 0) {
                      _currentPage -= 1;
                    }
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios),
                    Text(
                      backTitle(_currentPage),
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ), // You can use any custom icon or widget
              ),
              title: Text('${_currentPage + 1}/${quizList.length}'),
              centerTitle: true,
            ),
            body: RepositoryProvider(
              create: (context) => QuizServiceImpl(questions: quizList),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScoreContainer(score: (_currentPage + 1) * 5),
                    ),
                    QuizQuestionsContainer(question: quizList[_currentPage]),
                    Expanded(
                      child: Center(
                        child: ChoicesList(
                          questionIndex: _currentPage,
                          questions: quizList[_currentPage],
                        ),
                      ),
                    ),
                    NextOrSubmitButton(
                        isSubmit: _currentPage == quizList.length - 1,
                        onSubmit: () {
                          print(context.read<QuizServiceImpl>().getAnswers());
                        },
                        onTap: () {
                          setState(() {
                            if (_currentPage < quizList.length) {
                              _currentPage += 1;
                            }
                          });
                        })
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ChoicesList extends StatefulWidget {
  final int questionIndex;
  final QuizQuestion questions;
  const ChoicesList(
      {super.key, required this.questionIndex, required this.questions});
  @override
  State<ChoicesList> createState() => _ChoicesListState();
}

class _ChoicesListState extends State<ChoicesList> {
  int _selectedIndex = -1;

  String? indexToAlphabet(int index) {
    if (index >= 0 && index < 26) {
      return String.fromCharCode('A'.codeUnitAt(0) + index);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.questions.choices.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (_selectedIndex == index) {
                    return Colors
                        .green; // Change background color when selected
                  }
                  return Colors.white; // Default background color (white)
                }), // Set the button's background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.questions.choices[index],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        _selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuizQuestionsContainer extends StatefulWidget {
  final QuizQuestion question;

  const QuizQuestionsContainer({super.key, required this.question});
  @override
  State<QuizQuestionsContainer> createState() => _QuizQuestionsContainerState();
}

class _QuizQuestionsContainerState extends State<QuizQuestionsContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Center(
              child: Text(
            widget.question.question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          )),
        ),
      ),
    );
  }
}

class NextOrSubmitButton extends StatelessWidget {
  final bool isSubmit;
  final VoidCallback onTap;
  final VoidCallback onSubmit;
  const NextOrSubmitButton(
      {super.key,
      required this.isSubmit,
      required this.onTap,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final result = context.read<QuizServiceImpl>().getAnswers();
    return isSubmit
        ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(
                    0xFF004643)), // Set the button's background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(
                    0xFF004643)), // Set the button's background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
