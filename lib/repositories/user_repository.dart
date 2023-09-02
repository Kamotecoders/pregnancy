import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Create or update user profile
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    await _usersCollection.doc(userId).set(data, SetOptions(merge: true));
  }

  // Get user profile
  Stream<DocumentSnapshot?> getUserProfile(String userId) {
    return _usersCollection.doc(userId).snapshots();
  }

  // Delete user profile (optional)
  Future<void> deleteUserProfile(String userId) async {
    await _usersCollection.doc(userId).delete();
  }
}
