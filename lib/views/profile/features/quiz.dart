import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/blocs/assessments/assessment_bloc.dart';
import 'package:pregnancy/models/quiz.dart';
import 'package:pregnancy/repositories/assesment_repository.dart';
import 'package:pregnancy/repositories/auth_repository.dart';
import 'package:pregnancy/utils/constants.dart';
import 'package:pregnancy/widgets/score_container.dart';

import '../../../models/assesments.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentPage = 0;
  List<int> answerList = List.generate(20, (index) => -1);
  String backTitle(int currentPage) {
    if (currentPage == 0) {
      return "back";
    }
    return "previous";
  }

  List<String?> answers = [];
  Future<List<QuizQuestion>> loadJsonData() async {
    try {
      final jsonString =
          await rootBundle.loadString('lib/assets/data/quiz.json');

      final List<dynamic> jsonList = json.decode(jsonString);
      final quiz = jsonList.map((json) => QuizQuestion.fromJson(json)).toList();

      return quiz;
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
                    Text(backTitle(_currentPage))
                  ],
                ), // You can use any custom icon or widget
              ),
              title: Text('${_currentPage + 1}/${quizList.length}'),
              centerTitle: true,
            ),
            body: BlocProvider(
              create: (context) => AssessmentBloc(
                  assessmentRepository: context.read<AssessmentRepository>()),
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
                        child: ListView.builder(
                          key: UniqueKey(),
                          shrinkWrap: true,
                          itemCount: quizList[_currentPage].choices.length,
                          itemBuilder: (BuildContext context, int index) {
                            final isSelected =
                                answerList[_currentPage] == index;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      answerList[_currentPage] = index;
                                    });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (states) {
                                        return isSelected
                                            ? Colors.green
                                            : Colors.white;
                                      },
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      quizList[_currentPage].choices[index],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    BlocConsumer<AssessmentBloc, AssessmentState>(
                      listener: (context, state) {
                        if (state is AssessmentSuccessState<String>) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.data)));
                          context.push('/scores', extra: {
                            'score': calculateScore(quizList, answerList),
                            'answers': answerList,
                            'questions': quizList
                          });
                        }
                        if (state is AssessmentErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                      builder: (context, state) {
                        return state is AssessmentLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : NextOrSubmitButton(
                                isSubmit: _currentPage == quizList.length - 1,
                                onSubmit: () {
                                  Assessments assessment = Assessments(
                                      id: "",
                                      userID: context
                                              .read<AuthRepository>()
                                              .currentUser
                                              ?.uid ??
                                          '',
                                      quizList: quizList,
                                      answers: answerList,
                                      score:
                                          calculateScore(quizList, answerList),
                                      createdAt: DateTime.now());
                                  context
                                      .read<AssessmentBloc>()
                                      .add(AddAssessmentEvent(assessment));
                                },
                                onTap: () {
                                  setState(() {
                                    if (_currentPage < quizList.length) {
                                      _currentPage += 1;
                                    }
                                  });
                                });
                      },
                    )
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
