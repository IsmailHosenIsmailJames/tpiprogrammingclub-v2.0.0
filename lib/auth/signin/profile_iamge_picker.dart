import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

Future<String> pickProfilePicMobile(String email) async {
  String url = "";
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowCompression: true,
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: ['jpg', 'png'],
  );
  if (result != null) {
    final tem = result.files.first;
    String? extension = tem.extension;
    File imageFile = File(tem.path!);

    String uploadePath = "user/$email.$extension";
    final ref = FirebaseStorage.instance.ref().child(uploadePath);
    UploadTask uploadTask;
    uploadTask = ref.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    url = await snapshot.ref.getDownloadURL();
  }
  return url;
}

Future<String> pickProfilePicWeb(String email) async {
  String url = "";
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowCompression: true,
      allowedExtensions: ['jpg', 'png']);

  if (result != null) {
    final tem = result.files.first;
    Uint8List? selectedImage = tem.bytes;
    String? extension = tem.extension;
    String uploadePath = "user/$email.$extension";
    final ref = FirebaseStorage.instance.ref().child(uploadePath);
    UploadTask uploadTask;
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    uploadTask = ref.putData(selectedImage!, metadata);
    final snapshot = await uploadTask.whenComplete(() {});
    url = await snapshot.ref.getDownloadURL();
  }
  return url;
}
