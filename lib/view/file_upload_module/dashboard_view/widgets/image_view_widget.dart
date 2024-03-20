import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String fileUrl;

  ImageDialog({required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Image.network(fileUrl),
    );
  }
}
