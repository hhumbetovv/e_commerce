import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file, String path) async {
    try {
      final reference = _storage.ref().child('$path/${DateTime.now().toString()}');
      final uploadTask = reference.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteImageByUrl(String imageUrl) async {
    Uri uri = Uri.parse(imageUrl);
    String fileName = uri.pathSegments.last;
    try {
      final ref = _storage.ref().child(fileName);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }
}
