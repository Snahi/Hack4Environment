import 'package:hack4environment/models/bounding_box.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/screens/labelling/select_category_screen.dart';
import 'package:hack4environment/widgets/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image/image.dart' as imag;
import 'dart:math';

class LabellingScreenArgs {
  final String imgPath;
  final List<BoundingBox> previousLabels;

  LabellingScreenArgs({@required this.imgPath, this.previousLabels});
}

class LabellingScreen extends StatelessWidget {
  static const String routeName = 'LabellingScreen';
  final String imgPath;
  final List<BoundingBox> previousLabels;
  static const double defaultOffsetLeft = 0;
  static const double defaultOffsetTop = 0;
  static const double defaultWidth = 200;
  static const double defaultHeight = 200;

  LabellingScreen({@required this.imgPath, this.previousLabels});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SelectorSave(
          offsetLeft: defaultOffsetLeft,
          offsetTop: defaultOffsetTop,
          width: defaultWidth,
          height: defaultHeight),
      child: LabellingScreenInner(
        imgPath: imgPath,
        previousLabels: previousLabels,
      ),
    );
  }
}

class LabellingScreenInner extends StatefulWidget {
  final String imgPath;
  final List<BoundingBox> previousLabels;

  LabellingScreenInner({@required this.imgPath, this.previousLabels});

  @override
  _LabellingScreenStateInner createState() =>
      _LabellingScreenStateInner(imgPath);
}

class _LabellingScreenStateInner extends State<LabellingScreenInner> {
  Clipper _clipper;
  String imgPath;

  _LabellingScreenStateInner(String imagePath) {
    this.imgPath = cropImage(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    _clipper = Clipper(
      imgPath: widget.imgPath,
      interiorColor: const Color(0x95000000),
      borderColor: Colors.blue,
    );
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _clipper,
          Expanded(
              child: Center(
            child: Container(
              width: 100,
              height: 100,
              child: RawMaterialButton(
                fillColor: CColors.vividGreen,
                shape: CircleBorder(),
                elevation: 4.0,
                child: Icon(
                  Icons.check,
                  color: CColors.darkWhite,
                  size: 60,
                ),
                onPressed: () {
                  var allLabels = _addToLabels();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              SelectCategoryScreen(widget.imgPath, allLabels)));
                },
              ),
            ),
          ))
        ],
      )),
    );
  }

  String cropImage(String imgPath) {
    imag.Image img = imag.decodeImage(File(imgPath).readAsBytesSync());
    // get dimensions
    int width = img.width;
    int height = img.height;
    int shorterSide = min(width, height);
    int longerSide = max(width, height);
    // find center
    int nonZeroCord = (longerSide - shorterSide) ~/ 2;
    // assign top left corner coordinates
    int x, y;
    if (width == shorterSide) {
      x = 0;
      y = nonZeroCord;
    } else {
      x = nonZeroCord;
      y = 0;
    }
    // decrease size to [outputDimension]
    img = imag.copyResize(img, width: shorterSide, height: shorterSide);
    // save processed image
    File(imgPath)..writeAsBytesSync(imag.encodeJpg(img));

    return imgPath;
  }

  List<BoundingBox> _addToLabels() {
    BoundingBox box = _clipper.getSelection();
    List<BoundingBox> labels = [];
    if (widget.previousLabels != null) {
      labels.addAll(widget.previousLabels);
    }
    labels.add(box);

    return labels;
  }
}
