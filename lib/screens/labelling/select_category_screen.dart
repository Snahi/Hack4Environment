import 'package:flutter/material.dart';
import 'package:hack4environment/models/bounding_box.dart';
import 'package:hack4environment/resources/c_colors.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/resources/strings.dart';
import 'package:hack4environment/screens/home/home_screen.dart';
import 'package:hack4environment/screens/labelling/labelling_screen.dart';
import 'package:hack4environment/services/photo_uploader.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

// <a href='https://www.freepik.com/vectors/business'>Business vector created by jcomp - www.freepik.com</a>

class SelectCategoryScreen extends StatefulWidget {
  final String imgPath;
  final List<BoundingBox> allBoxes;

  SelectCategoryScreen(this.imgPath, this.allBoxes);

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  String _selectedLabel = Strings.labels[0];
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool isNextButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLabelDropdown(),
              SizedBox(
                height: 16,
              ),
              _buildSubmitButton(),
              SizedBox(
                height: 16,
              ),
              _buildNextPhotoButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelDropdown() => DropdownButton<String>(
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
      );

  Widget _buildSubmitButton() => RoundedLoadingButton(
        child: Text(Strings.submitPhoto, style: TextStyle(color: Colors.white)),
        controller: _btnController,
        onPressed: _uploadPhoto,
        elevation: 0,
      );

  void _uploadPhoto() {
    setState(() {
      isNextButtonEnabled = false;
    });
    widget.allBoxes.last.label = _selectedLabel;
    Future<bool> uploadFuture =
        PhotoUploader.upload(widget.imgPath, widget.allBoxes);
    uploadFuture.then((value) {
      if (value == true) {
        _btnController.success();
        _showSuccessDialog();
      } else {
        _onError();
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(Images.imageSent),
              title: Text(
                Strings.photoUploadedCaption,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(Strings.photoUploadedDesc),
              entryAnimation: EntryAnimation.DEFAULT,
              onOkButtonPressed: _goHome,
              onlyOkButton: true,
            ));
  }

  void _goHome() {
    Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
  }

  void _onError() {
    _btnController.error();

    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: Image.asset(Images.error),
              title: Text(
                Strings.oops,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(Strings.tryAgainLater),
              entryAnimation: EntryAnimation.DEFAULT,
              onOkButtonPressed: _goHome,
              onlyOkButton: true,
            ));
  }

  Widget _buildNextPhotoButton() => FlatButton(
        disabledColor: CColors.gray,
        onPressed: isNextButtonEnabled ? _nextLabel : null,
        child: Text(Strings.nextLabel),
        minWidth: 300,
        height: 50,
        color: CColors.lightBlack,
        textColor: CColors.darkWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
      );

  void _nextLabel() {
    widget.allBoxes.last.label = _selectedLabel;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LabellingScreen(
                  imgPath: widget.imgPath,
                  previousLabels: widget.allBoxes,
                )));
  }
}
