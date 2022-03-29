import 'dart:io';

import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String imageName) async {
    final File file = File(filePath);
    try {
      await storage.ref(destinationForImages(imageName)).putFile(file);
    } catch (e) {
      showToastError(text: genericErrorLabel);
    }
  }

  Future<ListResult> listImages() async {
    final ListResult result = await storage.ref(imageBucketLabel).listAll();

    return result;
  }

  Future<String> downloadImageUrl(String imageName) async {
    final String downloadUrl =
        await storage.ref(destinationForImages(imageName)).getDownloadURL();
    return downloadUrl;
  }
}
