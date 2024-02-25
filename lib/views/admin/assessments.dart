import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy/models/user_with_assessments.dart';

import 'package:pregnancy/repositories/assesment_repository.dart';

import '../../utils/constants.dart';

class AssessmentsPage extends StatelessWidget {
  const AssessmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserWithAssessments>>(
      stream: context.read<AssessmentRepository>().getUserWithAssessments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final usersWithAssessments = snapshot.data ?? [];
          print(snapshot.data);
          return ListView.builder(
            itemCount: usersWithAssessments.length,
            itemBuilder: (context, index) {
              final userWithAssessments = usersWithAssessments[index];
              return UsersWithAssessments(
                userWithAssessments: userWithAssessments,
              );
            },
          );
        }
      },
    );
  }
}

class UsersWithAssessments extends StatelessWidget {
  final UserWithAssessments userWithAssessments;

  const UsersWithAssessments({Key? key, required this.userWithAssessments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assessment = userWithAssessments.assesments[0];
    final totalmaxScore = userWithAssessments.assesments.length * 100;
    final totalScore = getTotalScore(userWithAssessments.assesments);
    final totalTries = userWithAssessments.assesments.length;

    return Card(
      child: ListTile(
        leading: ClipOval(
          child: Image.network(
            userWithAssessments.users.photo,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          '${userWithAssessments.users.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lastest score: ${assessment.score.toStringAsFixed(2)} / 100",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Assessments : ${userWithAssessments.assesments.length}"),
            Text(
                "Success Rate : ${calculateSuccessRate(totalmaxScore, totalScore, totalTries).toStringAsFixed(2)} %"),
            Text(
                "Latest : ${DateFormat('MMM dd, hh:mm a').format(assessment.createdAt)}"),
          ],
        ),
      ),
    );
  }
}
