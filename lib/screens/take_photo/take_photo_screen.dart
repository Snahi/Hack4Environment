import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hack4environment/resources/images.dart';
import 'package:hack4environment/screens/labelling/labelling_screen.dart';

class TakePhotoScreen extends StatefulWidget {
  static const String routeName = 'TakePhotoScreen';

  const TakePhotoScreen({
    Key key,
  }) : super(key: key);

  @override
  TakePhotoScreenState createState() => TakePhotoScreenState();
}

class TakePhotoScreenState extends State<TakePhotoScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  CameraDescription _camera;
  Future<void> _initializeFuture;

  @override
  void initState() {
    super.initState();
    _initializeFuture = _initCamera();
  }

  Future<void> _initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    _camera = cameras.first;
    _controller = CameraController(
      _camera,
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFuture,
        builder: (context, snapshot) => FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return _buildContent();
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCameraPreview(context),
          Expanded(
              child: GestureDetector(
            onTap: _onTakePhotoClicked,
            child: Center(
              child: CircleAvatar(
                child: Image.asset(Images.takePhoto),
                radius: 36,
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _onTakePhotoClicked() async {
    try {
      await _initializeControllerFuture;
      String path = (await _controller.takePicture()).path;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LabellingScreen(imgPath: path),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Widget _buildCameraPreview(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / (size.height * 0.7);
    return Container(
      child: Transform.scale(
        scale: _controller.value.aspectRatio / deviceRatio,
        child: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: CameraPreview(_controller),
          ),
        ),
      ),
    );
  }
}
