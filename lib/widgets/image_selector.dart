import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hack4environment/models/bounding_box.dart';
import 'package:provider/provider.dart';

class SelectorPosition {
  double width;
  double height;
  double offsetLeft = 0;
  double offsetTop = 0;

  SelectorPosition({
    this.width,
    this.height,
    this.offsetLeft,
    this.offsetTop,
  });
}

class Clipper extends StatelessWidget {
  final GlobalKey _imageContainerKey = GlobalKey();
  final GlobalKey _selectorKey = GlobalKey();
  final String imgPath;
  final double minWidth;
  final double minHeight;
  final Color interiorColor;
  final Color borderColor;

  Clipper({
    @required this.imgPath,
    @required this.interiorColor,
    @required this.borderColor,
    this.minWidth = 100,
    this.minHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        key: _imageContainerKey,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                child: Image.file(
                  File(imgPath),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Selector(
              selectorKey: _selectorKey,
              interiorColor: interiorColor,
              borderColor: borderColor,
              getImageSize: getImageSize,
            ),
          ],
        ));
  }

  BoundingBox getSelection() {
    // get image absolute positions
    final RenderBox imgBox =
        _imageContainerKey.currentContext.findRenderObject();
    final imgPos = imgBox.localToGlobal(Offset.zero);
    final imgX = imgPos.dx;
    final imgY = imgPos.dy;
    // get image size
    final imgSize = imgBox.size;
    final imgWidth = imgSize.width;
    final imgHeight = imgSize.height;
    // get selector absolute positions
    final RenderBox selectorBox =
        _selectorKey.currentContext.findRenderObject();
    final selectorPos = selectorBox.localToGlobal(Offset.zero);
    final selectorX = selectorPos.dx;
    final selectorY = selectorPos.dy;
    // get selection size
    final selectorSize = selectorBox.size;
    final selectorWidth = selectorSize.width;
    final selectorHeight = selectorSize.height;
    // calculate relative position
    double xRelative = selectorX - imgX;
    double yRelative = selectorY - imgY;
    // calculate percentage size and dimension
    final x = xRelative / imgWidth;
    final y = yRelative / imgHeight;
    final width = selectorWidth / imgWidth;
    final height = selectorHeight / imgHeight;

    return BoundingBox(
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }

  RenderBox getSelectorRenderBox() =>
      _selectorKey.currentContext.findRenderObject();

  Size getImageSize() {
    // get image absolute positions
    final RenderBox imgBox =
        _imageContainerKey.currentContext.findRenderObject();

    return imgBox.size;
  }
}

class Selector extends StatefulWidget {
  final double initWidth;
  final double initHeight;
  final double minWidth;
  final double minHeight;
  final Color interiorColor;
  final Color borderColor;
  final GlobalKey selectorKey;
  final Function getImageSize;

  Selector({
    this.selectorKey,
    this.initWidth = 200,
    this.initHeight = 200,
    this.minWidth = 100,
    this.minHeight = 100,
    @required this.interiorColor,
    @required this.borderColor,
    @required this.getImageSize,
  });

  @override
  _SelectorState createState() => _SelectorState(
        initWidth,
        initHeight,
      );
}

class SelectorSave {
  double width;
  double height;
  double offsetLeft;
  double offsetTop;

  SelectorSave({
    this.width,
    this.height,
    this.offsetLeft,
    this.offsetTop,
  });
}

class _SelectorState extends State<Selector> {
  double _width;
  double _height;
  double _offsetLeft;
  double _offsetTop;
  bool _moveLeftSide = false;
  bool _moveTopSide = false;
  SelectorSave _save;

  _SelectorState(this._width, this._height);

  @override
  Widget build(BuildContext context) {
    _save = Provider.of<SelectorSave>(context, listen: false);
    _height = _save.height;
    _width = _save.width;
    _offsetLeft = _save.offsetLeft;
    _offsetTop = _save.offsetTop;
    print(_offsetLeft);
    return Column(
      children: [
        SizedBox(height: _offsetTop),
        Row(
          children: [
            SizedBox(width: _offsetLeft),
            GestureDetector(
              onHorizontalDragStart: _getResizeDirectionsX,
              onVerticalDragStart: _getResizeDirectionsY,
              onHorizontalDragUpdate: _resizeHorizontal,
              onVerticalDragUpdate: _resizeVertical,
              child: Container(
                key: widget.selectorKey,
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                    color: widget.interiorColor,
                    border: Border.all(
                      color: widget.borderColor,
                      width: 4,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _getResizeDirectionsX(DragStartDetails dragStartDetails) {
    var x = dragStartDetails.localPosition.dx;
    if (x < (_width / 2)) {
      _moveLeftSide = true;
    } else {
      _moveLeftSide = false;
    }
  }

  void _getResizeDirectionsY(DragStartDetails dragStartDetails) {
    var y = dragStartDetails.localPosition.dy;
    if (y < (_height / 2)) {
      _moveTopSide = true;
    } else {
      _moveTopSide = false;
    }
  }

  void _resizeHorizontal(DragUpdateDetails dragDetails) {
    setState(() {
      var dx = dragDetails.delta.dx;
      if (_moveLeftSide) {
        if (_offsetLeft + dx >= 0) {
          if (_width + dx + _offsetLeft < widget.getImageSize().width) {
            _offsetLeft += dx;
            _width -= dx;
          }
        }
      } else {
        if (_width + dx + _offsetLeft <= widget.getImageSize().width) {
          _width += dx;
        }
      }
      if (_width < widget.minWidth) {
        _width = widget.minWidth;
      }
      _save.width = _width;
      _save.offsetLeft = _offsetLeft;
    });
  }

  void _resizeVertical(DragUpdateDetails dragDetails) {
    setState(() {
      var dy = dragDetails.delta.dy;
      if (_moveTopSide) {
        if (_offsetTop + dy >= 0) {
          if (_height + dy + _offsetTop < widget.getImageSize().height) {
            _offsetTop += dy;
            _height -= dy;
          }
        }
      } else {
        if (_height + dy + _offsetTop <= widget.getImageSize().height) {
          _height += dy;
        }
      }
      if (_height < widget.minHeight) {
        _height = widget.minHeight;
      }
    });

    _save.height = _height;
    _save.offsetTop = _offsetTop;
  }
}
