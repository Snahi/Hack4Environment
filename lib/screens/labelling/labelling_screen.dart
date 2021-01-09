import 'package:hack4environment/models/bounding_box.dart';
import 'package:hack4environment/services/photo_uploader.dart';
import 'package:hack4environment/widgets/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:hack4environment/resources/strings.dart';
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
  String _selectedLabel = Strings.labels[0];

  @override
  Widget build(BuildContext context) {
    _clipper = Clipper(
      imgPath: widget.imgPath,
      interiorColor: const Color(0x95000000),
      borderColor: Colors.blue,
    );
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _clipper,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _buildLabelDropdown(),
                    SizedBox(height: 16),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelDropdown() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<String>(
          value: _selectedLabel,
          isExpanded: true,
          items: Strings.labels.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedLabel = newValue;
            });
          },
        ),
      );

  Widget _buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            child: Text(Strings.submitPhoto),
            onPressed: _uploadPhoto,
          ),
          TextButton(
            child: Text(Strings.nextLabel),
            onPressed: _nextLabel,
          )
        ],
      );

  void _uploadPhoto() {
    List<BoundingBox> labels = _addToLabels();
    Future<bool> uploadFuture = PhotoUploader.upload(widget.imgPath, labels);
  }

  List<BoundingBox> _addToLabels() {
    BoundingBox box = _clipper.getSelection();
    List<BoundingBox> labels = widget.previousLabels;
    if (labels != null) {
      labels.add(box);
    } else {
      labels = [box];
    }

    return labels;
  }

  void _nextLabel() {
    SelectorSave save = Provider.of<SelectorSave>(context, listen: false);
    save.offsetLeft = LabellingScreen.defaultOffsetLeft;
    save.offsetTop = LabellingScreen.defaultOffsetTop;
    save.width = LabellingScreen.defaultWidth;
    save.height = LabellingScreen.defaultHeight;

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LabellingScreen(
                  imgPath: widget.imgPath,
                  previousLabels: _addToLabels(),
                )));
  }
}
