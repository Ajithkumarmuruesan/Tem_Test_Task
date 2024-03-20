import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tem_assessment_firebase/services/firebas_api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardController extends ChangeNotifier {
  File? file;
  UploadTask? uploadTask;
  var fileName;
  List<dynamic> totalList = [];

  Map<String, String> fileTypes = {
    'jpg': 'Image',
    'jpeg': 'Image',
    'png': 'Image',
    'gif': 'Image',
    'bmp': 'Image',
    'mp4': 'Video',
    'avi': 'Video',
    'mov': 'Video',
    'pdf': 'PDF',
    'doc': 'Word',
    'docx': 'Word',
    'txt': 'Text',
  };

  DashBoardController() {
    getFileFromFirebase();
  }

  getfileType(String fileName) {
    String extension = fileName.split('.').last.toLowerCase();
    if (fileTypes.containsKey(extension)) {
      return fileTypes[extension]!;
    } else {
      return 'Unknown File';
    }
  }

  Future getFileFromFirebase() async {
    totalList = [];
    try {
      Reference storageRef = FirebaseStorage.instance.ref().child('files');
      ListResult result = await storageRef.listAll();
      result.items.forEach((Reference ref) async {
        final res = getfileType(ref.fullPath);
        String fullPath = await ref.getDownloadURL();
        totalList.add({'file': fullPath, 'type': res});
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      print('Error listing files: $e');
    }
  }

  Future<void> pickFileFromGallery(BuildContext context) async {
    final res = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (res == null) {
      return;
    }

    final path = res.files.single.path;
    file = File(path!);
    final fileSize = await file!.length();
    final fileSizeInMB = fileSize / (1024 * 1024);
    if (fileSizeInMB > 10) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('File Size Limit Exceeded'),
            content: Text(
                'The selected file exceeds the maximum allowed size of 10MB.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    fileName = path.split('/').last;
    uploadConfirmation(context);
    notifyListeners();
  }

  Future uploadFile() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = false;
    EasyLoading.show();
    try {
      if (file == null) return;
      final des = 'files/$fileName';
      await FireBaseApiServices.uploadTask(des, file!);
      await getFileFromFirebase();
      notifyListeners();
    } catch (e) {}
    EasyLoading.dismiss();
  }

  void uploadConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Upload'),
          content: Text('Do you want to upload the selected file?'),
          actions: <Widget>[
            Text(fileName.toString()),
            TextButton(
              onPressed: () async {
                await uploadFile();
                final snackBar =
                    SnackBar(content: Text('file upload Successfully'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
