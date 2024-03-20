import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseApiServices {
  static UploadTask? uploadTask(String destination, File file) {
    try {
      final res = FirebaseStorage.instance.ref(destination);
      return res.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
