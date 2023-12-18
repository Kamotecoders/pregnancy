import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pregnancy/models/assesments.dart';

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
}
