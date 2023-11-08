import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pregnancy/models/quiz.dart';
import 'package:pregnancy/styles/color_pallete.dart';

class AssessmentPage extends StatelessWidget {
  const AssessmentPage({super.key});
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
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "lib/images/assessment_bg.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push('/quiz'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(
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
                      "Start",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
