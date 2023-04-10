import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadDocImage(File imageFile) async {
    final List<String> assetPaths = [
      'assets/images/doc1.png',
      'assets/images/doc2.png',
      'assets/images/doc3png',
      'assets/images/doc4png',
      'assets/images/doc5.png',
    ];
    for (String assetPath in assetPaths) {
      final File file = File(path.join('assets', assetPath));
      final String fileName = path.basenameWithoutExtension(file.path);
      final Reference storageRef = storage.ref().child('images/$fileName');
      final UploadTask uploadTask = storageRef.putFile(file);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      print('Uploaded file $assetPath to $url');
    }
    return null;
  }
}
