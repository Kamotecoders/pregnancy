import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pregnancy/models/assesments.dart';
import 'package:pregnancy/models/user.dart';
import 'package:pregnancy/models/user_with_assessments.dart';

const ASSESSMENT_COLLECTION = "assessments";

class AssessmentRepository {
  final FirebaseFirestore _firestore;

  AssessmentRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {}

  Future<void> addAssessment(Assessments assessment) {
    assessment.id = _firestore.collection(ASSESSMENT_COLLECTION).doc().id;
    return _firestore
        .collection(ASSESSMENT_COLLECTION)
        .doc(assessment.id)
        .set(assessment.toJson());
  }

  Stream<List<Assessments>> streamAssessmentsByUserID(String userID) {
    return _firestore
        .collection(ASSESSMENT_COLLECTION)
        .where('userID', isEqualTo: userID)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => Assessments.fromJson(doc.data()..['id'] = doc.id))
            .toList());
  }

  Stream<List<UserWithAssessments>> getUserWithAssessments() {
    // Reference to the "users" collection
    CollectionReference usersRef = _firestore.collection("users");

    // Stream the users and their assessments
    return usersRef.snapshots().asyncMap((querySnapshot) async {
      List<UserWithAssessments> usersWithAssessments = [];

      // Loop through each user document
      for (var userDoc in querySnapshot.docs) {
        String userId = userDoc.id;

        Query assessmentsRef = _firestore
            .collection(ASSESSMENT_COLLECTION)
            .orderBy("createdAt", descending: true);

        // Fetch the user's assessments
        QuerySnapshot assessmentsSnapshot = await assessmentsRef.get();
        List<Assessments> assessments = assessmentsSnapshot.docs.map((doc) {
          return Assessments.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
        print(userDoc.data());
        print(assessments);
        List<Assessments> filteredAssessments =
            assessments.where((e) => e.userID == userId).toList();
        if (filteredAssessments.isNotEmpty) {
          filteredAssessments
              .sort((a, b) => b.createdAt.compareTo(a.createdAt));
          usersWithAssessments.add(
            UserWithAssessments(
                users: Users.fromJson(userDoc.data() as Map<String, dynamic>),
                assesments: filteredAssessments),
          );
        }
      }

      // Sort the usersWithAssessments list by the createdAt timestamp of the first assessment
      usersWithAssessments.sort((a, b) =>
          b.assesments[0].createdAt.compareTo(a.assesments[0].createdAt));

      return usersWithAssessments;
    });
  }
}
