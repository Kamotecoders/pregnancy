import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pregnancy/models/modules.dart';

class FileRepository {
  final String COLLECTION_NAME = 'modules';
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  FileRepository(
      {FirebaseStorage? firebaseStorage, FirebaseFirestore? firebaseFirestore})
      : _storage = firebaseStorage ?? FirebaseStorage.instance,
        _firestore = firebaseFirestore ?? FirebaseFirestore.instance {}

  Future<String> uploadFile(File file) async {
    try {
      Reference storageReference = _storage
          .ref()
          .child('modules/${Uri.parse(file.path).pathSegments.last}');
      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveModule(Module module) {
    module.id = _firestore.collection(COLLECTION_NAME).doc().id;
    return _firestore
        .collection(COLLECTION_NAME)
        .doc(module.id)
        .set(module.toJson());
  }

  Future<void> deleteModuleAndFile(String moduleID, String filePath) async {
    try {
      print('File deleted successfully.');

      // Delete the document in Firestore
      await _firestore.collection(COLLECTION_NAME).doc(moduleID).delete();
      print('Module deleted successfully.');
    } catch (error) {
      print('Error deleting module and file: $error');
      // Handle the error as needed
    }
  }

  Stream<List<Module>> fetchModulesStream() {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
          _firestore.collection(COLLECTION_NAME).snapshots();

      // Transform the stream of snapshots into a stream of Module lists
      Stream<List<Module>> moduleStream = snapshots.map(
        (querySnapshot) {
          return querySnapshot.docs
              .map((doc) => Module.fromJson(doc.data()))
              .toList();
        },
      );

      return moduleStream;
    } catch (error) {
      print('Error fetching modules: $error');
      // If an error occurs, return an empty stream or handle it accordingly
      return Stream.value([]);
    }
  }

  Future<List<Map<String, String>>> getAllModules() async {
    try {
      ListResult listResult = await _storage.ref().child('modules').listAll();

      List<Map<String, String>> moduleInfoList = [];

      for (var item in listResult.items) {
        final downloadURL = await item.getDownloadURL();
        final name = item.name;

        moduleInfoList.add({
          'name': name,
          'downloadURL': downloadURL,
        });
      }

      return moduleInfoList;
    } catch (e) {
      rethrow;
    }
  }
}
