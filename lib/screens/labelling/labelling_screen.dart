import 'package:hack4environment/models/bounding_box.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/screens/labelling/select_category_screen.dart';
import 'package:hack4environment/widgets/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  _LabellingScreenStateInner createState() => _LabellingScreenStateInner();
}

class _LabellingScreenStateInner extends State<LabellingScreenInner> {
  Clipper _clipper;

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
            child: SizedBox(),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: CColors.darkWhite,
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
    );
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
