import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:pregnancy/models/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference collectionReference;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    collectionReference = _firestore.collection('users');
  }

  Future<void> addUser(Users user) async {
    await collectionReference.doc(user.id).set(user.toJson());
  }

  Future<void> updateUserProfile(Users users) async {
    await collectionReference
        .doc(users.id)
        .set(users.toJson(), SetOptions(merge: true));
  }

  Future<void> updateProfileImage(String uid, String imageURL) async {
    await collectionReference.doc(uid).update({'photo': imageURL});
  }

  Future<Users?> getUserProfile(String userId) async {
    final snapshot = await collectionReference.doc(userId).get();
    if (snapshot.exists) {
      return Users.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> deleteUserProfile(String userId) async {
    await collectionReference.doc(userId).delete();
  }

  Future<String?> uploadFile(File file, String uid) async {
    try {
      final Reference storageRef = _storage
          .ref()
          .child('users')
          .child('${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = storageRef.putFile(file);
      await uploadTask.whenComplete(() => null);
      final imageUrl = await storageRef.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}
