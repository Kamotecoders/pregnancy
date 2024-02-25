import 'package:pregnancy/models/assesments.dart';
import 'package:pregnancy/models/user.dart';

class UserWithAssessments {
  Users users;
  List<Assessments> assesments;
  UserWithAssessments({required this.users, required this.assesments});
}
