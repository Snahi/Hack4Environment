import 'dart:io';
import 'package:hack4environment/widgets/image_selector.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';

class LabellingScreen extends StatelessWidget {
  static const String routeName = 'LabellingScreen';
  final String imgPath;
  Clipper _clipper;

  LabellingScreen({@required this.imgPath});

  @override
  Widget build(BuildContext context) {
    _clipper = Clipper(
      imgPath: imgPath,
      interiorColor: Colors.pink,
      borderColor: Colors.blue,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
          child: Column(
        children: [
          _clipper,
          TextButton(
            child: Text('click'),
            onPressed: () {
              Selection sel = _clipper.getSelection();
              print(
                  'x: ${sel.x} y: ${sel.y} width: ${sel.width} height: ${sel.height}');
            },
          )
        ],
      )),
    );
  }
}
