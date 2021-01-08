import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class LabellingScreen extends StatelessWidget {
  static const String routeName = 'LabellingScreen';
  final String imgPath;

  LabellingScreen({@required this.imgPath});

  @override
  Widget build(BuildContext context) {
    _crop();
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imgPath)),
    );
  }

  void _crop() async {
    print(imgPath);
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imgPath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
  }
}
