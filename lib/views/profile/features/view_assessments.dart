import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/models/assesments.dart';
import 'package:pregnancy/repositories/assesment_repository.dart';
import 'package:pregnancy/repositories/auth_repository.dart';

import '../../../utils/constants.dart'; // Make sure to import the correct model

class ViewAssessmentPage extends StatelessWidget {
  const ViewAssessmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Assessments'),
      ),
      body: StreamBuilder<List<Assessments>>(
        stream: context.read<AssessmentRepository>().streamAssessmentsByUserID(
            context.read<AuthRepository>().currentUser?.uid ?? ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No assessments found.'),
            );
          } else {
            // Render the list of assessments
            List<Assessments> assessments = snapshot.data!;
            return ListView.builder(
              itemCount: assessments.length,
              itemBuilder: (context, index) {
                final assessment = assessments[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.push('/scores', extra: {
                        'score': calculateScore(
                            assessment.quizList, assessment.answers),
                        'answers': assessment.answers,
                        'questions': assessment.quizList
                      });
                    },
                    title: Text('Assessment #${assessments.length - index}'),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('MM/dd/yyyy hh:mm a')
                            .format(assessments[index].createdAt)),
                        Text(
                          "Score: ${assessments[index].score} / 100",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
