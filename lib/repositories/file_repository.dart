import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FileRepository {
  final FirebaseStorage _storage;
  FileRepository({FirebaseStorage? firebaseStorage})
      : _storage = firebaseStorage ?? FirebaseStorage.instance {}

  Future<String> uploadFile(File file) async {
    try {
      Reference storageReference = _storage
          .ref()
          .child('modules/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(file);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      rethrow;
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
